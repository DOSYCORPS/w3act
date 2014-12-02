package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import models.CrawlPermission;
import models.Collection;
import models.Flag;
import models.License;
import models.Organisation;
import models.Tag;
import models.Target;
import models.Taxonomy;
import models.User;
import play.Logger;
import play.Play;
import play.data.DynamicForm;
import play.data.Form;
import play.libs.Json;
import play.mvc.BodyParser;
import play.mvc.Result;
import play.mvc.Security;
import scala.NotImplementedError;
import uk.bl.Const;
import uk.bl.api.Utils;
import uk.bl.exception.WhoisException;
import uk.bl.scope.Scope;
import views.html.collections.sites;
import views.html.licence.ukwalicenceresult;
import views.html.infomessage;

import com.avaje.ebean.Ebean;
import com.avaje.ebean.Expr;
import com.avaje.ebean.ExpressionList;
import com.avaje.ebean.Page;
import com.fasterxml.jackson.databind.JsonNode;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.Channel;

import views.html.targets.blank;
import views.html.targets.edit;
import views.html.targets.list;
import views.html.targets.lookup;
import views.html.targets.view;
import views.html.users.usersites;


/**
 * Describe W3ACT project.
 */
@Security.Authenticated(Secured.class)
public class TargetController extends AbstractController {
  
    final static play.data.Form<Target> targetForm = play.data.Form.form(Target.class);

    /**
     * Display the targets.
     */
    public static Result index() {
        return GO_HOME;
    }

    /**
     * Display the paginated list of targets.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     */
    public static Result lookup(int pageNo, String sortBy, String order, String filter) {
    	Logger.info("TargetController.lookup()");
    	
    	Page<Target> pages = Target.find.fetch("fieldUrls").where()
			.eq(Const.ACTIVE, true)
			.add(Expr.or(Expr.icontains("fieldUrls.url", filter), Expr.icontains("t0.title", filter)))
			.orderBy("t0.title" + " " + order)
			.findPagingList(10)
			.setFetchAhead(false).getPage(pageNo);
    	
    	Logger.info("Total: " + pages.getTotalRowCount());
    	
        return ok(
        	lookup.render(
        			"Lookup", 
        			User.findByEmail(request().username()), 
        			filter, 
        			pages, 
        			sortBy, 
        			order)
        	);
    }
    
    /**
     * Display the paginated list of targets.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     * @param curator Author of the target
     * @param organisation The author's organisation
     * @param subject Target subject
     * @param crawlFrequency The crawl frequency
     * @param depth The crawl depth
     * @param collection The associated collection
     * @param license The license name
     * @param pageSize The number of Target entries on the page
     * @param flag The flag assigned by user
     */
    public static Result list(int pageNo, String sortBy, String order, String filter, String curator, String organisation, String subject, 
    		String crawlFrequency, String depth, String collection, String license, int pageSize, String flag) {
    	Logger.info("Pre Targets.list() subject: " + subject);
    	
    	Page<Target> pageTargets = Target.pageTargets(pageNo, pageSize, sortBy, order, filter, curator, organisation, subject, crawlFrequency, depth, collection, license, flag);
    	
    	List<License> licenses = License.findAllLicenses();
    	Logger.info("Targets.list() licenses: " + licenses);
    	
        return ok(list.render(
			"Targets", 
			User.findByEmail(request().username()), 
			filter,
			pageTargets,
			sortBy, 
			order, 
	    	curator, 
	    	organisation, 
	    	subject, 
	    	crawlFrequency, 
	    	depth, 
	    	collection, 
	    	license, 
	    	pageSize,
	    	flag,
	    	licenses)
		);
    }
    
    public static Result view(Long id) {
    	Target target = Target.findById(id);
    	User user = User.findByEmail(request().username());
        return ok(view.render(target, user));
    }
    
    public static Result viewAct(String url) {
    	Target target = Target.findByUrl(url);
    	User user = User.findByEmail(request().username());
        return ok(view.render(target, user));
    }

    public static Result viewWct(String url) {
    	Target target = Target.findByWct(url);
    	User user = User.findByEmail(request().username());
        return ok(view.render(target, user));
    }

	/**
	 * This method filters targets by given URLs.
	 * @return duplicate count
	 */
	public static List<Target> getSubjects() {
		List<Target> res = new ArrayList<Target>();
//		List<String> subjects = new ArrayList<String>();
		List<Target> allTargets = Target.find.all();
		Iterator<Target> itr = allTargets.iterator();
//		while (itr.hasNext()) {
//			Target target = itr.next();
//			if (target.fieldSubject != null && target.fieldSubject.length() > 0 && !res.contains(target)) {
////				if (target.field_subject != null && target.field_subject.length() > 0 && !subjects.contains(target.field_subject)) {
//		        ExpressionList<Target> ll = Target.find.where().contains("field_subject", target.fieldSubject);
//		        if (ll.findRowCount() > 0) {
////		        	subjects.add(target.field_subject);
//		        	res.add(target);
//		        }
//			}
//		}
//    	return res;
		throw new NotImplementedError();
	}
	
	/**
	 * This method filters targets by given scope.
	 * @return scope list
	 */
	public static List<Target> getScope() {
		List<Target> res = new ArrayList<Target>();
		List<String> subjects = new ArrayList<String>();
		List<Target> allTargets = Target.find.all();
		Iterator<Target> itr = allTargets.iterator();
		while (itr.hasNext()) {
			Target target = itr.next();
			if (target.field_scope != null && target.field_scope.length() > 0 && !subjects.contains(target.field_scope)) {
		        ExpressionList<Target> ll = Target.find.where().contains("field_scope", target.field_scope);
		        if (ll.findRowCount() > 0) {
		        	res.add(target);
		        	subjects.add(target.field_scope);
		        }
			}
		}
    	return res;
	}
	
	/**
	 * This method retrieves targets from database for given taxonomy URL.
	 * @param url
	 * @return
	 */
	public static List<Target> getTargetsForTaxonomy(String url) {
		List<Target> res = new ArrayList<Target>();
//		Logger.info("url: " + url);
		if (url != null) {
	        ExpressionList<Target> ll = Target.find.where().contains(Const.FIELD_COLLECTION_CATEGORIES, url);
	        res = ll.findList();
		}
//		Logger.info("res size: " + res.size());
		return res;
	}
	
	/**
	 * This method filters targets by given license.
	 * @return license list
	 */
//	public static List<Taxonomy> getLicense() {
//		List<Taxonomy> licenses = new ArrayList<Taxonomy>();
//		List<String> subjects = new ArrayList<String>();
//		
//		List<Target> allTargets = Target.find.all();
//		
//		Iterator<Target> itr = allTargets.iterator();
//		while (itr.hasNext()) {
//			Target target = itr.next();
//			if (target.fieldLicense != null) {
//				String curLicense = target.fieldLicense.replace(Const.LIST_DELIMITER, "");
//				if (curLicense.length() > 0 && !subjects.contains(curLicense)) {
//			        ExpressionList<Target> ll = Target.find.where().contains(Const.FIELD_LICENSE_NODE, curLicense);
//			        if (ll.findRowCount() > 0) {
//			        	Taxonomy taxonomy = Taxonomy.findByUrl(curLicense);
//			        	Logger.info("curLicense: " + curLicense + ".");
//	//		        	Logger.info("taxonomy url: " + taxonomy.url);
//	//		        	Logger.info("license: " + taxonomy.name);
//			        	licenses.add(taxonomy);
//			        	subjects.add(curLicense);
//			        }
//				}
//			}
//		}
////		Logger.info("getLicense res: " + res);
//    	return licenses;
////		throw new NotImplementedError();
//	}
	
	/**
	 * This method returns all possible licenses.
	 * @return license list
	 */
	public static List<Taxonomy> getLicenses() {
		List<Taxonomy> res = new ArrayList<Taxonomy>();
		res = Taxonomy.findByType(Const.LICENCE);
    	return res;
	}
	
	/**
	 * This method filters targets by crawl frequency.
	 * @return crawl frequency list
	 */
	public static List<Target> getCrawlFrequency() {
		List<Target> res = new ArrayList<Target>();
		List<String> subjects = new ArrayList<String>();
		List<Target> allTargets = Target.find.all();
		Iterator<Target> itr = allTargets.iterator();
		while (itr.hasNext()) {
			Target target = itr.next();
			if (target.field_crawl_frequency != null && target.field_crawl_frequency.length() > 0 && !subjects.contains(target.field_crawl_frequency)) {
		        ExpressionList<Target> ll = Target.find.where().contains(Const.FIELD_CRAWL_FREQUENCY, target.field_crawl_frequency);
		        if (ll.findRowCount() > 0) {
		        	res.add(target);
		        	subjects.add(target.field_crawl_frequency);
		        }
			}
		}
    	return res;
	}
	
	/**
	 * This method filters targets by depth.
	 * @return depth list
	 */
	public static List<Target> getDepth() {
		List<Target> res = new ArrayList<Target>();
		List<String> subjects = new ArrayList<String>();
		List<Target> allTargets = Target.find.all();
		Iterator<Target> itr = allTargets.iterator();
		while (itr.hasNext()) {
			Target target = itr.next();
			if (target.field_depth != null && target.field_depth.length() > 0 && !subjects.contains(target.field_depth)) {
		        ExpressionList<Target> ll = Target.find.where().contains(Const.FIELD_DEPTH, target.field_depth);
		        if (ll.findRowCount() > 0) {
		        	res.add(target);
		        	subjects.add(target.field_depth);
		        }
			}
		}
    	return res;
	}
	
	/**
	 * This method filters targets by collection categories.
	 * @return collection categories list
	 */
	public static List<Taxonomy> getCollectionCategories() {
//		List<Target> res = new ArrayList<Target>();
//		List<String> subjects = new ArrayList<String>();
//		List<Taxonomy> taxonomies = new ArrayList<Taxonomy>();
//		List<Target> allTargets = Target.find.all();
//		Iterator<Target> itr = allTargets.iterator();
//		while (itr.hasNext()) {
//			Target target = itr.next();
//			if (target.collections != null && !subjects.contains(target.fieldCollectionCategories)) {
//		        ExpressionList<Target> ll = Target.find.where().contains(Const.FIELD_COLLECTION_CATEGORIES, target.fieldCollectionCategories);
//		        if (ll.findRowCount() > 0) {
//		        	res.add(target);
//		        	subjects.add(target.fieldCollectionCategories);
//		        	Taxonomy taxonomy = Taxonomy.findByUrl(target.fieldCollectionCategories);
//		        	taxonomies.add(taxonomy);
//		        }
//			}
//		}
//    	return taxonomies;
		throw new NotImplementedError();
	}
	

    @BodyParser.Of(BodyParser.Json.class)
    public static Result filterByJson(String url) {
        JsonNode jsonData = null;
        if (url != null) {
	        List<Target> targets = Target.filterActiveUrl(url);
	        jsonData = Json.toJson(targets);
        }
        return ok(jsonData);
    }

    /**
     * This method enables searching for given URL and redirection in order to add new entry
     * if required.
     * @return
     */
    public static Result searchTargets() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	Logger.debug("page size: " + getFormParam(Const.PAGE_SIZE));
        if (form.get(Const.PAGE_SIZE) == null 
        		|| (form.get(Const.PAGE_SIZE) != null 
        		   && !Utils.isNumeric(form.get(Const.PAGE_SIZE)))) {
            Logger.info("You may only enter a numeric page size.");
  			flash("message", "You may only enter a numeric page size.");
	        return GO_HOME;
    	}    	
    	
    	String action = form.get("action");
    	String query = form.get("url");

//    	if (StringUtils.isBlank(query)) {
//			Logger.info("Target name is empty. Please write name in search window.");
//			flash("message", "Please enter a name in the search window");
//	        return GO_HOME;
//    	}    	

    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);
    	int pageSize = Integer.parseInt(form.get(Const.PAGE_SIZE));
    	String curator_name = form.get(Const.AUTHOR);
    	String curator = "";
    	if (curator_name != null && !curator_name.toLowerCase().equals(Const.NONE)) {
    		try {
    			curator = User.findByName(curator_name).url;
    		} catch (Exception e) {
    			Logger.info("Can't find curator for name: " + curator_name + ". " + e);
    		}
    	} 
    	String organisation_name = form.get(Const.FIELD_NOMINATING_ORGANISATION);
    	String organisation = "";
    	if (organisation_name != null && !organisation_name.toLowerCase().equals(Const.NONE)) {
    		try {
    			organisation = Organisation.findByTitle(organisation_name).url;
    		} catch (Exception e) {
    			Logger.info("Can't find organisation for title: " + organisation_name + ". " + e);
    		}
    	} 
    	
//		String subject_name = Utils.removeDuplicatesFromList(form.get(Const.TREE_KEYS));
//    	String subject = "";
//		if (subject_name != null) {
//			if (!subject_name.toLowerCase().equals(Const.NONE)) {
//				subject = Taxonomy.findByUrlExt(subject_name).url;
//			} else {
//				subject = "";
//			}
//		}
		
    	String subject = Const.EMPTY;
        if (form.get(Const.SUBJECT) != null) {
        	String subjectListStr = Utils.removeDuplicatesFromList(form.get(Const.SUBJECT));
        	if (subjectListStr != null && subjectListStr.length() > 0
        			&& subjectListStr.toLowerCase().contains(Const.NONE)
        			&& subjectListStr.contains(Const.COMMA)) {
        		if (subjectListStr.contains(Const.NONE_VALUE + Const.COMMA + " ")) {
        			subjectListStr = subjectListStr.replace(Const.NONE_VALUE + Const.COMMA + " ", "");
        		}
        		if (subjectListStr.contains(Const.COMMA + " " + Const.NONE_VALUE)) {
        			subjectListStr = subjectListStr.replace(Const.COMMA + " " + Const.NONE_VALUE, "");
        		}     		
        	}
        	subject = subjectListStr;
        	subject = Utils.cutFirstSelection(subject);
        	if (subject.length() == 0) {
        		subject = Const.EMPTY;
        	}
            if (subject.equals(Const.NONE_VALUE)) {
            	subject = Const.NONE;
            }
        }            	
		Logger.debug("subject: " + subject);
		
//    	String subject_name = form.get(Const.FIELD_SUBJECT);
//    	String subject = "";
//    	if (subject_name != null && !subject_name.toLowerCase().equals(Const.NONE)) {
//    		try {
//    			Logger.info("find subject for title: " + subject_name + ". " + subject_name.length());
//           		subject = Taxonomy.findByNameConf(subject_name).url;
//    		} catch (Exception e) {
//    			Logger.info("Can't find subject for name: " + subject_name + ". " + e);
//    		}
//    	} 
    	String collection = Const.NONE;
        if (form.get(Const.TREE_KEYS) != null) {
    		collection = Utils.removeDuplicatesFromList(form.get(Const.TREE_KEYS));
    		collection = Utils.cutFirstSelection(collection);
        }
		Logger.debug("collection: " + collection);
//    	String collection_name = form.get(Const.FIELD_SUGGESTED_COLLECTIONS);
//    	String collection = "";
//    	if (collection_name != null && !collection_name.toLowerCase().equals(Const.NONE)) {
//    		try {
//    			collection = DCollection.findByTitleExt(collection_name).url;
//    		} catch (Exception e) {
//    			Logger.info("Can't find collection for title: " + collection_name + ". " + e);
//    		}
//    	} 
    	String license_name = form.get(Const.FIELD_LICENSE_NODE);
    	String license = "";
    	if (license_name != null && !license_name.toLowerCase().equals(Const.NONE)) {
    		try {
    			license = Taxonomy.findByName(license_name).url;
    		} catch (Exception e) {
    			Logger.info("Can't find license for name: " + license_name + ". " + e);
    		}
    	} 
    	Logger.debug("license: " + license);
    	String depth = form.get(Const.FIELD_DEPTH);
    	String crawlFrequency = form.get(Const.FIELD_CRAWL_FREQUENCY);
    	String inputFlag = form.get(Const.FLAGS);
    	String flag = "";
    	if (inputFlag != null && !inputFlag.toLowerCase().equals(Const.NONE)) {
	    	String origFlag = Flags.getNameFromGuiName(inputFlag);
	    	flag = Flag.findByName(origFlag).url;
    	}
    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.ADDENTRY.equals(action)) {
    			return redirect(
    	        		routes.TargetController.lookup(0, Const.TITLE, Const.ASC, query)
    			        );
    		} 
    		else if (Const.CLEAR.equals(action)) {
    			return GO_HOME;
    		} 
    		else if (Const.EXPORT.equals(action)) {
    			List<Target> exportTargets = new ArrayList<Target>();
    	    	Page<Target> page = Target.pageTargets(0, pageSize, sort, order, query, curator, organisation, 
    					subject, crawlFrequency, depth, collection, license, flag); 
    			int rowCount = page.getTotalRowCount();
    	    	Page<Target> pageAll = Target.pageTargets(0, rowCount, sort, order, query, curator, organisation, 
    					subject, crawlFrequency, depth, collection, license, flag); 
    			exportTargets.addAll(pageAll.getList());
				Logger.info("export size: " + exportTargets.size());
    			export(exportTargets);
    	    	return redirect(routes.TargetController.list(pageNo, sort, order, query, curator, organisation, 
    	    			subject, crawlFrequency, depth, collection, license, pageSize, flag));
    		} 
    		else if (Const.SEARCH.equals(action) || Const.APPLY.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.list(pageNo, sort, order, query, curator, organisation, 
    	    			subject, crawlFrequency, depth, collection, license, pageSize, flag));
		    } else {
		    	return badRequest("This action is not allowed");
		    }
    	}
    }
    
    /**
     * This method exports selected targets to CSV file.
     * @param list of Target objects
     * @return
     */
    public static void export(List<Target> targetList) {
    	Logger.info("export() targetList size: " + targetList.size());

        StringWriter sw = new StringWriter();
        for (int i = 0; i < Const.targetExportMap.size(); i++) {
        {
            for (Map.Entry<String, Integer> entry : Const.targetExportMap.entrySet())
//        	Logger.info("export key: " + entry.getKey());
            	if (entry.getValue() == i) {
	            	sw.append(entry.getKey());
		 	    	sw.append(Const.CSV_SEPARATOR);
            	}
            }
        }

        sw.append(Const.CSV_LINE_END);
 	    
 	    if (targetList != null && targetList.size() > 0) {
 	    	Iterator<Target> itr = targetList.iterator();
 	    	while (itr.hasNext()) {
 	    		Target target = itr.next();
// 	        	Logger.info("export target: " + target); 	    		
 	            for (int i = 0; i < Const.targetExportMap.size(); i++) {
		 	        for (Map.Entry<String, Integer> entry : Const.targetExportMap.entrySet()) {
			 	   		Field[] fields = Target.class.getFields();
			 			for (Field field : fields) {
		 	               if (entry.getValue() == i) {
//		 	                   Logger.info("field.name: " + field.getName() + ", entry.getkey: " + entry.getKey());
		 	                   if (field.getName().equals(entry.getKey())) {
		 	                	   try {
										Object value = field.get(target);
//				 	                    Logger.info("value: " + value);
				 	                    if (field.getName().equals(Const.AUTHOR)) {
				 	                    	if (value != null) {
				 	                    		value = User.findByUrl((String) value).name;
				 	                    	}
				 	                    }
				 	                    // TODO: CREATED_AT
				 	                    if (field.getName().equals(Const.CREATED_AT)) {
				 	                    	if (value != null) {
				 	                    		value = Utils.showTimestampInTable((String) value);
				 	                    	}
				 	                    }
										if (field.getType().equals(String.class)) {
								    		sw.append((String) value);
									 	    sw.append(Const.CSV_SEPARATOR);
										}
										if (field.getType().equals(Long.class)) {
								    		sw.append(String.valueOf(((Long) value)));
									 	    sw.append(Const.CSV_SEPARATOR);
										}
									} catch (IllegalArgumentException e) {
										e.printStackTrace();
									} catch (IllegalAccessException e) {
										e.printStackTrace();
									}
		 	                   }
		 	               }
			 			}
		 	        }
	            }
	 	 	    sw.append(Const.CSV_LINE_END);
 	    	}
 	    }

    	Utils.generateCsvFile(Const.EXPORT_FILE, sw.toString());
    }
    
    /**
     * This method enables searching for given URL and redirection in order to add new entry
     * if required.
     * @return
     */
    public static Result search() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	String action = form.get("action");
    	String query = form.get("url"); 	

    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);

    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.ADDENTRY.equals(action)) {
    	        Logger.info("create()");
    	    	Target target = new Target();
    	    	// TODO: KL
//    	    	target.fieldUrl = query;
    	        target.revision = Const.INITIAL_REVISION;
    	        target.active = true;
    	        if (User.findByEmail(request().username()).hasRole(Const.USER)) {
    	        	target.authorUser.url = User.findByEmail(request().username()).url;
//    	        	target.fieldSubSubject = Const.NONE;
//    	        	target.fieldSubject = Const.NONE;
    	        }
//	        	target.qa_status = Const.NONE_VALUE;
    			Logger.info("add target with url: " + target.url);
    			Logger.info("target title: " + target.title);
    			Form<Target> targetForm = Form.form(Target.class);
    			targetForm = targetForm.fill(target);
    	        return ok(edit.render(targetForm, User.findByEmail(request().username())));    			
    		} 
    		else if (Const.SEARCH.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.lookup(pageNo, sort, order, query));
		    } else {
		      return badRequest("This action is not allowed");
		    }
    	}
    }
    
    /**
     * Add new entry.
     * @param targetName
     * @return
     */
    public static Result create(String title) {
        Logger.info("create()");
    	Target target = new Target();
    	// TODO: KL
//    	target.fieldUrl = title;
    	// TODO: createId
//        target.id = Target.createId();
//        target.url = Const.ACT_URL + target.id;
        target.revision = Const.INITIAL_REVISION;
        target.active = true;
		Logger.info("add entry with target url: " + target.url);
		Logger.info("target name: " + target.title);
		Form<Target> targetForm = Form.form(Target.class);
		targetForm = targetForm.fill(target);
        return ok(edit.render(targetForm, User.findByEmail(request().username())));
    }
    
    /**
     * Display the paginated list of targets.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     * @param collection_url Collection where targets search occurs
     */
    public static Result collectionTargets(int pageNo, String sortBy, String order, String filter, 
    		String collection_url) {
    	Logger.info("Targets.collectionTargets()");
    	
        return ok(
        		sites.render(
        			Collection.findByUrl(collection_url),  
        			User.findByEmail(request().username()), 
        			filter, 
        			Target.pageCollectionTargets(pageNo, 10, sortBy, order, filter, collection_url), 
        			sortBy, 
        			order) 
        	);
    }
	    
    /**
     * Display the paginated list of targets.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     * @param subject_url Subject where targets search occurs
     */
    public static Result subjectTargets(int pageNo, String sortBy, String order, String filter, 
    		String subject_url) {
    	Logger.info("Targets.subjectTargets()");
    	
        return ok(
        		views.html.subjects.sites.render(
        			Taxonomy.findByUrl(subject_url),  
        			User.findByEmail(request().username()), 
        			filter, 
        			Target.pageSubjectTargets(pageNo, 10, sortBy, order, filter, subject_url), 
        			sortBy, 
        			order) 
        	);
    }
	    
    /**
     * Display the paginated list of targets for given organisation.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     * @param collection_url Collection where targets search occurs
     */
    public static Result organisationTargets(int pageNo, String sortBy, String order, String filter, 
    		String organisation_url) {
    	Logger.info("Targets.organisationTargets()");
    	
        return ok(
        		views.html.organisations.sites.render(
        			Organisation.findByUrl(organisation_url),  
        			User.findByEmail(request().username()), 
        			filter, 
        			Target.pageOrganisationTargets(pageNo, 10, sortBy, order, filter, organisation_url), 
        			sortBy, 
        			order) 
        	);
    }
	    
    /**
     * This method enables searching for given URL and particular collection.
     * @return
     */
    public static Result searchTargetsByCollection() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	String action = form.get("action");
    	String query = form.get("url");

//    	if (StringUtils.isBlank(query)) {
//			Logger.info("Target name is empty. Please write name in search window.");
//			flash("message", "Please enter a name in the search window");
//	        return redirect(routes.CollectionController.list(0, "title", "asc", ""));
//    	}    	

    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);
    	String collection_url = form.get(Const.COLLECTION_URL);

    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.SEARCH.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.collectionTargets(pageNo, sort, order, query, collection_url));
		    } else {
		    	return badRequest("This action is not allowed");
		    }
    	}
    }
    
    /**
     * This method enables searching for given URL and particular subject.
     * @return
     */
    public static Result searchTargetsBySubject() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	String action = form.get("action");
    	String query = form.get("url");

    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);
    	String subject_url = form.get(Const.SUBJECT_URL);

    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.SEARCH.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.subjectTargets(pageNo, sort, order, query, subject_url));
		    } else {
		    	return badRequest("This action is not allowed");
		    }
    	}
    }
    
    /**
     * This method enables searching for given URL and particular organisation.
     * @return
     */
    public static Result searchTargetsByOrganisation() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	String action = form.get(Const.ACTION);
    	String query = form.get(Const.URL);

    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);
    	String organisation_url = form.get(Const.ORGANISATION_URL);

    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.SEARCH.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.organisationTargets(pageNo, sort, order, query, organisation_url));
		    } else {
		    	return badRequest("This action is not allowed");
		    }
    	}
    }
    
    /**
     * Display the paginated list of targets.
     *
     * @param page Current page number (starts from 0)
     * @param sortBy Column to be sorted
     * @param order Sort order (either asc or desc)
     * @param filter Filter applied on target urls
     * @param user_url User for whom targets search occurs
     * @param subject Taxonomy of type subject
     * @param collection Taxonomy of type collection
     */
    public static Result userTargets(int pageNo, String sortBy, String order, String filter, 
    		String user_url, String subject, String collection) {
    	Logger.info("Targets.collectionTargets()");
    	
        return ok(
        		usersites.render(
        			User.findByUrl(user_url),  
        			User.findByEmail(request().username()), 
        			filter, 
        			Target.pageUserTargets(pageNo, 10, sortBy, order, filter, user_url, subject, collection), 
        			sortBy, 
        			order,
        			subject,
        			collection)
        	);
    }	        
        
    /**
     * This method enables searching for given URL and particular user.
     * @return
     */
    public static Result searchTargetsByUser() {
    	
    	DynamicForm form = DynamicForm.form().bindFromRequest();
    	String action = form.get("action");
    	String query = form.get("url");

    	String user_url = form.get(Const.USER_URL);
    	int pageNo = Integer.parseInt(form.get(Const.PAGE_NO));
    	String sort = form.get(Const.SORT_BY);
    	String order = form.get(Const.ORDER);

    	String subject_name = form.get(Const.FIELD_SUBJECT);
    	String subject = "";
    	if (subject_name != null && !subject_name.toLowerCase().equals(Const.NONE)) {
    		try {
    			Logger.info("find subject for title: " + subject_name + ". " + subject_name.length());
           		subject = Taxonomy.findByName(subject_name).url;
    		} catch (Exception e) {
    			Logger.info("Can't find subject for name: " + subject_name + ". " + e);
    		}
    	} 
    	String collection_name = form.get(Const.FIELD_SUGGESTED_COLLECTIONS);
    	String collection = "";
    	if (collection_name != null && !collection_name.toLowerCase().equals(Const.NONE)) {
    		try {
    			collection = Collection.findByTitle(collection_name).url;
    		} catch (Exception e) {
    			Logger.info("Can't find collection for title: " + collection_name + ". " + e);
    		}
    	} 
    	
//    	if (StringUtils.isBlank(query)) {
//			Logger.info("Target name is empty. Please write name in search window.");
//			flash("message", "Please enter a name in the search window");
//	        return redirect(routes.Targets.userTargets(pageNo, sort, order, query, user_url, subject, collection));
//    	}    	
    	
    	if (StringUtils.isEmpty(action)) {
    		return badRequest("You must provide a valid action");
    	} else {
    		if (Const.SEARCH.equals(action)) {
    			Logger.info("searching " + pageNo + " " + sort + " " + order);
    	    	return redirect(routes.TargetController.userTargets(pageNo, sort, order, query, user_url, subject, collection));
		    } else {
		    	return badRequest("This action is not allowed");
		    }
    	}
    }
        
    public static Result GO_HOME = redirect(
            routes.TargetController.list(0, Const.TITLE, Const.ASC, "", "", "", Const.EMPTY, "", "", Const.NONE, "", Const.PAGINATION_OFFSET, "")
        );
    
       
    /**
     * Display the target edit panel for this URL.
     * @param url The target identifier URL
     */
    public static Result edit(String url) {
		Logger.info("Targets.edit() url: " + url);
		Target target = Target.findByUrl(url);
//		if (target.fieldSubject == null || target.fieldSubject.length() == 0) {
//			Logger.info("Targets.edit() set subject value to 'None' for imported targets.");
//			target.fieldSubject = Const.NONE;
//			Ebean.update(target);
//		}		
		Logger.info("Targets.edit() target name: " + target.title + ", url: " + url + ", username: " + request().username());
		Form<Target> targetForm = Form.form(Target.class);
		targetForm = targetForm.fill(Target.findByUrl(url));
        return ok(edit.render(targetForm, User.findByEmail(request().username())));
    }
    
    /**
     * This method shows selected revision of a Target by given ID.
     * @param nid
     * @return
     */
    public static Result viewrevision(Long nid) {
        return ok(
                view.render(
                        Target.findById(nid), User.findByEmail(request().username())
                )
            );
    }
    
    /**
     * This method provides data exports for each possible crawl-frequency. 
     * For each frequency this contains a list of Targets and associated 
     * crawl metadata.
     * @param frequency The crawl frequency e.g. 'daily'
     * @return list of Target objects
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result exportByFrequencyJson(String frequency) {
        JsonNode jsonData = null;
        if (frequency != null) {
	        List<Target> targets = new ArrayList<Target>();
        	targets = Target.exportByFrequency(frequency);
	        jsonData = Json.toJson(targets);
        }
        return ok(jsonData);
    }
    
    /**
     * This method provides data exports for each possible crawl-frequency that are in legal deposit. 
     * For each frequency this contains a list of Targets and associated 
     * crawl metadata.
     * @param frequency The crawl frequency e.g. 'daily'
     * @return list of Target objects
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result exportLdFrequencyJson(String frequency) {
        JsonNode jsonData = null;
        if (frequency != null) {
	        List<Target> targets = new ArrayList<Target>();
        	targets = Target.exportLdFrequency(frequency);
	        jsonData = Json.toJson(targets);
        }
        return ok(jsonData);
    }

    /**
     * Example form with validation
     * @return blank form for data entry
     */
    public static Result blank() {
        Logger.info("blank()");
        return ok(blank.render(targetForm, User.findByEmail(request().username())));
    }
    
    public static Result saveBlank() {
    	play.data.Form<Target> filledForm = targetForm.bindFromRequest();
	    if(filledForm.hasErrors()) {
	        return badRequest(blank.render(filledForm, User.findByEmail(request().username())));
	    } else {
	        flash("success", "You've saved");
	        return ok(blank.render(filledForm, User.findByEmail(request().username())));
	    }
    }
    
    /**
     * This method updates QA status for target if it is changed for e.g. 
     * associated crawl permission.
     * @param fieldUrl The target crawl URL
     * @param qaStatus The current QA status
     */
    public static void updateQaStatus(String fieldUrl, String qaStatus) {
        if (fieldUrl != null) {
        	Target targetObj = Target.findByFieldUrl(fieldUrl);
        	if (targetObj != null && targetObj.url != null) {
	        	targetObj.qaIssue.url = qaStatus;
	        	Logger.debug("update Qa Status for target object: " + qaStatus);
    	        Ebean.update(targetObj);
        	}
        }
    }
    
    /**
     * This method maps scope value to present predefined Scope values in GUI.
     * @param name The predefined scope value.
     * @return scope name that should be presented in GUI
     */
    public static String getScopeGuiName(String name) {
    	String res = name;
    	if (name != null && name.length() > 0) {
    		String guiName = Const.guiScopeMap.get(name);
    		if (guiName != null && guiName.length() > 0) {
    			res = guiName;
    		}
    	}
    	return res;
    }
    
    /**
     * This method calculates scope value from the GUI scope name.
     * @param name The GUI scope value.
     * @return original scope name 
     */
    public static String getScopeNameFromGuiName(String name) {
    	String res = name;
    	if (name != null && name.length() > 0) {
			for (Map.Entry<String, String> entry : Const.guiScopeMap.entrySet()) {
				if (entry.getValue().equals(name)) {
					res = entry.getKey();
					break;
				}
			}
    	}
    	return res;
    }
            
    /**
     * This method maps depth value to present predefined Scope values in GUI.
     * @param name The predefined depth value.
     * @return depth name that should be presented in GUI
     */
    public static String getDepthGuiName(String name) {
    	String res = name;
    	if (name != null && name.length() > 0) {
    		String guiName = Const.guiDepthMap.get(name);
    		if (guiName != null && guiName.length() > 0) {
    			res = guiName;
    		}
    	}
    	return res;
    }
    
    /**
     * This method calculates depth value from the GUI depth name.
     * @param name The GUI depth value.
     * @return original depth name 
     */
    public static String getDepthNameFromGuiName(String name) {
    	String res = name;
    	if (name != null && name.length() > 0) {
			for (Map.Entry<String, String> entry : Const.guiDepthMap.entrySet()) {
				if (entry.getValue().equals(name)) {
					res = entry.getKey();
					break;
				}
			}
    	}
    	return res;
    }
         
	/**
	 * This method indicates to the user in a target record if data has been entered 
	 * by other users relating to NPLD status in another target record at a higher 
	 * level in the domain. 
	 * This is to avoid duplication of effort: users should not need to spend time 
	 * (outside ACT) doing the necessary research to populate the 'UK Postal Address', 
	 * 'Via Correspondence', and 'Professional Judgment' fields for abc.co.uk/directory 
	 * if those fields are already populated in a target record for abc.co.uk 
	 * @param fieldUrl The target URL
	 * @return result as a flag. Result is true if:
	 * 		   (i) one or more of the three fields named above is not null in any other 
	 *             target record at a higher level within the same domain AND 
	 *         (ii) where both 'UK hosting' and 'UK top-level domain' = No.
	 */
//    public static boolean indicateNpldStatus(String fieldUrl) {
//    	boolean res = false;
//    	if (Target.getNpldStatusList(fieldUrl).size() > 0) {
//    		res = true;
//    	}
//    	Logger.info("indicateNpldStatus() res: " + res);
//    	return res;
//    }
    
	/**
	 * This method should give a list of the Target Titles and URLs for the 
	 * first three examples, in descending order of date of creation of the record. 
	 * @param fieldUrl The target URL
	 * @return result as a string
	 */
    public static String showNpldStatusList(String fieldUrl) {
    	String res = "";
//        try {
//            StringBuilder sb = new StringBuilder();
//        	List<Target> targets = Target.getNpldStatusList(fieldUrl);
//        	Iterator<Target> itr = targets.iterator();
//        	while (itr.hasNext()) {
//        		Target target = itr.next();
//        		sb.append(target.title + " " + target.fieldUrl());
//                sb.append(System.getProperty("line.separator"));
//        	}
//            res = sb.toString();
//    	} catch (Exception e) {
//            Logger.error("showNpldStatusList() " + e.getMessage());
//        }
    	return res;
    }
    
	/**
	 * This method prepares Target form for sending info message
	 * about errors 
	 * @return edit page with form and info message
	 */
	public static Result info() {
	    Target targetObj = new Target();
        try {
    	    Target target = Target.findById(Long.valueOf(getFormParam(Const.ID)));
        	if (getFormParam(Const.FIELD_WCT_ID) != null && !getFormParam(Const.FIELD_WCT_ID).equals("")
        			&& !Utils.isNumeric(getFormParam(Const.FIELD_WCT_ID))) {
            	targetObj.field_wct_id = target.field_wct_id;
            }
        	if (getFormParam(Const.FIELD_SPT_ID) != null && !getFormParam(Const.FIELD_SPT_ID).equals("")
        			&& !Utils.isNumeric(getFormParam(Const.FIELD_SPT_ID))) {
            	targetObj.field_spt_id = target.field_spt_id;
        	}
        	if (getFormParam(Const.LEGACY_SITE_ID) != null && !getFormParam(Const.LEGACY_SITE_ID).equals("")
        			&& !Utils.isNumeric(getFormParam(Const.LEGACY_SITE_ID))) {
            	targetObj.legacySiteId = target.legacySiteId;
            }
        } catch (Exception e) {
        	Logger.info("The target for given NID is not yet existing in database");
        } 	

        // TODO: KL
//	    targetObj.fieldUrl = getFormParam(Const.FIELD_URL_NODE);
	    targetObj.id = Long.valueOf(getFormParam(Const.ID));
	    targetObj.url = Const.ACT_URL + targetObj.id;
	    // TODO: KL
//        targetObj.authorRef = getFormParam(Const.USER);
        targetObj.title = getFormParam(Const.TITLE);
        targetObj.field_key_site = Utils.getNormalizeBooleanString(getFormParam(Const.KEYSITE));
        targetObj.description = getFormParam(Const.DESCRIPTION);
        if (getFormParam(Const.FLAG_NOTES) != null) {
        	targetObj.flagNotes = getFormParam(Const.FLAG_NOTES);
        } 
        if (getFormParam(Const.FIELD_QA_STATUS) != null) {
        	targetObj.qaIssue.url = Taxonomy.findByNameExt(getFormParam(Const.FIELD_QA_STATUS)).url;
        } 
//        if (getFormParam(Const.STATUS) != null) {
//        	targetObj.status = Long.valueOf(getFormParam(Const.STATUS));
//        } 
        if (getFormParam(Const.QA_STATUS) != null) {
        	targetObj.qaIssue.url = getFormParam(Const.QA_STATUS);
        } else {
        	targetObj.qaIssue.url = Const.NONE_VALUE;
        }
        if (getFormParam(Const.LANGUAGE) != null) {
        	targetObj.language = getFormParam(Const.LANGUAGE);
        } 
        if (getFormParam(Const.SELECTION_TYPE) != null) {
        	targetObj.selectionType = getFormParam(Const.SELECTION_TYPE);
        } 
        if (getFormParam(Const.SELECTOR_NOTES) != null) {
        	targetObj.selectorNotes = getFormParam(Const.SELECTOR_NOTES);
        } 
        if (getFormParam(Const.ARCHIVIST_NOTES) != null) {
        	targetObj.archivistNotes = getFormParam(Const.ARCHIVIST_NOTES);
        } 
        if (getFormParam(Const.LEGACY_SITE_ID) != null 
        		&& getFormParam(Const.LEGACY_SITE_ID).length() > 0
        		&& Utils.isNumeric(getFormParam(Const.LEGACY_SITE_ID))) {
        	targetObj.legacySiteId = Long.valueOf(getFormParam(Const.LEGACY_SITE_ID));
        }
        if (getFormParam(Const.AUTHORS) != null) {
        	targetObj.authorUser.url = getFormParam(Const.AUTHORS);
        } 
        if (getFormParam(Const.LIVE_SITE_STATUS) != null) {
        	targetObj.field_live_site_status = getFormParam(Const.LIVE_SITE_STATUS);
        } 
        if (getFormParam(Const.FIELD_SUBJECT) != null) {
        	String subjectListStr = Utils.removeDuplicatesFromList(getFormParam(Const.FIELD_SUBJECT));
        	if (subjectListStr != null && subjectListStr.length() > 0
        			&& subjectListStr.toLowerCase().contains(Const.NONE)
        			&& subjectListStr.contains(Const.COMMA)) {
//        	    targetObj.fieldSubject = Const.NONE;
        	} else {
//        		targetObj.fieldSubject = subjectListStr;
        	}
//        	targetObj.updateSubject();
        } else {
//        	targetObj.fieldSubject = Const.NONE;
        }
        if (getFormParam(Const.TREE_KEYS) != null) {
//    		targetObj.fieldCollectionCategories = Utils.removeDuplicatesFromList(getFormParam(Const.TREE_KEYS));
    		// TODO: KL SHOULD ALREADY HAVE COLLECTIONS
//        	targetObj.collectionToTarget = Collection.convertUrlsToObjects(targetObj.fieldCollectionCategories);
//    		targetObj.updateCollection();
        }
        if (getFormParam(Const.ORGANISATION) != null) {
        	if (!getFormParam(Const.ORGANISATION).toLowerCase().contains(Const.NONE)) {
        		// TODO: KL NEEDS CHANGING
//        		targetObj.fieldNominatingOrganisation = Organisation.findByTitle(getFormParam(Const.ORGANISATION)).url;
//        		targetObj.updateOrganisation();
        	} else {
//        		targetObj.fieldNominatingOrganisation = Const.NONE;
        	}
        }
        if (getFormParam(Const.ORIGINATING_ORGANISATION) != null) {
       		targetObj.organisation.url = getFormParam(Const.ORIGINATING_ORGANISATION);
        }
        if (getFormParam(Const.AUTHOR) != null) {
        	// TODO: KL
//       		targetObj.authorRef = User.findByName(getFormParam(Const.AUTHOR)).url;
        }
        if (getFormParam(Const.TAGS) != null) {
        	if (!getFormParam(Const.TAGS).toLowerCase().contains(Const.NONE)) {
            	String[] tags = getFormParams(Const.TAGS);
            	String resTags = "";
            	for (String tag: tags)
                {
            		if (tag != null && tag.length() > 0) {
            			resTags = resTags + Tag.findByName(tag).url + Const.LIST_DELIMITER;
            		}
                }
//            	targetObj.tags = resTags;
//            	targetObj.tagToTarget = Tag.convertUrlsToObjects(targetObj.tags);
        	} else {
//        		targetObj.tags = Const.NONE;
        	}
        }
        String flagStr = "";
        List<Flag> flagList = Flag.findAllFlags();
        Iterator<Flag> flagItr = flagList.iterator();
        while (flagItr.hasNext()) {
        	Flag flag = flagItr.next();
//        	Logger.info("flag: " + flag + ", param: " + getFormParam(flag.name));
            if (getFormParam(flag.name) != null) {
                boolean flagFlag = Utils.getNormalizeBooleanString(getFormParam(flag.name));
//            	Logger.info("flagFlag: " + flagFlag);
                if (flagFlag) {
                	if (flagStr.length() == 0) {
                		flagStr = flag.name;
                	} else {
                		flagStr = flagStr + ", " + flag.name;
                	}
                }
            }
        }
//        if (flagStr.length() == 0) {
//        	targetObj.flags = Const.NONE;
//        } else {
//        	targetObj.flags = flagStr;
//        	targetObj.flagToTarget = Flag.convertUrlsToObjects(targetObj.flags);
//        }
        Logger.info("flagStr: "+ flagStr + ", targetObj.flags: " + targetObj.flags);
        targetObj.justification = getFormParam(Const.JUSTIFICATION);
        targetObj.summary = getFormParam(Const.SUMMARY);
        targetObj.revision = getFormParam(Const.REVISION);
        if (getFormParam(Const.FIELD_WCT_ID) != null 
        		&& getFormParam(Const.FIELD_WCT_ID).length() > 0
        		&& Utils.isNumeric(getFormParam(Const.FIELD_WCT_ID))) {
        	targetObj.field_wct_id = Long.valueOf(getFormParam(Const.FIELD_WCT_ID));
        }
        if (getFormParam(Const.FIELD_SPT_ID) != null 
        		&& getFormParam(Const.FIELD_SPT_ID).length() > 0
        		&& Utils.isNumeric(getFormParam(Const.FIELD_SPT_ID))) {
        	targetObj.field_spt_id = Long.valueOf(getFormParam(Const.FIELD_SPT_ID));
        }
        if (getFormParam(Const.FIELD_LICENSE) != null) {
        	if (!getFormParam(Const.FIELD_LICENSE).toLowerCase().contains(Const.NONE)) {
            	String[] licenses = getFormParams(Const.FIELD_LICENSE);
            	String resLicenses = "";
            	for (String curLicense: licenses)
                {
            		if (curLicense != null && curLicense.length() > 0) {
            			resLicenses = resLicenses + Taxonomy.findByFullNameExt(curLicense, Const.LICENCE).url + Const.LIST_DELIMITER;
            		}
                }
//            	targetObj.fieldLicense = resLicenses;
//            	targetObj.licenses = Taxonomy.convertUrlsToObjects(targetObj.fieldLicense);
//        		targetObj.updateLicense();
        	} else {
//        		targetObj.fieldLicense = Const.NONE;
        	}
        }
        targetObj.field_uk_hosting = targetObj.isUkHosting();
        targetObj.field_uk_postal_address = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_UK_POSTAL_ADDRESS));
        targetObj.ukPostalAddressUrl = getFormParam(Const.FIELD_UK_POSTAL_ADDRESS_URL);
        targetObj.field_via_correspondence = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_VIA_CORRESPONDENCE));
        targetObj.value = getFormParam(Const.FIELD_NOTES);
        targetObj.field_professional_judgement = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_PROFESSIONAL_JUDGEMENT));
        targetObj.field_professional_judgement_exp = getFormParam(Const.FIELD_PROFESSIONAL_JUDGEMENT_EXP);
        targetObj.field_no_ld_criteria_met = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_NO_LD_CRITERIA_MET));
        targetObj.field_ignore_robots_txt = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_IGNORE_ROBOTS_TXT));
        if (getFormParam(Const.FIELD_CRAWL_START_DATE) != null) {
        	String startDateHumanView = getFormParam(Const.FIELD_CRAWL_START_DATE);
        	String startDateUnix = Utils.getUnixDateStringFromDate(startDateHumanView);
        	// TODO: UNIX DATE
//        	targetObj.fieldCrawlStartDate = startDateUnix;
        }
    	// TODO: UNIX DATE
//        targetObj.dateOfPublication = getFormParam(Const.DATE_OF_PUBLICATION);
//        targetObj.fieldCrawlEndDate = getFormParam(Const.FIELD_CRAWL_END_DATE);
        if (getFormParam(Const.FIELD_CRAWL_END_DATE) != null) {
        	String endDateHumanView = getFormParam(Const.FIELD_CRAWL_END_DATE);
        	String endDateUnix = Utils.getUnixDateStringFromDate(endDateHumanView);
        	// TODO: UNIX DATE
//        	targetObj.fieldCrawlEndDate = endDateUnix;
        }
        targetObj.whiteList = getFormParam(Const.WHITE_LIST);
        targetObj.blackList = getFormParam(Const.BLACK_LIST);
        if (getFormParam(Const.FIELD_DEPTH) != null) {
        	targetObj.field_depth = getDepthNameFromGuiName(getFormParam(Const.FIELD_DEPTH));
        }
        targetObj.field_crawl_frequency = getFormParam(Const.FIELD_CRAWL_FREQUENCY);
        if (getFormParam(Const.FIELD_SCOPE) != null) {
        	targetObj.field_scope = getScopeNameFromGuiName(getFormParam(Const.FIELD_SCOPE));
        }
        targetObj.keywords = getFormParam(Const.KEYWORDS);
        targetObj.synonyms = getFormParam(Const.SYNONYMS);
        if (getFormParam(Const.TAB_STATUS) != null) {
        	targetObj.tabStatus = getFormParam(Const.TAB_STATUS);
        }
	    targetObj.active = true;
		Form<Target> targetFormNew = Form.form(Target.class);
		targetFormNew = targetFormNew.fill(targetObj);
      	return ok(
	              edit.render(targetFormNew, User.findByEmail(request().username()))
	            );
    }

	/**
     * This method saves changes on given target in a new target object
     * completed by revision comment. The "version" field in the Target object
     * contains the timestamp of the change and the last version is marked by
     * flag "active". Remaining Target objects with the same URL are not active.
     * @return
     */
    public static Result saveTarget() {
    	Result res = null;
        String save = getFormParam("save");
        String delete = getFormParam("delete");
        String request = getFormParam(Const.REQUEST);
        String archive = getFormParam(Const.ARCHIVE);
        Logger.info("save: " + save);
        Logger.info("delete: " + delete);
        if (save != null) {
        	Logger.info("input data for the target saving nid: " + getFormParam(Const.ID) + 
        			", url: " + getFormParam(Const.URL) +
        			", field_subject: " + getFormParam(Const.FIELD_SUBJECT) + 
        			", field_url: " + getFormParam(Const.FIELD_URL_NODE) + 
        			", title: " + getFormParam(Const.TITLE) + ", keysite: " + getFormParam(Const.KEYSITE) +
        			", description: " + getFormParam(Const.DESCRIPTION) + 
        			", status: " + getFormParam(Const.STATUS) +
        			", qa status: " + getFormParam(Const.QA_STATUS) +
        			", subject: " + getFormParams(Const.SUBJECT) +
        			", organisation: " + getFormParam(Const.ORGANISATION) +
        			", live site status: " + getFormParam(Const.LIVE_SITE_STATUS));
        	Logger.info("treeKeys: " + getFormParam(Const.TREE_KEYS));
        	Logger.info("current tab: " + getFormParam(Const.TAB_STATUS));
        	
        	Form<Target> targetForm = Form.form(Target.class).bindFromRequest();
            if(targetForm.hasErrors()) {
            	String missingFields = "";
            	for (String key : targetForm.errors().keySet()) {
            	    Logger.debug("key: " +  key);
            	    key = Utils.showMissingField(key);
            	    if (missingFields.length() == 0) {
            	    	missingFields = key;
            	    } else {
            	    	missingFields = missingFields + Const.COMMA + " " + key;
            	    }
            	}
            	if (missingFields != null) {
	            	Logger.info("form errors size: " + targetForm.errors().size() + ", " + missingFields);
		  			flash("message", "Please fill out all the required fields, marked with a red star. There are required fields in more than one tab. " + 
		  					"Missing fields are: " + missingFields);
		  			return info();
            	}
            }
        	        	
        	DynamicForm requestData = Form.form().bindFromRequest();
        	String title = requestData.get(Const.TITLE);
        	Logger.info("form title: " + title);
            Target target = new Target();
        	Target newTarget = new Target();
            boolean isExisting = true;
            try {
        	    target = Target.findById(Long.valueOf(getFormParam(Const.ID)));
            } catch (Exception e) {
            	Logger.info("is not existing exception");
            	isExisting = false;
            } 	
        	
//            Logger.info("wct id: " + getFormParam(Const.FIELD_WCT_ID) +
//            		", isNumeric: " + Utils.isNumeric(getFormParam(Const.FIELD_WCT_ID)));
            if (getFormParam(Const.FIELD_WCT_ID) != null 
            		&& (getFormParam(Const.FIELD_WCT_ID).equals("")
            		|| !Utils.isNumeric(getFormParam(Const.FIELD_WCT_ID)))) {
                Logger.info("Only numeric values are valid identifiers. Please check field 'WCT ID'.");
	  			flash("message", "Only numeric values are valid identifiers. Please check field 'WCT ID'.");
	  			return info();
        	}    	

        	if (getFormParam(Const.FIELD_SPT_ID) != null && !getFormParam(Const.FIELD_SPT_ID).equals("")
        			&& !Utils.isNumeric(getFormParam(Const.FIELD_SPT_ID))) {
                Logger.info("Only numeric values are valid identifiers. Please check field 'SPT ID'.");
	  			flash("message", "Only numeric values are valid identifiers. Please check field 'SPT ID'.");
	  			return info();
        	}    	

        	if (getFormParam(Const.LEGACY_SITE_ID) != null && !getFormParam(Const.LEGACY_SITE_ID).equals("")
        			&& !Utils.isNumeric(getFormParam(Const.LEGACY_SITE_ID))) {
                Logger.info("Only numeric values are valid identifiers. Please check field 'LEGACY SITE ID'.");
	  			flash("message", "Only numeric values are valid identifiers. Please check field 'LEGACY SITE ID'.");
	  			return info();
        	}    	

            if (target == null) {
            	target = new Target();
            	Logger.info("is not existing");
            	isExisting = false;
            }
            /**
             * Copy association fields
             */
            newTarget.organisation = target.organisation;
            
            // TODO: KL 
//            newTarget.authorRef = target.authorRef;
//            if (target.authorRef == null) {
//            	newTarget.authorRef = getFormParam(Const.USER);
//            }
//            newTarget.fieldNominatingOrganisation = target.fieldNominatingOrganisation;
//    		newTarget.updateOrganisation();
//            newTarget.fieldCollectionCategories = target.fieldCollectionCategories;
            newTarget.title = getFormParam(Const.TITLE);
            
//            newTarget.fieldUrl = Scope.normalizeUrl(getFormParam(Const.FIELD_URL_NODE));
            newTarget.field_key_site = Utils.getNormalizeBooleanString(getFormParam(Const.KEYSITE));
            newTarget.description = getFormParam(Const.DESCRIPTION);
            if (getFormParam(Const.FLAG_NOTES) != null) {
            	newTarget.flagNotes = getFormParam(Const.FLAG_NOTES);
            } 
            if (getFormParam(Const.FIELD_QA_STATUS) != null) {
            	newTarget.qaIssue.url = Taxonomy.findByNameExt(getFormParam(Const.FIELD_QA_STATUS)).url;
            } 
            if (getFormParam(Const.QA_STATUS) != null) {
            	Logger.debug("###   QA_STATUS");
            	newTarget.qaIssue.url = getFormParam(Const.QA_STATUS);
            	CrawlPermissions.updateAllByTargetStatusChange(newTarget.fieldUrl(), newTarget.qaIssue.url);
            } else {
            	newTarget.qaIssue.url = Const.NONE_VALUE;
            } 
    		Logger.info("QA status: " + newTarget.qaIssue.url + ", getFormParam(Const.QA_STATUS): " + getFormParam(Const.QA_STATUS));
            if (getFormParam(Const.LANGUAGE) != null) {
//        		Logger.info("language: " + getFormParam(Const.LANGUAGE) + ".");
            	newTarget.language = getFormParam(Const.LANGUAGE);
            } 
            if (getFormParam(Const.SELECTION_TYPE) != null) {
            	newTarget.selectionType = getFormParam(Const.SELECTION_TYPE);
            } 
            if (getFormParam(Const.SELECTOR_NOTES) != null) {
            	newTarget.selectorNotes = getFormParam(Const.SELECTOR_NOTES);
            } 
            if (getFormParam(Const.ARCHIVIST_NOTES) != null) {
            	newTarget.archivistNotes = getFormParam(Const.ARCHIVIST_NOTES);
            } 
            if (getFormParam(Const.LEGACY_SITE_ID) != null 
            		&& getFormParam(Const.LEGACY_SITE_ID).length() > 0
            		&& Utils.isNumeric(getFormParam(Const.LEGACY_SITE_ID))) {
        		Logger.info("legacy site id: " + getFormParam(Const.LEGACY_SITE_ID) + ".");
            	newTarget.legacySiteId = Long.valueOf(getFormParam(Const.LEGACY_SITE_ID));
            }

    		Logger.info("authors: " + getFormParam(Const.AUTHORS) + ".");
            if (getFormParam(Const.AUTHORS) != null) {
            	newTarget.authorUser.url = getFormParam(Const.AUTHORS);
            } 
            if (getFormParam(Const.LIVE_SITE_STATUS) != null) {
            	newTarget.field_live_site_status = getFormParam(Const.LIVE_SITE_STATUS);
            } 
            if (getFormParam(Const.FIELD_SUBJECT) != null) {
            	String subjectListStr = Utils.removeDuplicatesFromList(getFormParam(Const.FIELD_SUBJECT));
            	if (subjectListStr != null && subjectListStr.length() > 0
            			&& subjectListStr.toLowerCase().contains(Const.NONE)
            			&& subjectListStr.contains(Const.COMMA)) {
            		if (subjectListStr.contains(Const.NONE_VALUE + Const.COMMA + " ")) {
            			subjectListStr = subjectListStr.replace(Const.NONE_VALUE + Const.COMMA + " ", "");
            		}
            		if (subjectListStr.contains(Const.COMMA + " " + Const.NONE_VALUE)) {
            			subjectListStr = subjectListStr.replace(Const.COMMA + " " + Const.NONE_VALUE, "");
            		}
            		Logger.info("after removing 'None' value is it was combined with another subject");      		
            	}
//            	newTarget.fieldSubject = subjectListStr;
//            	newTarget.subject = Taxonomy.convertUrlsToObjects(newTarget.fieldSubject);
//        		Logger.debug("newTarget.field_subject: " + newTarget.fieldSubject);
            } else {
//            	newTarget.fieldSubject = Const.NONE;
            }            
            if (getFormParam(Const.TREE_KEYS) != null) {
//	    		newTarget.fieldCollectionCategories = Utils.removeDuplicatesFromList(getFormParam(Const.TREE_KEYS));
//	        	newTarget.collectionToTarget = Collection.convertUrlsToObjects(newTarget.fieldCollectionCategories);
//	    		Logger.debug("newTarget.field_collection_categories: " + newTarget.fieldCollectionCategories);
            }
            if (getFormParam(Const.ORGANISATION) != null) {
            	if (!getFormParam(Const.ORGANISATION).toLowerCase().contains(Const.NONE)) {
            		Logger.info("nominating organisation: " + getFormParam(Const.ORGANISATION));
            		// TODO: KL
//            		newTarget.fieldNominatingOrganisation = Organisation.findByTitle(getFormParam(Const.ORGANISATION)).url;
//            		newTarget.updateOrganisation();
            	} else {
//            		newTarget.fieldNominatingOrganisation = Const.NONE;
            	}
            }
            if (getFormParam(Const.ORIGINATING_ORGANISATION) != null) {
           		newTarget.organisation.url = getFormParam(Const.ORIGINATING_ORGANISATION);
            }
//    		Logger.info("author: " + getFormParam(Const.AUTHOR) + ", user: " + User.findByName(getFormParam(Const.AUTHOR)).url);
            if (getFormParam(Const.AUTHOR) != null) {
                // TODO: KL 
//           		newTarget.authorRef = User.findByName(getFormParam(Const.AUTHOR)).url;
            }
            if (getFormParam(Const.TAGS) != null) {
            	if (!getFormParam(Const.TAGS).toLowerCase().contains(Const.NONE)) {
	            	String[] tags = getFormParams(Const.TAGS);
	            	String resTags = "";
	            	for (String tag: tags) {
	            		if (tag != null && tag.length() > 0) {
	                		Logger.info("add tag: " + tag);
	            			resTags = resTags + Tag.findByName(tag).url + Const.LIST_DELIMITER;
	            		}
	                }
//	            	newTarget.tags = resTags;
//                	newTarget.tagToTarget = Tag.convertUrlsToObjects(newTarget.tags);
            	} else {
//            		newTarget.tags = Const.NONE;
            	}
            }
            String flagStr = "";
            List<Flag> flagList = Flag.findAllFlags();
            Iterator<Flag> flagItr = flagList.iterator();
            while (flagItr.hasNext()) {
            	Flag flag = flagItr.next();
//            	Logger.info("flag: " + flag + ", param: " + getFormParam(flag.name));
                if (getFormParam(flag.name) != null) {
                    boolean flagFlag = Utils.getNormalizeBooleanString(getFormParam(flag.name));
//                	Logger.info("flagFlag: " + flagFlag);
                    if (flagFlag) {
                    	if (flagStr.length() == 0) {
                    		flagStr = flag.name;
                    	} else {
                    		flagStr = flagStr + ", " + flag.name;
                    	}
                    }
                }
            }
//            if (flagStr.length() == 0) {
//            	newTarget.flags = Const.NONE;
//            } else {
//            	newTarget.flags = flagStr;
//            	newTarget.flagToTarget = Flag.convertUrlsToObjects(newTarget.flags);
//            }
            Logger.info("flagStr: "+ flagStr + ", newTarget.flags: " + newTarget.flags);
            newTarget.justification = getFormParam(Const.JUSTIFICATION);
            newTarget.summary = getFormParam(Const.SUMMARY);
            newTarget.revision = getFormParam(Const.REVISION);
            if (getFormParam(Const.FIELD_WCT_ID) != null 
            		&& getFormParam(Const.FIELD_WCT_ID).length() > 0
            		&& Utils.isNumeric(getFormParam(Const.FIELD_WCT_ID))) {
            	newTarget.field_wct_id = Long.valueOf(getFormParam(Const.FIELD_WCT_ID));
            }
            if (getFormParam(Const.FIELD_SPT_ID) != null 
            		&& getFormParam(Const.FIELD_SPT_ID).length() > 0
            		&& Utils.isNumeric(getFormParam(Const.FIELD_SPT_ID))) {
            	newTarget.field_spt_id = Long.valueOf(getFormParam(Const.FIELD_SPT_ID));
            }
            if (getFormParam(Const.FIELD_LICENSE) != null) {
            	if (!getFormParam(Const.FIELD_LICENSE).toLowerCase().contains(Const.NONE)) {
	            	String[] licenses = getFormParams(Const.FIELD_LICENSE);
	            	String resLicenses = "";
	            	for (String curLicense: licenses)
	                {
	            		if (curLicense != null && curLicense.length() > 0) {
	                		Logger.info("add curLicense: " + curLicense);
	                		if (curLicense.equals(Const.OPEN_UKWA_LICENSE) 
	                				&& getFormParam(Const.QA_STATUS) != null 
	                				&& !getFormParam(Const.QA_STATUS).equals(Const.CrawlPermissionStatus.GRANTED.name())) {
	                        	Logger.info("Saving is not allowed if License='Open UKWA License (2014-)' and Open UKWA License Requests status is anything other than 'Granted'.");
	            	  			flash("message", "Saving is not allowed if License='Open UKWA License (2014-)' and Open UKWA License Requests status is anything other than 'Granted'.");
	            	  			return info();
	                		}
	            			resLicenses = resLicenses + Taxonomy.findByFullNameExt(curLicense, Const.LICENCE).url + Const.LIST_DELIMITER;
	            		}
	                }
//	            	newTarget.fieldLicense = resLicenses;
//                	newTarget.licenses = Taxonomy.convertUrlsToObjects(newTarget.fieldLicense);
            	} else {
//            		newTarget.fieldLicense = Const.NONE;
            	}
            }
//            newTarget.field_uk_hosting = Scope.INSTANCE.checkUkHosting(newTarget.fieldUrl());
        	Logger.debug("field_uk_hosting: " + newTarget.field_uk_hosting);
            newTarget.field_uk_postal_address = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_UK_POSTAL_ADDRESS));
            newTarget.ukPostalAddressUrl = getFormParam(Const.FIELD_UK_POSTAL_ADDRESS_URL);
            Logger.debug("newTarget.field_uk_postal_address: " + newTarget.field_uk_postal_address);
            if (newTarget.field_uk_postal_address 
            		&& (newTarget.ukPostalAddressUrl == null || newTarget.ukPostalAddressUrl.length() == 0)) {
            	Logger.info("If UK Postal Address field has value 'Yes', the Postal Address URL is required.");
	  			flash("message", "If UK Postal Address field has value 'Yes', the Postal Address URL is required.");
	  			return info();
            }
            newTarget.field_via_correspondence = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_VIA_CORRESPONDENCE));
            newTarget.value = getFormParam(Const.FIELD_NOTES);
            if (newTarget.field_via_correspondence 
            		&& (newTarget.value == null || newTarget.value.length() == 0)) {
            	Logger.info("If Via Correspondence field has value 'Yes', the Notes field is required.");
	  			flash("message", "If Via Correspondence field has value 'Yes', the Notes field is required.");
	  			return info();
            }
            newTarget.field_professional_judgement = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_PROFESSIONAL_JUDGEMENT));
            newTarget.field_professional_judgement_exp = getFormParam(Const.FIELD_PROFESSIONAL_JUDGEMENT_EXP);
            Logger.debug("newTarget.field_professional_judgement: " + newTarget.field_professional_judgement);
            if (newTarget.field_professional_judgement 
            		&& (newTarget.field_professional_judgement_exp == null || newTarget.field_professional_judgement_exp.length() == 0)) {
            	Logger.info("If Professional Judgement field has value 'Yes', the Professional Judgment Explanation field is required.");
	  			flash("message", "If Professional Judgement field has value 'Yes', the Professional Judgment Explanation field is required.");
	  			return info();
            }
            newTarget.field_no_ld_criteria_met = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_NO_LD_CRITERIA_MET));
//            Logger.info("ignore robots: " + getFormParam(Const.FIELD_IGNORE_ROBOTS_TXT));
            newTarget.field_ignore_robots_txt = Utils.getNormalizeBooleanString(getFormParam(Const.FIELD_IGNORE_ROBOTS_TXT));
            if (getFormParam(Const.FIELD_CRAWL_START_DATE) != null) {
            	String startDateHumanView = getFormParam(Const.FIELD_CRAWL_START_DATE);
            	String startDateUnix = Utils.getUnixDateStringFromDate(startDateHumanView);
            	Logger.info("startDateHumanView: " + startDateHumanView + ", startDateUnix: " + startDateUnix);
            	// TODO: UNIX DATE
//            	newTarget.fieldCrawlStartDate = startDateUnix;
            }
        	// TODO: UNIX DATE
//            newTarget.dateOfPublication = getFormParam(Const.DATE_OF_PUBLICATION);
//            newTarget.fieldCrawlEndDate = getFormParam(Const.FIELD_CRAWL_END_DATE);
            if (getFormParam(Const.FIELD_CRAWL_END_DATE) != null) {
            	String endDateHumanView = getFormParam(Const.FIELD_CRAWL_END_DATE);
            	String endDateUnix = Utils.getUnixDateStringFromDate(endDateHumanView);
            	Logger.info("endDateHumanView: " + endDateHumanView + ", endDateUnix: " + endDateUnix);
            	// TODO: UNIX DATE
//            	newTarget.fieldCrawlEndDate = endDateUnix;
            }
            newTarget.whiteList = getFormParam(Const.WHITE_LIST);
            newTarget.blackList = getFormParam(Const.BLACK_LIST);
            if (getFormParam(Const.FIELD_DEPTH) != null) {
            	newTarget.field_depth = getDepthNameFromGuiName(getFormParam(Const.FIELD_DEPTH));
            }
            newTarget.field_crawl_frequency = getFormParam(Const.FIELD_CRAWL_FREQUENCY);
            if (getFormParam(Const.FIELD_SCOPE) != null) {
            	newTarget.field_scope = getScopeNameFromGuiName(getFormParam(Const.FIELD_SCOPE));
            }
            newTarget.keywords = getFormParam(Const.KEYWORDS);
            newTarget.synonyms = getFormParam(Const.SYNONYMS);
            newTarget.active = true;
            long unixTime = System.currentTimeMillis() / 1000L;
            String changedTime = String.valueOf(unixTime);
            Logger.info("changed time: " + changedTime);
        	if (!isExisting) {
        		newTarget.url = Const.ACT_URL + newTarget.id;
        		newTarget.edit_url = Const.WCT_URL + newTarget.id;
        	} else {
                target.active = false;
            	if (target.fieldUrl() != null) {
                	Logger.info("current target field_url: " + target.fieldUrl());
//            		target.domain = Scope.INSTANCE.getDomainFromUrl(target.fieldUrl());
            	}
        		Logger.info("update target: " + target.id + ", obj: " + target.toString());
                boolean newScope = Target.isInScopeIp(target.fieldUrl(), target.url);
                // TODO: save new entry or update current
            	Scope.INSTANCE.updateLookupEntry(target, newScope);
                /**
                 * Reset association fields
                 */
                target.organisation = null;
                target.collections = null;
                target.subjects = null;
                // TODO: can we not use JPA annotations for these?
                Utils.removeAssociationFromDb(Const.SUBJECT_TARGET, Const.ID + "_" + Const.TARGET, target.id);
                Utils.removeAssociationFromDb(Const.COLLECTION_TARGET, Const.ID + "_" + Const.TARGET, target.id);
                Utils.removeAssociationFromDb(Const.LICENSE_TARGET, Const.ID + "_" + Const.TARGET, target.id);
                Utils.removeAssociationFromDb(Const.FLAG_TARGET, Const.ID + "_" + Const.TARGET, target.id);
                Utils.removeAssociationFromDb(Const.TAG_TARGET, Const.ID + "_" + Const.TARGET, target.id);
//                target.flagToTarget = null;
//                target.tagToTarget = null;
                Logger.info("+++ subject_to_target object before target nid: " + target.id + ", update: " + target.subjects);
            	Ebean.update(target);
        	}
        	if (newTarget.fieldUrl() != null) {
            	Logger.info("current target field_url: " + newTarget.fieldUrl());
//        		newTarget.domain = Scope.INSTANCE.getDomainFromUrl(newTarget.fieldUrl());
        	}
        	
        	// TODO: UNIX DATE
//        	newTarget.changed = changedTime;
        	if (newTarget.createdAt == null) {
        		if (target != null && target.createdAt != null) {
        			Logger.info("The creation time remains the same like in original revision of the target: " + target.createdAt);
        			newTarget.createdAt = target.createdAt;
        		} else {
//        			newTarget.createdAt = changedTime;
        		}
        	}
            boolean newScope = Target.isInScopeIp(newTarget.fieldUrl(), newTarget.url);
            // TODO: save new entry or update current
            Scope.INSTANCE.updateLookupEntry(newTarget, newScope);
        	
        	/**
        	 * NPLD scope values
        	 */
            // TODO: KL NOW IN fieldUrls
//        	newTarget.isInScopeUkRegistration   = newTarget.isInScopeUkRegistration();
//        	newTarget.isInScopeDomain           = newTarget.isInScopeDomain();
//        	newTarget.isUkHosting               = newTarget.isUkHosting();
//        	newTarget.isInScopeIp               = newScope;
//        	newTarget.isInScopeIpWithoutLicense = Target.isInScopeIpWithoutLicense(newTarget.fieldUrl(), newTarget.url);
        	
//        	Iterator<Taxonomy> itrSubjects = subjects.iterator();
//        	while (itrSubjects.hasNext()) {
//        		Logger.info("+++ subject_to_target before target save: " + itrSubjects.next().toString());
//        	}
        	Ebean.save(newTarget);
        	try {
	            /**
	             * Create or update association between CrawlPermission and Target
	             */
	            CrawlPermission crawlPermission = CrawlPermission.findByTarget(newTarget.fieldUrl());
	            Ebean.update(crawlPermission);
        	} catch (Exception e) {
        		Logger.info("No crawl permission to update for URL: " + newTarget.fieldUrl());
        	}
	        Logger.info("Your changes have been saved: " + newTarget.toString());
  			flash("message", "Your changes have been saved.");
	        res = redirect(routes.TargetController.viewAct(newTarget.url) + getFormParam(Const.TAB_STATUS));
        } // end of save
        if (delete != null) {
        	Long id = Long.valueOf(getFormParam(Const.ID));
        	Logger.info("deleting: " + id);
        	Target target = Target.findById(id);
        	Ebean.delete(target);
	        res = redirect(routes.TargetController.index()); 
        }
        if (request != null) {
            Logger.debug("request permission for title: " + getFormParam(Const.TITLE) + 
            		" and target: " + getFormParam(Const.FIELD_URL_NODE));
        	if (getFormParam(Const.TITLE) != null && getFormParam(Const.FIELD_URL_NODE) != null) {
                String name = getFormParam(Const.TITLE);
                String target = Scope.INSTANCE.normalizeUrl(getFormParam(Const.FIELD_URL_NODE));
    	        res = redirect(routes.CrawlPermissions.licenceRequestForTarget(name, target)); 
        	}
        }
        if (archive != null) {
            Logger.debug("archive target title: " + getFormParam(Const.TITLE) + 
            		" with URL: " + getFormParam(Const.FIELD_URL_NODE));
        	if (getFormParam(Const.FIELD_URL_NODE) != null) {
                String target = Scope.INSTANCE.normalizeUrl(getFormParam(Const.FIELD_URL_NODE));
    	        res = redirect(routes.TargetController.archiveTarget(target)); 
        	}
        }
        return res;
    }
	
    /**
     * This method pushes a message onto a RabbitMQ queue for given target
     * using global settings from project configuration file.
     * @param target The field URL of the target
     * @return
     */
    public static Result archiveTarget(String target) {    	
    	Logger.debug("archiveTarget() " + target);
    	if (target != null && target.length() > 0) {
    		try {
		    	String queueHost = Play.application().configuration().getString(Const.QUEUE_HOST);
		    	String queuePort = Play.application().configuration().getString(Const.QUEUE_PORT);
		    	String queueName = Play.application().configuration().getString(Const.QUEUE_NAME);
		    	String routingKey = Play.application().configuration().getString(Const.ROUTING_KEY);
		    	String exchangeName = Play.application().configuration().getString(Const.EXCHANGE_NAME);
	
		    	Logger.debug("archiveTarget() queue host: " + queueHost);
		      	Logger.debug("archiveTarget() queue port: " + queuePort);
		      	Logger.debug("archiveTarget() queue name: " + queueName);
		      	Logger.debug("archiveTarget() routing key: " + routingKey);
		      	Logger.debug("archiveTarget() exchange name: " + exchangeName);
	
		      	ConnectionFactory factory = new ConnectionFactory();
		    	if (queueHost != null) {
		    		factory.setHost(queueHost);
		    	}
		    	if (queuePort != null) {
		    		factory.setPort(Integer.parseInt(queuePort));
		    	}
		    	Connection connection = factory.newConnection();
		    	Channel channel = connection.createChannel();
	
		    	channel.exchangeDeclare(exchangeName, "direct", true);
		    	channel.queueDeclare(queueName, true, false, false, null);
		    	channel.queueBind(queueName, exchangeName, routingKey);
		    	String message = target;
		    	channel.basicPublish(exchangeName, routingKey, null, message.getBytes());
		    	Logger.debug(" ### sent target '" + message + "' to queue");    	    
		    	channel.close();
		    	connection.close();
	    	
	    	} catch (IOException e) {
	    		String msg = "There was a problem queuing this crawl instruction. Please refer to the system administrator.";
	    		User currentUser = User.findByEmail(request().username());
    	    	StringWriter sw = new StringWriter();
    	    	e.printStackTrace(new PrintWriter(sw));
    	    	String msgFullTrace = sw.toString();
	    		Logger.error(msgFullTrace);
	    	    if (currentUser.hasRole("sys_admin")) {
	    	    	msg = msgFullTrace;
	    	    }
	            return ok(infomessage.render(msg));
	    	} catch (Exception e) {
	    		String msg = "There was a problem queuing this crawl instruction. Please refer to the system administrator.";
	    		User currentUser = User.findByEmail(request().username());
    	    	StringWriter sw = new StringWriter();
    	    	e.printStackTrace(new PrintWriter(sw));
    	    	String msgFullTrace = sw.toString();
	    		Logger.error(msgFullTrace);
	    	    if (currentUser.hasRole("sys_admin")) {
	    	    	msg = msgFullTrace;
	    	    }
	            return ok(infomessage.render(msg));
	    	}    	      
    	} else {
    		Logger.debug("There was a problem sending the message. Target field for archiving is empty");
            return ok(infomessage.render("There was a problem sending the message. Target field for archiving is empty"));
    	}
		return ok(
	            ukwalicenceresult.render()
	        );
    }
          
    /**
     * This method is checking scope for given URL and returns result in JSON format.
     * @param url
     * @return JSON result
     * @throws WhoisException 
     */
    public static Result isInScope(String url) throws WhoisException {
//    	Logger.info("isInScope controller: " + url);
    	boolean res = Target.isInScope(url, null);
//    	Logger.info("isInScope res: " + res);
    	return ok(Json.toJson(res));
    }
    
    /**
     * This method calculates collection children - objects that have parents.
     * @param url The identifier for parent 
     * @param targetUrl This is an identifier for current target object
     * @return child collection in JSON form
     */
    public static String getChildren(String url, String targetUrl) {
//    	Logger.info("getChildren() target URL: " + targetUrl);
    	String res = "";
        final StringBuffer sb = new StringBuffer();
    	sb.append(", \"children\":");
    	List<Collection> childSuggestedCollections = Collection.getChildLevelCollections(url);
    	if (childSuggestedCollections.size() > 0) {
	    	sb.append(getTreeElements(childSuggestedCollections, targetUrl, false));
	    	res = sb.toString();
//	    	Logger.info("getChildren() res: " + res);
    	}
    	return res;
    }
    
    /**
     * Mark collections that are stored in target object as selected
     * @param collectionUrl The collection identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkSelection(String collectionUrl, String targetUrl) {
    	String res = "";
    	if (targetUrl != null && targetUrl.length() > 0) {
    		Target target = Target.findByUrl(targetUrl);
    		if (target.collections != null && 
    				target.collections.contains(collectionUrl)) {
    			res = "\"select\": true ,";
    		}
    	}
    	return res;
    }
    
    /**
     * Mark preselected collections as selected in filter
     * @param collectionUrl The collection identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkSelectionFilter(String collectionUrl, String targetUrl) {
    	String res = "";
    	if (targetUrl != null && targetUrl.length() > 0) {
    		if (collectionUrl != null && targetUrl.equals(collectionUrl)) {
    			res = "\"select\": true ,";
    		}
    	}
    	return res;
    }
    
    /**
   	 * This method calculates first order collections.
     * @param collectionList The list of all collections
     * @param targetUrl This is an identifier for current target object
     * @param parent This parameter is used to differentiate between root and children nodes
     * @return collection object in JSON form
     */
    public static String getTreeElements(List<Collection> collectionList, String targetUrl, boolean parent) { 
//    	Logger.info("getTreeElements() target URL: " + targetUrl);
    	String res = "";
    	if (collectionList.size() > 0) {
	        final StringBuffer sb = new StringBuffer();
	        sb.append("[");
	    	Iterator<Collection> itr = collectionList.iterator();
	    	boolean firstTime = true;
	    	while (itr.hasNext()) {
	    		Collection collection = itr.next();
//    			Logger.debug("add collection: " + collection.name + ", with url: " + collection.url +
//    					", parent:" + collection.parent + ", parent size: " + collection.parent.length());
	    		if ((parent && collection.parent == null) || !parent || collection.parent == null) {
		    		if (firstTime) {
		    			firstTime = false;
		    		} else {
		    			sb.append(", ");
		    		}
//	    			Logger.debug("added");
					sb.append("{\"title\": \"" + collection.name + "\"," + checkSelection(collection.url, targetUrl) + 
							" \"key\": \"" + collection.url + "\"" + 
							getChildren(collection.url, targetUrl) + 
							"}");
	    		}
	    	}
//	    	Logger.info("collectionList level size: " + collectionList.size());
	    	sb.append("]");
	    	res = sb.toString();
//	    	Logger.info("getTreeElements() res: " + res);
    	}
    	return res;
    }
    
    /**
   	 * This method calculates first order collections for filtering.
     * @param collectionList The list of all collections
     * @param targetUrl This is an identifier for current target object
     * @param parent This parameter is used to differentiate between root and children nodes
     * @return collection object in JSON form
     */
    public static String getTreeElementsFilter(List<Collection> collectionList, String targetUrl, boolean parent) { 
//    	Logger.info("getTreeElements() target URL: " + targetUrl);
    	String res = "";
    	if (collectionList.size() > 0) {
	        final StringBuffer sb = new StringBuffer();
	        sb.append("[");
	    	Iterator<Collection> itr = collectionList.iterator();
	    	boolean firstTime = true;
	    	while (itr.hasNext()) {
	    		Collection collection = itr.next();
//    			Logger.debug("add collection: " + collection.name + ", with url: " + collection.url +
//    					", parent:" + collection.parent + ", parent size: " + collection.parent.length());
	    		if ((parent && collection.parent == null) || !parent || collection.parent == null) {
		    		if (firstTime) {
		    			firstTime = false;
		    		} else {
		    			sb.append(", ");
		    		}
//	    			Logger.debug("added");
					sb.append("{\"title\": \"" + collection.name + "\"," + checkSelectionFilter(collection.url, targetUrl) + 
							" \"key\": \"" + collection.url + "\"" + 
							getChildren(collection.url, targetUrl) + 
							"}");
	    		}
	    	}
//	    	Logger.info("collectionList level size: " + collectionList.size());
	    	sb.append("]");
	    	res = sb.toString();
//	    	Logger.info("getTreeElements() res: " + res);
    	}
    	return res;
    }
    
    /**
     * This method computes a tree of collections in JSON format. 
     * @param targetUrl This is an identifier for current target object
     * @return tree structure
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result getSuggestedCollections(String targetUrl) {
//    	Logger.info("getSuggestedCollections() target URL: " + targetUrl);
        JsonNode jsonData = null;
        final StringBuffer sb = new StringBuffer();
    	List<Collection> suggestedCollections = Collection.getFirstLevelCollections();
    	sb.append(getTreeElements(suggestedCollections, targetUrl, true));
//    	Logger.info("collections main level size: " + suggestedCollections.size());
        jsonData = Json.toJson(Json.parse(sb.toString()));
//    	Logger.info("getCollections() json: " + jsonData.toString());
        return ok(jsonData);
    }        
    
    /**
     * This method computes a tree of collections in JSON format for filtering. 
     * @param targetUrl This is an identifier for current target object
     * @return tree structure
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result getSuggestedCollectionsFilter(String targetUrl) {
//    	Logger.info("getSuggestedCollectionsFilter() target URL: " + targetUrl);
        JsonNode jsonData = null;
        final StringBuffer sb = new StringBuffer();
    	List<Collection> suggestedCollections = Collection.getFirstLevelCollections();
    	sb.append(getTreeElementsFilter(suggestedCollections, targetUrl, true));
//    	Logger.info("collections main level size: " + suggestedCollections.size());
        jsonData = Json.toJson(Json.parse(sb.toString()));
//    	Logger.info("getCollections() json: " + jsonData.toString());
        return ok(jsonData);
    }        
    
    /**
     * This method calculates subject children - objects that have parents.
     * @param url The identifier for parent 
     * @param targetUrl This is an identifier for current target object
     * @return child subject in JSON form
     */
    public static String getSubjectChildren(String url, String targetUrl) {
//    	Logger.info("getSubjectChildren() target URL: " + targetUrl);
    	String res = "";
        final StringBuffer sb = new StringBuffer();
    	sb.append(", \"children\":");
//    	List<Taxonomy> childSubject = Taxonomy.findListByType(Const.SUBSUBJECT);
    	Taxonomy subject = Taxonomy.findByUrl(url);
    	List<Taxonomy> childSubject = Taxonomy.findSubSubjectsList(subject.name);
    	if (childSubject.size() > 0) {
	    	sb.append(getSubjectTreeElements(childSubject, targetUrl, false));
	    	res = sb.toString();
//	    	Logger.info("getSubjectChildren() res: " + res);
    	}
    	return res;
    }
    
    /**
     * Mark subjects that are stored in target object as selected
     * @param subjectUrl The subject identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkSubjectSelection(String subjectUrl, String targetUrl) {
//    	String res = "";
//    	if (targetUrl != null && targetUrl.length() > 0) {
////    		if (subjectUrl != null && targetUrl.equals(subjectUrl)) {
//    		Target target = Target.findByUrl(targetUrl);
//    		if (target.fieldSubject != null && 
//    				target.fieldSubject.contains(subjectUrl)) {
//    			res = "\"select\": true ,";
//    		}
//    	}
//    	return res;
		throw new NotImplementedError();
    }
    
    /**
     * Mark preselected subjects as selected in filter
     * @param subjectUrl The subject identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkSubjectSelectionFilter(String subjectUrl, String targetUrl) {
    	String res = "";
    	if (targetUrl != null && targetUrl.length() > 0) {
    		if (subjectUrl != null && targetUrl.equals(subjectUrl)) {
    			res = "\"select\": true ,";
    		}
    	}
    	return res;
    }
    
    /**
     * Check if none value is selected in filter
     * @param subjectUrl The subject identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkNoneFilter(String targetUrl) {
    	String res = "";
    	if (targetUrl != null && targetUrl.length() > 0) {
    		if (targetUrl.toLowerCase().contains(Const.NONE.toLowerCase())) {
    			res = "\"select\": true ,";
    		}
    	}
    	return res;
    }
    
    /**
     * Check if none value is selected
     * @param subjectUrl The subject identifier
     * @param targetUrl This is an identifier for current target object
     * @return
     */
    public static String checkNone(String targetUrl) {
//    	String res = "";
//    	if (targetUrl != null && targetUrl.length() > 0) {
//    		Target target = Target.findByUrl(targetUrl);
//    		if (target.fieldSubject != null 
//    				&& (target.fieldSubject.toLowerCase().contains(Const.NONE.toLowerCase()))) {
//    			res = "\"select\": true ,";
//    		}
//    	}
//    	return res;
		throw new NotImplementedError();
    }
    
    /**
   	 * This method calculates first order subjects.
     * @param subjectList The list of all subjects
     * @param targetUrl This is an identifier for current target object
     * @param parent This parameter is used to differentiate between root and children nodes
     * @return collection object in JSON form
     */
    public static String getSubjectTreeElements(List<Taxonomy> subjectList, String targetUrl, boolean parent) { 
//    	Logger.info("getSubjectTreeElements() target URL: " + targetUrl);
    	String res = "";
    	if (subjectList.size() > 0) {
	        final StringBuffer sb = new StringBuffer();
	        sb.append("[");
	        if (parent) {
	        	sb.append("{\"title\": \"" + "None" + "\"," + checkNone(targetUrl) + 
	        			" \"key\": \"" + "None" + "\"" + "}, ");
	        }
	    	Iterator<Taxonomy> itr = subjectList.iterator();
	    	boolean firstTime = true;
	    	while (itr.hasNext()) {
	    		Taxonomy subject = itr.next();
//    			Logger.debug("add subject: " + subject.name + ", with url: " + subject.url +
//    					", parent:" + subject.parent + ", parent size: " + subject.parent.length());
	    		if ((parent && subject.parent == null) || !parent) {
		    		if (firstTime) {
		    			firstTime = false;
		    		} else {
		    			sb.append(", ");
		    		}
//	    			Logger.debug("added");
					sb.append("{\"title\": \"" + subject.name + "\"," + checkSubjectSelection(subject.url, targetUrl) + 
							" \"key\": \"" + subject.url + "\"" + 
							getSubjectChildren(subject.url, targetUrl) + 
							"}");
	    		}
	    	}
//	    	Logger.info("subjectList level size: " + subjectList.size());
	    	sb.append("]");
	    	res = sb.toString();
//	    	Logger.info("getSubjectTreeElements() res: " + res);
    	}
    	return res;
    }
        
    /**
   	 * This method calculates first order subjects for targets filtering.
     * @param subjectList The list of all subjects
     * @param targetUrl This is an identifier for current target object
     * @param parent This parameter is used to differentiate between root and children nodes
     * @return collection object in JSON form
     */
    public static String getSubjectTreeElementsFilter(List<Taxonomy> subjectList, String targetUrl, boolean parent) { 
//    	Logger.info("getSubjectTreeElements() target URL: " + targetUrl);
    	String res = "";
    	if (subjectList.size() > 0) {
	        final StringBuffer sb = new StringBuffer();
	        sb.append("[");
	        if (parent) {
	        	sb.append("{\"title\": \"" + "None" + "\"," + checkNoneFilter(targetUrl) + 
	        			" \"key\": \"" + "None" + "\"" + "}, ");
	        }
	    	Iterator<Taxonomy> itr = subjectList.iterator();
	    	boolean firstTime = true;
	    	while (itr.hasNext()) {
	    		Taxonomy subject = itr.next();
//    			Logger.debug("add subject: " + subject.name + ", with url: " + subject.url +
//    					", parent:" + subject.parent + ", parent size: " + subject.parent.length());
	    		if ((parent && subject.parent == null) || !parent) {
		    		if (firstTime) {
		    			firstTime = false;
		    		} else {
		    			sb.append(", ");
		    		}
//	    			Logger.debug("added");
					sb.append("{\"title\": \"" + subject.name + "\"," + checkSubjectSelectionFilter(subject.url, targetUrl) + 
							" \"key\": \"" + subject.url + "\"" + 
							getSubjectChildren(subject.url, targetUrl) + 
							"}");
	    		}
	    	}
//	    	Logger.info("subjectList level size: " + subjectList.size());
	    	sb.append("]");
	    	res = sb.toString();
//	    	Logger.info("getSubjectTreeElements() res: " + res);
    	}
    	return res;
    }
        
    /**
     * This method computes a tree of subjects in JSON format. 
     * @param targetUrl This is an identifier for current target object
     * @return tree structure
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result getSubjectTree(String targetUrl) {
    	Logger.info("getSubjectTree() target URL: " + targetUrl);
        JsonNode jsonData = null;
        final StringBuffer sb = new StringBuffer();
    	List<Taxonomy> parentSubjects = Taxonomy.findListByTypeSorted(Const.SUBJECT);
//    	Logger.info("getSubjectTree() parentSubjects: " + parentSubjects.size());
    	sb.append(getSubjectTreeElements(parentSubjects, targetUrl, true));
    	Logger.info("subjects main level size: " + parentSubjects.size());
//    	Logger.info("sb.toString(): " + sb.toString());
        jsonData = Json.toJson(Json.parse(sb.toString()));
//    	Logger.info("getSubjectTree() json: " + jsonData.toString());
        return ok(jsonData);
    }        
    
    /**
     * This method computes a tree of subjects in JSON format. 
     * @param targetUrl This is an identifier for current target object
     * @return tree structure
     */
    @BodyParser.Of(BodyParser.Json.class)
    public static Result getSubjectTreeFilter(String targetUrl) {
    	Logger.info("getSubjectTree() target URL: " + targetUrl);
        JsonNode jsonData = null;
        final StringBuffer sb = new StringBuffer();
    	List<Taxonomy> parentSubjects = Taxonomy.findListByTypeSorted(Const.SUBJECT);
//    	Logger.info("getSubjectTree() parentSubjects: " + parentSubjects.size());
    	sb.append(getSubjectTreeElementsFilter(parentSubjects, targetUrl, true));
    	Logger.info("subjects main level size: " + parentSubjects.size());
//    	Logger.info("sb.toString(): " + sb.toString());
        jsonData = Json.toJson(Json.parse(sb.toString()));
//    	Logger.info("getSubjectTree() json: " + jsonData.toString());
        return ok(jsonData);
    }        
    
}

