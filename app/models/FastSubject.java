package models;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.avaje.ebean.Expr;
import com.avaje.ebean.Page;

import play.db.ebean.Model;

@Entity
public class FastSubject extends Model {
	
	/** */
	private static final long serialVersionUID = -5397834285059204305L;

	@Id
	public Long id;
	
	public String fastId;
	
	public String name;
	
	public static final Model.Finder<Long, FastSubject> find = new Model.Finder<>(Long.class, FastSubject.class);
	
	public static Page<FastSubject> page(int page, int pageSize, String sortBy, String order, String filter) {
        return find.where().add(Expr.or(Expr.icontains("fast_id", filter), Expr.icontains("name", filter)))
        		.orderBy(sortBy + " " + order)
        		.findPagingList(pageSize)
        		.setFetchAhead(false)
        		.getPage(page);
    }

    public static FastSubject findById(Long id) {
        FastSubject fs = find.where().eq("id", id).findUnique();
        return fs;
    }

}