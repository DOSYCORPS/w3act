package models;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import play.db.ebean.Model;
import uk.bl.Const;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Version;

import com.avaje.ebean.ExpressionList;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Permission extends Model
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2250099575468302989L;

	@Id @JsonIgnore
    public Long id;

    @Column(columnDefinition = "TEXT")
    public String name;

    @Column(columnDefinition = "TEXT")
    public String url;
    
    @JsonIgnore
    @Column(columnDefinition = "TEXT")
    public String description;
    
    @JsonIgnore
    @Column(columnDefinition = "TEXT")
    public String revision; 
    
    @JsonIgnore
    @Version
    public Timestamp lastUpdate;

    public static final Model.Finder<Long, Permission> find = new Model.Finder<Long, Permission>(Long.class, Permission.class);

    public String getName()
    {
        return name;
    }

    public static Permission findByName(String name)
    {
        return find.where()
                   .eq("name",
                       name)
                   .findUnique();
    }
    
    /**
     * Retrieve a permission by URL.
     * @param url
     * @return permission name
     */
    public static Permission findByUrl(String url) {
//    	Logger.info("permission findByUrl: " + url);
    	Permission res = new Permission();
    	if (url != null && url.length() > 0 && !url.equals(Const.NONE)) {
    		res = find.where().eq(Const.URL, url).findUnique();
    	} else {
    		res.name = Const.NONE;
    	}
    	return res;
    }

	/**
	 * This method filters permissions by name and returns a list of filtered Permission objects.
	 * @param name
	 * @return
	 */
	public static List<Permission> filterByName(String name) {
		List<Permission> res = new ArrayList<Permission>();
        ExpressionList<Permission> ll = find.where().icontains(Const.NAME, name);
    	res = ll.findList();
		return res;
	}
        
    /**
     * Retrieve all permissions.
     */
    public static List<Permission> findAll() {
        return find.all();
    }
    
    public String toString() {
        return "Permission(" + name + ")" + ", id:" + id;
    }
    
    public static boolean isIncluded(String permissionName, String permissions) {
    	boolean res = false;
    	if (permissionName != null && permissionName.length() > 0 && permissions != null && permissions.length() > 0 ) {
    		if (permissions.contains(Const.COMMA)) {
    			List<String> resList = Arrays.asList(permissions.split(Const.COMMA));
    			Iterator<String> itr = resList.iterator();
    			while (itr.hasNext()) {
        			String currentRoleName = itr.next();
        			currentRoleName = currentRoleName.replaceAll(" ", "");
        			if (currentRoleName.equals(permissionName)) {
        				res = true;
        				break;
        			}
    			}
    		} else {
    			if (permissions.equals(permissionName)) {
    				res = true;
    			}
    		}
    	}
    	return res;
    }

}