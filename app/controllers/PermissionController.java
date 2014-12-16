package controllers;

import static play.data.Form.form;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.avaje.ebean.Ebean;
import com.fasterxml.jackson.databind.JsonNode;

import models.Permission;
import models.Target;
import models.User;
import play.Logger;
import play.data.DynamicForm;
import play.data.Form;
import play.libs.Json;
import play.mvc.BodyParser;
import play.mvc.Result;
import play.mvc.Security;
import uk.bl.Const;
import views.html.permissions.*;

/**
 * Manage permissions.
 */
@Security.Authenticated(SecuredController.class)
public class PermissionController extends AbstractController {
  
    /**
     * Display the permission.
     */
    public static Result index() {
    	Logger.info("Permissions.index()");
        return GO_HOME;
    }
    
    public static Result GO_HOME = redirect(
            routes.PermissionController.list(0, "name", "asc", "")
        );
    
    /**
     * Display the permission edit panel for this URL.
     */
    public static Result edit(Long id) {
		Permission permission = Permission.findById(id);
		Form<Permission> permissionFormNew = Form.form(Permission.class);
		permissionFormNew = permissionFormNew.fill(permission);
      	return ok(
	              edit.render(permissionFormNew, User.findByEmail(request().username()))
	            );
    }
    
    public static Result view(Long id) {
        return ok(
                view.render(
                        Permission.findById(id), User.findByEmail(request().username())
                )
            );
    }
    
    /**
     * This method enables searching for given URL and redirection in order to add new entry
     * if required.
     * @return
     */
    public static Result search() {
        
    	DynamicForm form = form().bindFromRequest();
    	String action = form.get("action");
    	String query = form.get(Const.QUERY);
		Logger.info("query: " + query);
		Logger.info("action: " + action);
    	
    	if (StringUtils.isBlank(query)) {
			Logger.info("Permission name is empty. Please write name in search window.");
			flash("message", "Please enter a name in the search window");
	        return redirect(
	        		routes.PermissionController.list(0, "name", "asc", "")
	        );
    	}

    	int pageNo = getQueryParamAsInt(Const.PAGE_NO, 0);
    	String sort = getQueryParam(Const.SORT_BY);
    	String order = getQueryParam(Const.ORDER);

    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.ADDENTRY.equals(action)) {
    	    	Permission permission = new Permission();
    	    	permission.name = query;
    	        permission.id = Target.createId();
    	        permission.url = Const.ACT_URL + permission.id;
    			Logger.info("add permission entry with url: " + permission.url + ", and name: " + permission.name);
    			Form<Permission> permissionFormNew = Form.form(Permission.class);
    			permissionFormNew = permissionFormNew.fill(permission);
    	      	return ok(
    		              edit.render(permissionFormNew, User.findByEmail(request().username()))
    		            );
    		} 
    		else if (Const.SEARCH.equals(action)) {
    	    	return redirect(routes.PermissionController.list(pageNo, sort, order, query));
		    } else {
		      return badRequest("This action is not allowed");
		    }
    	}               
        
    }	   
    
    /**
     * Add new permission entry.
     * @param permission title
     * @return
     */
    public static Result create(String name) {
    	Permission permission = new Permission();
    	permission.name = name;
        permission.id = Target.createId();
        permission.url = Const.ACT_URL + permission.id;
		Logger.info("add permission entry with url: " + permission.url + ", and name: " + permission.name);
		Form<Permission> permissionFormNew = Form.form(Permission.class);
		permissionFormNew = permissionFormNew.fill(permission);
      	return ok(
	              edit.render(permissionFormNew, User.findByEmail(request().username()))
	            );
    }
      
	/**
	 * This method prepares Permission form for sending info message
	 * about errors 
	 * @return edit page with form and info message
	 */
	public static Result info() {
    	Permission permission = new Permission();
    	permission.id = Long.valueOf(getFormParam(Const.ID));
    	permission.url = getFormParam(Const.URL);
        permission.name = getFormParam(Const.NAME);
	    if (getFormParam(Const.DESCRIPTION) != null) {
	    	permission.description = getFormParam(Const.DESCRIPTION);
	    }
	    if (permission.revision == null) {
	    	permission.revision = "";
	    }
        if (getFormParam(Const.REVISION) != null) {
        	permission.revision = getFormParam(Const.REVISION);
        }
		Form<Permission> permissionFormNew = Form.form(Permission.class);
		permissionFormNew = permissionFormNew.fill(permission);
      	return ok(
	              edit.render(permissionFormNew, User.findByEmail(request().username()))
	            );
    }
    
    /**
     * This method saves new object or changes on given Permission in the same object
     * completed by revision comment. The "version" field in the Permission object
     * contains the timestamp of the change. 
     * @return
     */
    public static Result save() {
    	Result res = null;
        String save = getFormParam(Const.SAVE);
        String delete = getFormParam(Const.DELETE);
//        Logger.info("save: " + save);
        if (save != null) {
        	Logger.info("save permission id: " + getFormParam(Const.ID) + ", url: " + getFormParam(Const.URL) + 
        			", name: " + getFormParam(Const.NAME) + ", revision: " + getFormParam(Const.REVISION));
        	Form<Permission> permissionForm = Form.form(Permission.class).bindFromRequest();
            if(permissionForm.hasErrors()) {
            	String missingFields = "";
            	for (String key : permissionForm.errors().keySet()) {
            	    Logger.debug("key: " +  key);
            	    if (missingFields.length() == 0) {
            	    	missingFields = key;
            	    } else {
            	    	missingFields = missingFields + Const.COMMA + " " + key;
            	    }
            	}
            	Logger.info("form errors size: " + permissionForm.errors().size() + ", " + missingFields);
	  			flash("message", "Please fill out all the required fields, marked with a red star." + 
	  					"Missing fields are " + missingFields);
	  			return info();
            }
        	Permission permission = null;
            boolean isExisting = true;
            try {
                try {
//                	permission = Permission.findByUrl(getFormParam(Const.URL));
                } catch (Exception e) {
                	Logger.info("is not existing exception");
                	isExisting = false;
                	permission = new Permission();
                	permission.id = Long.valueOf(getFormParam(Const.ID));
                	permission.url = getFormParam(Const.URL);
                }
                if (permission == null) {
                	Logger.info("is not existing");
                	isExisting = false;
                	permission = new Permission();
                	permission.id = Long.valueOf(getFormParam(Const.ID));
                	permission.url = getFormParam(Const.URL);
                }
                
                permission.name = getFormParam(Const.NAME);
        	    if (getFormParam(Const.DESCRIPTION) != null) {
        	    	permission.description = getFormParam(Const.DESCRIPTION);
        	    }
        	    if (permission.revision == null) {
        	    	permission.revision = "";
        	    }
                if (getFormParam(Const.REVISION) != null) {
                	permission.revision = getFormParam(Const.REVISION);
                }
            } catch (Exception e) {
            	Logger.info("Permission not existing exception");
            }
            
        	if (!isExisting) {
               	Ebean.save(permission);
    	        Logger.info("save permission: " + permission.toString());
        	} else {
           		Logger.info("update permission: " + permission.toString());
               	Ebean.update(permission);
        	}
	        res = redirect(routes.PermissionController.edit(permission.id));
        } 
        if (delete != null) {
//        	Permission permission = Permission.findByUrl(getFormParam(Const.URL));
//        	Ebean.delete(permission);
	        res = redirect(routes.PermissionController.index()); 
        }
        return res;
    }	   

    @BodyParser.Of(BodyParser.Json.class)
    public static Result filterByJson(String name) {
        JsonNode jsonData = null;
        if (name != null) {
	        List<Permission> permissions = Permission.filterByName(name);
	        jsonData = Json.toJson(permissions);
        }
        return ok(jsonData);
    }
    
    /**
     * Display the paginated list of Curators.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     */
    public static Result list(int pageNo, String sortBy, String order, String filter) {
    	Logger.info("Permissions.list()");
        return ok(
        	list.render(
        			"Permissions", 
        			User.findByEmail(request().username()), 
        			filter, 
        			Permission.page(pageNo, 10, sortBy, order, filter), 
        			sortBy, 
        			order)
        	);
    }    
}
