package models;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.Version;

import org.apache.commons.lang3.StringUtils;

import play.Logger;
import play.data.validation.Constraints;
import play.db.ebean.Model;
import uk.bl.Const;
import uk.bl.api.Utils;
import uk.bl.api.models.FieldModel;

import com.avaje.ebean.ExpressionList;
import com.avaje.ebean.Page;
import com.avaje.ebean.QueryIterator;
import com.avaje.ebean.annotation.Transactional;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * Instance instance entity managed by Ebean
 */
@Entity 
@Table(name = "instance")
public class Instance extends Model {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4285620218930401425L;

	@Id
    public Long id;
	
	@JsonProperty
	@Column(unique=true)
	public String url;

    public Date createdAt;

    @Version
    public Timestamp updatedAt;
    
    @Constraints.Required(message="Title Required")
	public String title;
	
	public String language;
	
	public String secondLanguage;

	@Column(columnDefinition = "text")
	public String revision;

	@JsonProperty
	public String edit_url;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "qaissue_id")
	public QaIssue qaIssue;

	@JsonIgnore
	@Column(columnDefinition = "text")
	public String notes;
		
	@JsonIgnore
	public String format;


	public String getEdit_url() {
		return edit_url;
	}

	public void setEdit_url(String edit_url) {
		this.edit_url = edit_url;
	}
	    
    @Override
    @Transactional
	public void save() {
    	// need to save to get the ID
    	super.save();
    	if (StringUtils.isEmpty(this.url)) {
    		this.url = Const.ACT_URL + this.id;
    	}
    	if (createdAt == null) {
    		this.createdAt = new Date();
    	}
    	super.save();
    }
    
	public String toCreatedAtString() {
		return Utils.INSTANCE.convertToDateString(createdAt);
	}
	
	public String toUpdatedAtString() {
		return Utils.INSTANCE.convertToDateTime(updatedAt);
	}
	
	public String qaIssueCategory;
    
//  Description of QA Issues (Andy's ACT) > QA Notes (w3ACT)
    @Column(columnDefinition = "text")
    public String qaNotes;
    
//  Body/Notes (Andy's ACT) > Quality Notes (currently in Wc3ACT) but which we should rename TEchnical Notes.
//    use notes
//    @Column(columnDefinition = "text")
//	public String technicalNotes;
    
    @JsonIgnore
	@ManyToOne
	@JoinColumn(name = "target_id")
	public Target target;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "author_id")
	public User authorUser;
	
	public Boolean hidden;
	
    public Date fieldTimestamp;
	
    @Column(columnDefinition = "text")
    public String value;
    
    @Column(columnDefinition = "text")
    public String summary;
    
    public Date fieldDate;
    
    /** Crawl metadata */
    public String crawl_seeds;
    public Date crawl_scheduled_start_date;
    public Date crawl_actual_start_date;
    public Long crawl_duration_millis;
    public Long crawl_bytes_downloaded;
    public Long crawl_urls_downloaded;
    public Long crawl_urls_failed;   
    public String crawl_additional_information;
    
	@Transient
	@JsonProperty
	private String field_timestamp;
	
	@Transient
	@JsonProperty
	private FieldModel field_qa_issues;

	@Transient
	@JsonProperty
	private FieldModel field_target;

	@Transient
	@JsonProperty
	private Object field_description_of_qa_issues;
	
	@Transient
	@JsonProperty
	private Boolean field_published;
	
	@Transient
	@JsonProperty
	private Boolean field_to_be_published_;

//	"body":{
//		"value":"\u003Cp\u003EWCT ID: 179535873\u003Cbr \/\u003E\nSeeds: [\u0027\u003Ca href=\u0022http:\/\/www.islamic-relief.org.uk\/\u0022\u003Ehttp:\/\/www.islamic-relief.org.uk\/\u003C\/a\u003E\u0027]\u003Cbr \/\u003E\nJob ID: weekly-mon2300\u003Cbr \/\u003E\nWayback URLs: \u003Ca href=\u0022http:\/\/opera.bl.uk:8080\/wayback\/20140127231546\/http:\/\/www.islamic-relief.org.uk\/\u0022\u003Ehttp:\/\/opera.bl.uk:8080\/wayback\/20140127231546\/http:\/\/www.islamic-relief...\u003C\/a\u003E\u003C\/p\u003E\n\u003Cpre\u003E\n{\n        \u0022www.islamic-relief.org.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u0022200\u0022:15743,\n                        \u00220\u0022:1,\n                        \u0022301\u0022:277,\n                        \u0022302\u0022:8,\n                        \u00221\u0022:1,\n                        \u0022404\u0022:58,\n                        \u0022-6\u0022:1,\n                        \u0022502\u0022:6\n                },\n                \u0022data_size\u0022:\u0022554.0 MB\u0022\n        },\n        \u0022plus.google.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:293,\n                        \u0022404\u0022:7,\n                        \u0022301\u0022:1\n                },\n                \u0022data_size\u0022:\u00228.0 MB\u0022\n        },\n        \u0022www.youtube.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:69,\n                        \u0022302\u0022:4,\n                        \u0022303\u0022:5\n                },\n                \u0022data_size\u0022:\u00222.0 MB\u0022\n        },\n        \u0022www.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:175,\n                        \u0022302\u0022:2,\n                        \u0022404\u0022:3,\n                        \u0022301\u0022:2\n                },\n                \u0022data_size\u0022:\u00222.0 MB\u0022\n        },\n        \u0022s.ytimg.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:24,\n                        \u0022-7\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022451.0 kB\u0022\n        },\n        \u0022news.bbcimg.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:91\n                },\n                \u0022data_size\u0022:\u0022185.0 kB\u0022\n        },\n        \u0022prezi.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:4,\n                        \u0022302\u0022:1\n                },\n                \u0022data_size\u0022:\u0022105.0 kB\u0022\n        },\n        \u0022opera.bl.uk:9090\u0022:{\n                \u0022response_codes\u0022:{\n                        \u0022200\u0022:6\n                },\n                \u0022data_size\u0022:\u002279.0 kB\u0022\n        },\n        \u0022node1.bbcimg.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:52\n                },\n                \u0022data_size\u0022:\u002250.0 kB\u0022\n        },\n        \u0022dublincore.org\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:10\n                },\n                \u0022data_size\u0022:\u002240.0 kB\u0022\n        },\n        \u0022gmpg.org\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:10\n                },\n                \u0022data_size\u0022:\u002234.0 kB\u0022\n        },\n        \u0022static.bbci.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:29\n                },\n                \u0022data_size\u0022:\u002231.0 kB\u0022\n        },\n        \u0022www.google.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:4\n                },\n                \u0022data_size\u0022:\u002225.0 kB\u0022\n        },\n        \u0022www.google.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:4\n                },\n                \u0022data_size\u0022:\u002225.0 kB\u0022\n        },\n        \u0022platform.twitter.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2,\n                        \u0022-7\u0022:1,\n                        \u0022403\u0022:4\n                },\n                \u0022data_size\u0022:\u002218.0 kB\u0022\n        },\n        \u0022www.flickr.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00227.0 kB\u0022\n        },\n        \u0022emp.bbci.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022302\u0022:2\n                },\n                \u0022data_size\u0022:\u00226.0 kB\u0022\n        },\n        \u0022maps.gstatic.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00226.0 kB\u0022\n        },\n        \u0022ajax.googleapis.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00225.0 kB\u0022\n        },\n        \u0022stats.g.doubleclick.net\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022404\u0022:4\n                },\n                \u0022data_size\u0022:\u00224.0 kB\u0022\n        },\n        \u0022www.googleadservices.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:4\n                },\n                \u0022data_size\u0022:\u00223.0 kB\u0022\n        },\n        \u0022purl.org\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u00223.0 kB\u0022\n        },\n        \u0022i1.ytimg.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022lh6.googleusercontent.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022lh5.googleusercontent.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022lh4.googleusercontent.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022lh3.googleusercontent.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022yt3.ggpht.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022yt4.ggpht.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022m.youtube.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022feeds.bbci.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u00222.0 kB\u0022\n        },\n        \u0022p2-puz5j25sijgue-ew7nej4taelourup-if-v6exp3-v4.metric.gstatic.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022youtour.sandbox.google.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022youtu.be\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022dnn506yrbagrg.cloudfront.net\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022403\u0022:4\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022bit.ly\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2,\n                        \u0022301\u0022:1\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022open.live.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022static.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022www.live.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022ichef.bbci.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2\n                },\n                \u0022data_size\u0022:\u00221.0 kB\u0022\n        },\n        \u0022p.jwpcdn.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022973.0 bytes\u0022\n        },\n        \u0022ssl.p.jwpcdn.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022972.0 bytes\u0022\n        },\n        \u0022apis.google.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022301\u0022:1\n                },\n                \u0022data_size\u0022:\u0022824.0 bytes\u0022\n        },\n        \u0022sec.levexis.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:4\n                },\n                \u0022data_size\u0022:\u0022740.0 bytes\u0022\n        },\n        \u0022i.creativecommons.org\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022654.0 bytes\u0022\n        },\n        \u0022www.gstatic.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022-9998\u0022:1\n                },\n                \u0022data_size\u0022:\u0022558.0 bytes\u0022\n        },\n        \u0022ssl.gstatic.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022-9998\u0022:1\n                },\n                \u0022data_size\u0022:\u0022558.0 bytes\u0022\n        },\n        \u0022s3.amazonaws.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022403\u0022:2\n                },\n                \u0022data_size\u0022:\u0022521.0 bytes\u0022\n        },\n        \u0022trk.cetrk.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022403\u0022:2\n                },\n                \u0022data_size\u0022:\u0022519.0 bytes\u0022\n        },\n        \u0022gdata.youtube.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022-9998\u0022:1\n                },\n                \u0022data_size\u0022:\u0022516.0 bytes\u0022\n        },\n        \u0022googleads.g.doubleclick.net\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:2,\n                        \u0022-9998\u0022:2\n                },\n                \u0022data_size\u0022:\u0022466.0 bytes\u0022\n        },\n        \u0022maps.googleapis.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022-9998\u0022:1\n                },\n                \u0022data_size\u0022:\u0022457.0 bytes\u0022\n        },\n        \u0022ib.adnxs.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022370.0 bytes\u0022\n        },\n        \u0022sa.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:2,\n                        \u0022200\u0022:1,\n                        \u0022404\u0022:1\n                },\n                \u0022data_size\u0022:\u0022351.0 bytes\u0022\n        },\n        \u0022s2.googleusercontent.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:2,\n                        \u0022-9998\u0022:2\n                },\n                \u0022data_size\u0022:\u0022257.0 bytes\u0022\n        },\n        \u0022prezi-a.akamaihd.net\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022404\u0022:2\n                },\n                \u0022data_size\u0022:\u0022127.0 bytes\u0022\n        },\n        \u0022stats.bbc.co.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022-404\u0022:1,\n                        \u0022-3\u0022:1\n                },\n                \u0022data_size\u0022:\u002299.0 bytes\u0022\n        },\n        \u0022cdn.syndication.twimg.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022200\u0022:1,\n                        \u0022-9998\u0022:1\n                },\n                \u0022data_size\u0022:\u002285.0 bytes\u0022\n        },\n        \u0022pbs.twimg.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022400\u0022:2\n                },\n                \u0022data_size\u0022:\u002265.0 bytes\u0022\n        },\n        \u0022pfa.levexis.com\u0022:{\n                \u0022response_codes\u0022:{\n                        \u00221\u0022:1,\n                        \u0022204\u0022:4\n                },\n                \u0022data_size\u0022:\u002252.0 bytes\u0022\n        },\n        \u0022m.islamic-relief.org.uk\u0022:{\n                \u0022response_codes\u0022:{\n                        \u0022-1\u0022:1\n                },\n                \u0022data_size\u0022:\u00220.0 bytes\u0022\n        }\n}\n\u003C\/pre\u003E",
//		"summary":"",
//		"format":"full_html"
//		},
//	"field_timestamp":"20140127231546",
//	"field_qa_issues":{"uri":"http:\/\/webarchive.org.uk\/act\/taxonomy_term\/164","id":"164","resource":"taxonomy_term"},
//	"field_target":{"uri":"http:\/\/webarchive.org.uk\/act\/node\/7483","id":"7483","resource":"node"},
//	"field_description_of_qa_issues":[],
//	"field_published":true,
//	"field_to_be_published_":true,
	
//same	"nid":"12681",
//same	"vid":"19395",
//same	"is_new":false,
//same	"type":"instance",
//same	"title":"20140127231546",
//same	"language":"en",
//same	"url":"http:\/\/webarchive.org.uk\/act\/node\/12681",
//same	"edit_url":"http:\/\/webarchive.org.uk\/act\/node\/12681\/edit",
//same	"status":"1",
//same	"promote":"0",
//same	"sticky":"0",
//same	"created":"1390990524",
//same	"changed":"1393383436",
//same	"author":{"uri":"http:\/\/webarchive.org.uk\/act\/user\/80","id":"80","resource":"user"},
//same	"log":"",
//same	"revision":null,
//same	"comment":"1",
//same	"comments":[],
//same	"comment_count":"0",
//same	"comment_count_new":"0",
//same	"feed_nid":null}
	
	@Transient
    public String log;


    public Instance() {}

    /**
     * Constructor
     * @param title
     * @param url
     */
    public Instance(String title, String url) {
    	this.title = title;
    	this.url = url;
    }

    // -- Queries
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static Model.Finder<Long,Instance> find = new Model.Finder(Long.class, Instance.class);
    
    /**
     * Retrieve targets
     */
    public static List<Instance> findInvolving() {
	    return find.all();
	}

    /**
     * This method returns a list of ids
     * @return
     */
    public static List<Object> findIds() {
	    return find.findIds();
	}

    public static QueryIterator<Instance> getIterator() {
	    return find.findIterate();
	}

    /**
     * Retrieve targets
     */
    public static List<Instance> findAll() {
	    return find.all();
	}

    /**
     * This method retrieves all targets for given organisation.
     * @param url
     * @return
     */
    public static List<Instance> findAllforOrganisation(String url) {
    	List<Instance> res = new ArrayList<Instance>();
        ExpressionList<Instance> ll = find.where().eq("target.originatingOrganisation", url);
        res = ll.findList();
        return res;
	}

    public static Instance findbyTitleAndTargetId(String title, Long targetId) {
        Instance instance = find.where().eq("title", title).eq("target.id", targetId).findUnique();
    	return instance;
    }
    
    /**
     * Create a new target.
     */
    public static Instance create(String title, String url) {
        Instance target = new Instance(title, url);
        target.save();
        return target;
    }

   /**
     * Rename a target
     */
    public static String rename(Long targetId, String newName) {
        Instance target = (Instance) find.ref(targetId);
        target.title = newName;
        target.update();
        return newName;
    }
        
    /**
     * This method translates database view to the HTML view.
     * @return list of Strings
     */
	public List<String> getFieldList(String fieldName) {
    	List<String> res = new ArrayList<String>();
    	try {
    		res.add(Const.EMPTY);
			Field field = this.getClass().getField(fieldName); 
			String content = (String) field.get(this);
			res = Arrays.asList(content.split("\\s*,\\s*"));
		} catch (IllegalArgumentException e) {
			Logger.debug(e.getMessage());
		} catch (IllegalAccessException e) {
			Logger.debug(e.getMessage());
		} catch (SecurityException e) {
			Logger.debug(e.getMessage());
		} catch (NoSuchFieldException e) {
			Logger.debug(e.getMessage());
		} catch (Exception e) {
			Logger.debug(e.getMessage());
		}
    	return res;
    }
    
//	/**
//	 * This method computes duplicates for target URLs.
//	 * @return duplicate count
//	 */
//	public int getDuplicateNumber() {
////		int res = 0;
////        ExpressionList<Instance> ll = find.where().eq("fieldUrl", this.fieldUrl);
////        res = ll.findRowCount();
////		return res;
//		throw new NotImplementedError();
//	}
//	
	/**
	 * This method computes a number of targets per user for given user URL.
	 * @return
	 */
	public static int getInstanceNumberByCuratorUrl(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("author", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets per taxonomy for given taxonomy URL.
	 * @return
	 */
	public static int getInstanceNumberByTaxonomyUrl(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq(Const.FIELD_COLLECTION_CATEGORIES, url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets per user for given subject URL.
	 * @return
	 */
	public static int getInstanceNumberBySubjectUrl(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("fieldSubject", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets per organisation for given organisation URL.
	 * @return
	 */
	public static int getInstanceNumberByOrganisationUrl(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("target.originatingOrganisation", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets for given crawl frequency.
	 * @return
	 */
	public static int getInstanceNumberByCrawlFrequency(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("fieldCrawlFrequency", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets for given depth.
	 * @return
	 */
	public static int getInstanceNumberByDepth(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("fieldDepth", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets for given license.
	 * @return
	 */
	public static int getInstanceNumberByLicense(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq("fieldLicense", url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method computes a number of targets for given scope.
	 * @return
	 */
	public static int getInstanceNumberByScope(String url) {
		int res = 0;
        ExpressionList<Instance> ll = find.where().eq(Const.FIELD_SCOPE, url);
        res = ll.findRowCount();
		return res;
	}
	
	/**
	 * This method filters targets by given URLs.
	 * @return duplicate count
	 */
	public static List<Instance> filterUrl(String url) {
		return find.fetch("target").fetch("target.fieldUrls").where().contains("target.fieldUrls.url", url).findList();
	}
	
	/**
	 * This method filters targets by given User URLs.
	 * @return duplicate count
	 */
	public static List<Instance> filterUserUrl(String url) {
		List<Instance> res = new ArrayList<Instance>();
		if (url == null || url.equals(Const.NONE)) {
			res = find.all();
		} else {
	        ExpressionList<Instance> ll = find.where().contains(Const.AUTHOR, url);
	    	res = ll.findList();
		}
		return res;
	}
	
	/**
	 * This method filters targets by given Organisation URLs.
	 * @return duplicate count
	 */
	public static List<Instance> filterOrganisationUrl(String url) {
		List<Instance> res = new ArrayList<Instance>();
		if (url == null || url.equals(Const.NONE)) {
			res = find.all();
		} else {
	        ExpressionList<Instance> ll = find.where().contains(Const.FIELD_NOMINATING_ORGANISATION, url);
	    	res = ll.findList();
		}
		return res;
	}
	
	/**
	 * This method filters targets by given Curator and Organisation URLs.
	 * @return duplicate count
	 */
	public static List<Instance> filterCuratorAndOrganisationUrl(String curatorUrl, String organisationUrl) {
		List<Instance> res = new ArrayList<Instance>();
		if (curatorUrl != null && organisationUrl != null) {
	        ExpressionList<Instance> ll = find.where().contains(Const.FIELD_NOMINATING_ORGANISATION, organisationUrl);
	    	res = ll.findList(); 
		}
		return res;
	}
	
//	/**
//	 * This method filters targets by given URLs.
//	 * @return duplicate count
//	 */
//	public static List<String> getSubjects() {
//		List<String> subjects = new ArrayList<String>();
//		List<Instance> allInstances = find.all();
//		Iterator<Instance> itr = allInstances.iterator();
//		while (itr.hasNext()) {
//			Instance target = itr.next();
//			if (target.fieldSubject != null && target.fieldSubject.length() > 0 && !subjects.contains(target.fieldSubject)) {
//		        ExpressionList<Instance> ll = find.where().contains("field_subject", target.fieldSubject);
//		        if (ll.findRowCount() > 0) {
//		        	subjects.add(target.fieldSubject);
//		        }
//			}
//		}
//    	return subjects;
//	}
	
//	public String getFieldUrlAsStr() {
//		return getFieldListAsStr("fieldUrl");
//	}
//	
//	/**
//	 * This method retrieves value of the list field.
//	 * @param fieldName
//	 * @return list of strings as a String
//	 */
//	public String getFieldListAsStr(String fieldName) {
//    	List<String> res = new ArrayList<String>();
//    	try {
//    		res.add(Const.EMPTY);
//			Field field = this.getClass().getField(fieldName); 
//			String content = (String) field.get(this);
//			res = Arrays.asList(content.split("\\s*,\\s*"));
//		} catch (IllegalArgumentException e) {
//			Logger.debug(e.getMessage());
//		} catch (IllegalAccessException e) {
//			Logger.debug(e.getMessage());
//		} catch (SecurityException e) {
//			Logger.debug(e.getMessage());
//		} catch (NoSuchFieldException e) {
//			Logger.debug(e.getMessage());
//		} catch (Exception e) {
//			Logger.debug(e.getMessage());
//		}
//    	String res_str = res.toString().substring(1,res.toString().length()-1);
//    	if (res_str.length() > Const.STRING_LIMIT) {
//    		res_str = res_str.toString().substring(0,Const.STRING_LIMIT);
//    	}
////    	System.out.println(res_str.length());
////		String res_str = "test";
//    	return res_str;
//    }

	/**
	 * This method retrieves user name for the passed author URL.
	 * @return
	 */
	public String getUserById() {
		if (authorUser != null) {
			return authorUser.name;
		}
		return null;
	}
	
	public static Instance findById(Long id) {	
		return find.where().eq("id", id).findUnique();
	}

	public static Instance findByTargetAndInstance(Long targetId, Long instanceId) {
		return find.where().eq("target.id", targetId).eq("id", instanceId).findUnique();
	}
	
	public static Instance findByUrl(String url) {
		return find.where().eq(Const.URL, url).findUnique();
	}

	public static Instance findByWct(String url) {
		return find.where().eq("edit_url", url).eq(Const.ACTIVE, true).findUnique();
	}

    /**
     * Retrieve an Instance by timestamp.
     * @param url
     * @return instance object 
     */
    public static Instance findByTimestamp(String timestamp) {
    	Instance res = new Instance();
//        Logger.debug("instance timestamp: " + timestamp);
        
		List<Instance> list = new ArrayList<Instance>();
		if (timestamp != null && timestamp.length() > 0) {
	        ExpressionList<Instance> ll = find.where().eq(Const.FIELD_TIMESTAMP, timestamp);
	    	list = ll.findList(); 
		}

		Instance instance = null;
		if (list.size() > 0) {
	        instance = list.get(0);
		}
	//        Instance instance = find.where().eq(Const.FIELD_TIMESTAMP, timestamp).findUnique();
        if (instance == null) {
        	res.url = Const.NONE;
        } else {
        	res = instance;
        }
    	return res;
    }          

    /**
     * Retrieve an Instance by timestamp and target URL.
     * @param url
     * @return instance object 
     */
    public static Instance findByTimestampAndUrl(Date timestamp, String url) {
    	Instance res = new Instance();
//        Logger.debug("instance timestamp: " + timestamp);
        
		List<Instance> list = new ArrayList<Instance>();
		if (timestamp != null && url != null && url.length() > 0) {
	        ExpressionList<Instance> ll = find.fetch("target").fetch("target.fieldUrls").where().eq(Const.FIELD_TIMESTAMP, timestamp).eq("target.fieldUrls.url", url);
	    	list = ll.findList(); 
		}

		Instance instance = null;
		if (list.size() > 0) {
	        instance = list.get(0);
		}
        if (instance == null) {
        	res.url = Const.NONE;
        } else {
        	res = instance;
        }
    	return res;
    }          

	/**
	 * This method computes a number of instances for given target url.
	 * @return
	 */
	public static List<Instance> findAllInstancesByTarget(String url) {
		List<Instance> list = new ArrayList<Instance>();
        ExpressionList<Instance> ll = find.fetch("target").fetch("target.fieldUrls").where().eq("target.fieldUrls.url", url);
    	list = ll.findList(); 
		return list;
	}
	
	/**
	 * This method evaluates the latest timestamp for given target.
	 * @param url
	 * @return timestamp value
	 */
	public static Date showLatestTimestamp(String url) {
//		String res = "";
        Date lastDate = null;
		if (url != null && url.length() > 0) {
			List<Instance> instanceList = new ArrayList<Instance>();
	        ExpressionList<Instance> ll = find.fetch("target").fetch("target.fieldUrls").where().eq("target.fieldUrls.url", url);
	        instanceList = ll.findList(); 
	        Iterator<Instance> itr = instanceList.iterator();
//	        Date lastDate = new Date();
	        while (itr.hasNext()) {
	        	Instance instance = itr.next();
	        	Date curDate = instance.createdAt;
//	        	String curDate = instance.field_timestamp;
//	        	Date curDate = new Date(instance.field_timestamp);
	        	if (lastDate == null) {
	        		lastDate = curDate;
	        	}
//	        	Date lastDateTime = new Date(lastDate);
//	        	Date curDateTime = new Date(curDate);
//	        	long lastDateTime = Long.parseLong(lastDate);
//	        	long curDateTime = Long.parseLong(curDate);
	        	
	            if(curDate.after(lastDate)){
	        		lastDate = curDate;
	            }
//	        	if (curDateTime > lastDateTime) {
//	        		lastDate = curDate;
//	        	}
	        }
//	        res = Utils.getDateFromUnixDate(lastDate);
//	        res = Utils.showTimestamp(lastDate);
		}
		return lastDate;		
	}
	
	/**
	 * This method shows the date in a page.
	 * @param curDate
	 * @return timestamp value
	 */
	public static String showTimestamp(String curDate) {
		String res = "";
		if (curDate != null && curDate.length() > 0) {
			Logger.debug("showTimestamp() curDate: " + curDate + ", Utils.INSTANCE.getDateFromUnixDate(curDate): " + Utils.INSTANCE.getDateFromUnixDate(curDate));
	        res = Utils.INSTANCE.getDateFromUnixDate(curDate);
		}
		return res;		
	}
	
	public static Instance findLastInstanceByTarget(Long targetId) {
		Instance instance = null;
		List<Instance> instances = find.where().eq("target.id", targetId).order("createdAt desc").findList();
		if (instances != null && !instances.isEmpty()) {
			instance = instances.get(0);
		}
		return instance;
	}
	
//	/**
//	 * This method evaluates the latest Instance object for given target.
//	 * @param url
//	 * @return link to the instance
//	 */
//	public static Instance getLatestInstance(Long id) {
//		Instance res = null;
//		Date lastDate = null;
//			List<Instance> instanceList = new ArrayList<Instance>();
//	        ExpressionList<Instance> ll = find.fetch("target").fetch("target.fieldUrls").where().eq("target.fieldUrls.url", id);
//	        instanceList = ll.findList(); 
//	        Iterator<Instance> itr = instanceList.iterator();
//	        while (itr.hasNext()) {
//	        	Instance instance = itr.next();
//	        	Date curDate = instance.fieldTimestamp;
//	        	if (lastDate == null) {
//	        		lastDate = curDate;
//	        	}
////	        	long lastDateTime = Long.parseLong(lastDate);
////	        	long curDateTime = Long.parseLong(curDate);
//	            if(curDate.after(lastDate)){
////	        	if (curDateTime > lastDateTime) {
//	        		lastDate = curDate;
//	        	}
//	        }
//		Instance instance = Instance.findByTimestampAndUrl(lastDate, id);
//		res = instance;	
//		return res;
//	}
	

    /**
     * Return a page of Instance
     *
     * @param page Page to display
     * @param pageSize Number of targets per page
     * @param sortBy Instance property used for sorting
     * @param order Sort order (either or asc or desc)
     * @param filter Filter applied on the name column
     */
    public static Page<Instance> page(int page, int pageSize, String sortBy, String order, String filter) {

		Page<Instance> results = find.where().query().fetch("target").fetch("target.fieldUrls").where().icontains("target.fieldUrls.url", filter).orderBy(sortBy + " " + order).findPagingList(pageSize).setFetchAhead(false).getPage(page);

//		Logger.debug("results: " + results.getList());
//		find.where().icontains(Const.FIELD_URL_NODE, filter)
//		.orderBy(sortBy + " " + order)
//		.findPagingList(pageSize)
//		.setFetchAhead(false)
//		.getPage(page)
    	
    	return results;
    }    
    
    /**
     * Return a page of Instance
     *
     * @param page Page to display
     * @param pageSize Number of targets per page
     * @param sortBy Instance property used for sorting
     * @param order Sort order (either or asc or desc)
     * @param filter Filter applied on the name column
     * @param targetUrl Filter by target url
     */
    public static Page<Instance> pageByTarget(int page, int pageSize, String sortBy, String order, String filter, Long targetId) {

        return find.fetch("target").where()
        		.eq("target.id", targetId)
        		.orderBy(sortBy + " " + order)
        		.findPagingList(pageSize)
        		.setFetchAhead(false)
        		.getPage(page);
    }    
    
    /**
     * This method returns a list of all flag values for target record.
     * @return
     */
    public static List<String> getAllFlags() {
    	List<String> res = new ArrayList<String>();
	    Const.TargetFlags[] resArray = Const.TargetFlags.values();
	    for (int i=0; i < resArray.length; i++) {
		    res.add(resArray[i].name());
	    }
	    return res;
    }         
    
    /**
     * This method returns previous Instance revisions that are not more active for given URL
     * @param url
     * @return list of associated Instances
     */
    public static List<Instance> findRevisions(String url) {
        Logger.debug("findRevisions() target url: " + url);
		List<Instance> res = new ArrayList<Instance>();
		if (url != null && url.length() > 0) {
	        ExpressionList<Instance> ll = find.where().eq(Const.URL, url);
	    	res = ll.findList(); 
		}
		return res;
    }          
    
	/**
	 * This method checks whether the passed URL is in scope. 
	 * @param url
	 * @return result as a String
	 */
	public String checkScope(String url) {
		String res = "false";
		if (url.contains(".uk")) {
			res = "true";
		}
    	return res;
    }
    
    /**
     * Return a page of Target objects.
     * @param page Page to display
     * @param pageSize Number of targets per page
     * @param sortBy Target property used for sorting
     * @param order Sort order (either or asc or desc)
     * @param status The type of report QA e.g. awaiting QA, with no QA issues...
     * @param curatorUrl
     * @param organisationUrl
     * @param startDate The start date for filtering
     * @param endDate The end date for filtering
     * @param collectionCategoryUrl
     * @return
     */
    public static Page<Instance> pageReportsQa(int page, int pageSize, String sortBy, String order, String status, 
    		String curatorUrl, String organisationUrl, String startDate, String endDate, String suggested_collections) {
    	ExpressionList<Instance> exp = Instance.find.where();
    	Page<Instance> res = null;
//    	if (curatorUrl != null && !curatorUrl.equals(Const.NONE)) {
//    		exp = exp.icontains(Const.AUTHOR, curatorUrl);
//    	}
    	if (startDate != null && startDate.length() > 0) {
    		Logger.debug("start_date: " + startDate);
    		String startDateStr = Utils.INSTANCE.getUnixDateStringFromDate(startDate);
    		Logger.debug("start_date string: " + startDateStr);
    		exp = exp.ge(Const.CHANGED, startDateStr);
    	} 
    	if (endDate != null && endDate.length() > 0) {
    		Logger.debug("end_date: " + endDate);
    		String endDateStr = Utils.INSTANCE.getUnixDateStringFromDate(endDate);
    		exp = exp.le(Const.CHANGED, endDateStr);
    	} 
    	res = exp.query()
        		.orderBy(sortBy + " " + order)
        		.findPagingList(pageSize)
        		.setFetchAhead(false)
        		.getPage(page);
    	Logger.debug("Expression list size: " + res.getTotalRowCount());
        return res;
    }
        	
    /**
     * This method applies filters to the list of reports QA.
     * @param status The status depicts the type of report
     * @param startDate The start date for filtering for field 'changed'
     * @param endDate The end date for filtering for field 'changed'
     * @return
     */
    public static List<Instance> processReportsQa(String status, String startDate, String endDate) {
    	boolean isProcessed = false;
    	ExpressionList<Instance> exp = Instance.find.where();
    	List<Instance> res = new ArrayList<Instance>();
//    	if (status != null && !status.toLowerCase().equals(Const.NONE) && status.length() > 0) {
//    		Logger.debug("status: " + status);
//    		exp = exp.eq(Const.STATUS, status);
//    		isProcessed = true;
//    	} 
		if (status != null && status.equals(Const.ReportQaStatusType.WITHQAISSUES.name().toLowerCase())) { 
			exp = exp.eq(Const.QA_STATUS, Const.QAStatusType.ISSUE_NOTED.name());
			isProcessed = true;
    	} 
    	
		if (status != null && status.equals(Const.ReportQaStatusType.WITHNOQAISSUES.name().toLowerCase())) { 
			exp = exp.ne(Const.QA_STATUS, Const.QAStatusType.ISSUE_NOTED.name());
			isProcessed = true;
    	} 
    	
		if (status != null && status.equals(Const.ReportQaStatusType.FAILEDINSTANCES.name().toLowerCase())) { 
			exp = exp.ne(Const.QA_STATUS, Const.QAStatusType.FAILED_DO_NOT_PUBLISH.name());
			isProcessed = true;
    	} 
    	
		if (status != null && status.equals(Const.ReportQaStatusType.PASSED.name().toLowerCase())) { 
			exp = exp.ne(Const.QA_STATUS, Const.QAStatusType.FAILED_PASS_TO_ENGINEER.name());
			isProcessed = true;
    	} 
    	
		if (status != null && status.equals(Const.ReportQaStatusType.WITHQAISSUESRESOLVED.name().toLowerCase())) { 
			exp = exp.ne(Const.QA_STATUS, Const.QAStatusType.ISSUE_NOTED.name());
			isProcessed = true;
    	} 		
		
		if (status != null && status.equals(Const.ReportQaStatusType.WITHQAISSUESBUTOK.name().toLowerCase())) { 
			exp = exp.ne(Const.QA_STATUS, Const.QAStatusType.ISSUE_NOTED.name());
			isProcessed = true;
    	} 
    	
    	if (startDate != null && startDate.length() > 0) {
    		Logger.debug("start_date: " + startDate);
    		String startDateStr = Utils.INSTANCE.getUnixDateStringFromDate(startDate);
    		Logger.debug("start_date string: " + startDateStr);
    		if (status != null && (status.length() > 0 || status.length() ==  0) 
    				&& (status.equals(Const.ReportQaStatusType.QAED.name().toLowerCase())
        				|| status.equals(Const.ReportQaStatusType.WITHQAISSUES.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.WITHNOQAISSUES.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.FAILEDINSTANCES.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.PASSED.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.WITHQAISSUESRESOLVED.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.WITHQAISSUESBUTOK.name().toLowerCase())	
    					)) { 
    			exp = exp.ge(Const.CHANGED, startDateStr);
    		}
    		if (status != null && status.length() > 0 
    				&& status.equals(Const.ReportQaStatusType.AWAITINGQA.name().toLowerCase())) { 
    			exp = exp.le(Const.CHANGED, startDateStr);
    		}
    		isProcessed = true;
    	} 
    	if (endDate != null && endDate.length() > 0) {
    		Logger.debug("end_date: " + endDate);
    		String endDateStr = Utils.INSTANCE.getUnixDateStringFromDate(endDate);
    		if (status != null && (status.length() > 0 || status.length() ==  0) 
    				&& (status.equals(Const.ReportQaStatusType.QAED.name().toLowerCase())
    					|| status.equals(Const.ReportQaStatusType.WITHQAISSUES.name().toLowerCase())	
    					|| status.equals(Const.ReportQaStatusType.WITHNOQAISSUES.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.FAILEDINSTANCES.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.PASSED.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.WITHQAISSUESRESOLVED.name().toLowerCase())	
        				|| status.equals(Const.ReportQaStatusType.WITHQAISSUESBUTOK.name().toLowerCase())	
    					)) { 
    			exp = exp.le(Const.CHANGED, endDateStr);
    		}
    		if (status != null && status.length() > 0 
    				&& status.equals(Const.ReportQaStatusType.AWAITINGQA.name().toLowerCase())) { 
    			exp = exp.ge(Const.CHANGED, endDateStr);
    		}
    		isProcessed = true;
    	} 
//    	if (collection != null && !collection.equals(Const.NONE)) {
//    		exp = exp.icontains(Const.FIELD_SUGGESTED_COLLECTIONS, collection);
//    	} 
    	res = exp.query().findList();

    	Logger.debug("Expression list for instances size: " + res.size() + ", isProcessed: " + isProcessed);
        return res;
    }
    
    /**
     * This method evaluates if element is in a list separated by list delimiter e.g. ', '.
     * @param subject
     * @return true if in list
     */
//    public boolean hasSubSubject(String subject) {
//    	boolean res = false;
//    	res = Utils.hasElementInList(subject, this.fieldSubSubject);
//    	return res;
//    }
          
    /**
     * This method updates foreign key mapping between an Instance and an Organisation.
     */
//    public void updateOrganisation() {
//		if (fieldNominatingOrganisation != null
//				&& fieldNominatingOrganisation.length() > 0) {
//			Organisation organisation = Organisation.findByUrl(fieldNominatingOrganisation);
////            Logger.debug("Add instance to organisation: " + organisation.toString());
//            this.organisation = organisation;
//		}
//    	
//    }
    
    public String getField_timestamp() {
		return field_timestamp;
	}

	public void setField_timestamp(String field_timestamp) {
		this.field_timestamp = field_timestamp;
	}

	public FieldModel getField_qa_issues() {
		return field_qa_issues;
	}

	public void setField_qa_issues(FieldModel field_qa_issues) {
		this.field_qa_issues = field_qa_issues;
	}

	public FieldModel getField_target() {
		return field_target;
	}

	public void setField_target(FieldModel field_target) {
		this.field_target = field_target;
	}

	public Object getField_description_of_qa_issues() {
		return field_description_of_qa_issues;
	}

	public void setField_description_of_qa_issues(
			Object field_description_of_qa_issues) {
		this.field_description_of_qa_issues = field_description_of_qa_issues;
	}

	public Boolean getField_published() {
		return field_published;
	}

	public void setField_published(Boolean field_published) {
		this.field_published = field_published;
	}

	public Boolean getField_to_be_published_() {
		return field_to_be_published_;
	}

	public void setField_to_be_published_(Boolean field_to_be_published_) {
		this.field_to_be_published_ = field_to_be_published_;
	}

	@Override
	public String toString() {
		return "Instance [qaIssueCategory=" + qaIssueCategory + ", qaNotes="
				+ qaNotes + ", target=" + target + ", fieldTimestamp="
				+ fieldTimestamp + ", value=" + value + ", summary=" 
				+ summary + ", hidden=" + hidden
				+ ", fieldDate=" + fieldDate + "]";
	}
	
	
}

