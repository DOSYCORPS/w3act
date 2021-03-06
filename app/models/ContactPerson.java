package models;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import play.Logger;
import play.data.validation.Constraints.Required;
import play.db.ebean.Model;
import uk.bl.Const;

import com.avaje.ebean.ExpressionList;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * This class describes the contact person details.
 */
@Entity
@Table(name = "contact_person")
public class ContactPerson extends ActModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2257099575463302989L;

    //bi-directional one-to-many association to CrawlPermission
	@JsonIgnore
    @OneToMany(mappedBy="contactPerson", cascade=CascadeType.ALL)
    public List<CrawlPermission> crawlPermissions;

    /**
     * The name of the contact person.
     */
    @Column(columnDefinition = "text")
    public String name;
    
    /**
     * The job or position of the contact person within the relevant organisation.
     */
    @Column(columnDefinition = "text")
    public String position;
    
    /**
     * Telephone contact details of the contact.
     */
    @Column(columnDefinition = "text")
    public String phone;
    
    /**
     * E-mail address of the contact person.
     */
    @Required(message="Email is required")
    @Column(columnDefinition = "text")
    public String email;
    
    /**
     * The postal address of the contact person.
     */
    @Column(columnDefinition = "text")
    public String postalAddress;
    
    /**
     * The URL of a contact web form 
     * (in the absence of a known email address).
     */
    @Column(columnDefinition = "text")
    public String webForm;
    
    @Column(columnDefinition = "text")
    public String description;
    
    @Column(columnDefinition = "text")
    public String contactOrganisation; 
       
    /**
     * This is a checkbox defining whether this contact
     * should be regarded as the first/default contact.
     */
    public Boolean defaultContact;
    
    /**
     * This field indicates that an initial form response to
     * permission request has been inspected by Archivist.
     */
    public Boolean permissionChecked;
    
    public static final Model.Finder<Long, ContactPerson> find = new Model.Finder<Long, ContactPerson>(Long.class, ContactPerson.class);

    public ContactPerson() {}

	public ContactPerson(Long id, String url) {
		this.id = id;
		this.url = url;
	}

    public List<CrawlPermission> getCrawlPermissions() {
    	return this.crawlPermissions;
    }
    
    public void setCrawlPermissions(List<CrawlPermission> crawlPermissions) {
    	this.crawlPermissions = crawlPermissions;
    }    
    
    /**
     * Check for disconnected ones:
     * 
     * @return
     */
    public List<CrawlPermission> scanForAllCrawlPermissions() {
    	List<CrawlPermission> match = new ArrayList<CrawlPermission>();
    	List<CrawlPermission> allcp = CrawlPermission.findAll();
    	for( CrawlPermission cp : allcp ) {
    		if( cp.contactPerson.id != null && cp.contactPerson.id.equals(id)){
    			match.add(cp);
    		}
    	}
    	return match;
    }
    


    public static ContactPerson findByName(String name)
    {
        return find.where()
                   .eq("name",
                       name)
                   .findUnique();
    }

    /**
     * Retrieve an object by Id (id).
     * @param id
     * @return object 
     */
    public static ContactPerson findById(Long id) {
    	ContactPerson res = find.where().eq(Const.ID, id).findUnique();
    	return res;
    }          
    
    /**
     * Retrieve a contact person by URL.
     * @param url
     * @return contact person name
     */
    public static ContactPerson findByUrl(String url) {
    	ContactPerson res = new ContactPerson();
    	if (url != null && url.length() > 0 && !url.equals(Const.NONE)) {
    		try {
    			res = find.where().eq(Const.URL, url).findUnique();
    			if (res == null) {
    				res = new ContactPerson();
    				res.name = Const.NONE;
    			}
    		} catch (Exception e) {
    			Logger.debug("Contact person: findByUrl error: " + e);
    			res.name = Const.NONE;
    			return res;
    		}    			
    	} else {
    		res.name = Const.NONE;
    	}
    	return res;
    }

    
	/**
	 * This method filters contact persons by name and returns a list 
	 * of filtered contact person objects.
	 * @param name
	 * @return
	 */
	public static List<ContactPerson> filterByName(String name) {
		List<ContactPerson> res = new ArrayList<ContactPerson>();
        ExpressionList<ContactPerson> ll = find.where().icontains(Const.NAME, name);
    	res = ll.findList();
		return res;
	}
        
	/**
	 * This method filters contact persons by email and returns a list 
	 * of filtered contact person objects.
	 * @param email
	 * @return
	 */
	public static List<ContactPerson> filterByEmail(String email) {
		List<ContactPerson> res = new ArrayList<ContactPerson>();
        ExpressionList<ContactPerson> ll = find.where().icontains(Const.EMAIL, email);
    	res = ll.findList();
		return res;
	}
	
	public static ContactPerson findByEmail(String email) {
		List<ContactPerson> cps = find.where().ieq("email", email).findList();
		if( cps == null || cps.size() == 0) {
			return null;
		}
		if( cps.size() > 1 ) {
			Logger.warn("Multiple entries found for Contact Persons with email address: "+email);
		}
		return cps.get(0);
	}
        
    /**
     * This method is used to show contact person in a table.
     * It shows none value if no entry was found in database.
     * @param url
     * @return
     */
    public static ContactPerson showByUrl(String url) {
    	Logger.debug("person findByUrl: " + url);
    	ContactPerson res = new ContactPerson();
    	if (url != null && url.length() > 0 && !url.equals(Const.NONE)) {
    		try {
    			res = find.where().eq(Const.URL, url).findUnique();
            	if (res == null) {
                	res = new ContactPerson();
                	res.name = Const.NONE;            	}
    		} catch (Exception e) {
    			Logger.debug("contact person could not be find in database: " + e);
    		}
    	} else {
        	res.name = Const.NONE;
    	}
    	Logger.debug("contact person res: " + res);
    	return res;
    }
    	
    /**
     * Retrieve all contact persons.
     */
    public static List<ContactPerson> findAll() {
        return find.all();
    }
       
    /**
     * Retrieve the contact person names by URL list given as a string.
     * @param url
     * @return contact person name list
     */
    public static String findNamesByUrls(String urls) {
    	String res = "";
		Logger.debug("findNamesByUrls urls: " + urls);
    	if (urls != null) {
    		if (urls.contains(Const.LIST_DELIMITER)) {
		    	String[] parts = urls.split(Const.LIST_DELIMITER);
		    	for (String part: parts)
		        {
		    		try {
			    		String name = findByUrl(part).name;
			    		res = res + name + Const.LIST_DELIMITER;
		    		} catch (Exception e) {
		    			Logger.debug("findNamesByUrls error: " + e);
		    		}
		        }
	    	} else {
	    		if (urls.length() > 0 && !urls.equals(Const.NONE)) {
	    			res = findByUrl(urls).name;   
	    		}
	    	}
    	}
		Logger.debug("findNamesByUrls res: " + res);
    	return res;
    }          
	    
    /**
     * Retrieve the contact person emails by URL list given as a string.
     * @param urls
     * @param allMails
     * @return contact person email list
     */
    public static String findEmailsByUrls(String urls, String allMails) {
    	String res = "";
    	if (urls != null) {
	    	if (urls.contains(Const.LIST_DELIMITER)) {
		    	String[] parts = urls.split(Const.LIST_DELIMITER);
		    	for (String part: parts)
		        {
		    		try {
			    		String email = findByUrl(part).email;
			    		if (email != null && !res.contains(email) && !allMails.contains(email)) {
		//	    			System.out.println("test mail: " + email + ", res: " + res);
			    			res = res + email + Const.LIST_DELIMITER;
			    		}
		    		} catch (Exception e) {
		    			System.out.println("findEmailsByUrls error: " + e);
		    		}
		        }
	    	} else {
	    		if (urls.length() > 0 && !urls.equals(Const.NONE)) {
	    			res = findByUrl(urls).email;   
	    		}
	    	}
    	}
    	return res;
    }          
	    
    
	@Override
    public String toString() {
        return "ContactPerson(" + name + ")" + ", id:" + id;
    }
    
    public static ContactPerson create(Long id, String url) {
    	return new ContactPerson(id, url);
    }

}