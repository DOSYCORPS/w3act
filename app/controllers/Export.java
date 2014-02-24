package controllers;

import static play.data.Form.form;

import java.io.StringWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import models.DCollection;
import models.LookupEntry;
import models.Organisation;
import models.Target;
import models.Taxonomy;
import models.User;

import org.apache.commons.lang3.StringUtils;

import play.Logger;
import play.data.DynamicForm;
import play.libs.Json;
import play.mvc.BodyParser;
import play.mvc.Result;
import play.mvc.Security;
import uk.bl.Const;
import uk.bl.api.Utils;
import views.html.article;
import views.html.targets.list;
import views.html.targets.targetedit;
import views.html.targets.targets;
import views.html.collections.collectionsites;
import views.html.settings.export;

import com.avaje.ebean.ExpressionList;
import com.avaje.ebean.Page;
import com.fasterxml.jackson.databind.JsonNode;

import views.html.users.*;

/**
 * Manage targets.
 */
@Security.Authenticated(Secured.class)
public class Export extends AbstractController {
  
    /**
     * Display the export.
     */
    public static Result index() {
		return ok(
	            export.render("Export", User.find.byId(request().username()))
	        );
    }
    
    /**
     * This method exports selected lookups to CSV file.
     * @param list of Target objects
     * @return
     */
    public static void exportLookup(List<LookupEntry> lookupList) {
    	Logger.info("export lookups size: " + lookupList.size());

        StringWriter sw = new StringWriter();
	    
		sw.append(Const.URL);
 	    sw.append(Const.CSV_SEPARATOR);
		sw.append(Const.VALUE);
		sw.append(Const.CSV_LINE_END);
 	    if (lookupList != null && lookupList.size() > 0) {
 	    	Iterator<LookupEntry> itr = lookupList.iterator();
 	    	while (itr.hasNext()) {
 	    		LookupEntry lookupEntry = (LookupEntry) itr.next();
 	    		if (lookupEntry.name != null) {
 	    			sw.append(lookupEntry.name);
 	    			sw.append(Const.CSV_SEPARATOR);
 	    			Logger.info("add entry: " + lookupEntry.name + ", value: "+ lookupEntry.value.toString() + ", " + 
 	    					Utils.getNormalizeBooleanString(String.valueOf(lookupEntry.value.booleanValue())));
 	    			if (lookupEntry.value.booleanValue()) {
 	    				sw.append(Const.YES);
 	    			} else {
 	    				sw.append(Const.NO);
 	    			}
 	    			sw.append(Const.CSV_LINE_END);
 	    		}
 	    	}
 	    }

    	Utils.generateCsvFile(Const.EXPORT_LOOKUP_FILE, sw.toString());
    }
    
    /**
     * This method enables searching for given URL and redirection in order to add new entry
     * if required.
     * @return
     */
    public static Result search() {
    	
    	DynamicForm form = form().bindFromRequest();
    	String action = form.get(Const.ACTION);
    	Logger.info("action: " + action);
    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.EXPORT_LOOKUPS.equals(action)) {
    			exportLookup(LookupEntry.findAll());    			
    		} 
    	}
    	return GO_EXPORT_HOME;
    }
            
    public static Result GO_EXPORT_HOME = redirect(
            routes.Export.index()
        );
    
}
