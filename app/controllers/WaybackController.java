package controllers;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import models.User;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import play.Logger;
import play.Play;
import play.libs.F;
import play.libs.WS;
import play.libs.F.Function;
import play.libs.F.Promise;
import play.libs.WS.Response;
import play.libs.WS.WSRequestHolder;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import uk.bl.exception.ActException;

public class WaybackController extends Controller {
	
	private static DocumentBuilder db = null;
	private static Document doc = null;
	private static HttpURLConnection http;
	private static URL wayback_url;
	private static int statusCode = 0;

	@Security.Authenticated(SecuredController.class)
	public static Promise<Result> wayback(String url) throws ActException {
		
		User user = User.findByEmail(session().get("email"));
    	String organisation = user.organisation.field_abbreviation;
		Logger.debug("organisation ::::::::::::::"+ organisation);
		if (! ( organisation.equals("BL") || organisation.equals("NLW") || 
				organisation.equals("NLS") || organisation.equals("Bodleian") || 
				organisation.equals("CAM") || organisation.equals("TCD")) ) {
			return F.Promise.pure((Result) unauthorized(
					"unauthorized - you must be a member of a Legal Deposit library organisation to view the crawled resources")
			);
		}
				
		String wayBackUrl = Play.application().configuration().getString("application.wayback.url");
		
		// Build up the wayback query:
		final String wayback = wayBackUrl + "/" + url;

		// Build up URL and copy over query parameters:
		WSRequestHolder holder = WS.url(wayback).setFollowRedirects(false);
		for( String key : request().queryString().keySet() ) {
			holder.setQueryParameter(key, request().getQueryString(key));
		}

		// GET
		Promise<Response> responsePromise = holder.get();

		final Promise<Result> resultPromise = responsePromise.map(

				new Function<WS.Response, Result>() {

					public Result apply(WS.Response response) {

						Logger.debug(wayback + " (" + response.getStatusText() + " " + response.getStatus() + ") " + response.getUri());

						Logger.debug("WS.Response: "+response);
						// TODO Copy all headers over?
						if ( response.getHeader(LOCATION) != null ) {
							Logger.debug("Copying over Location header: "+response.getHeader(LOCATION));
							response().setHeader(LOCATION, response.getHeader(LOCATION));
							return status(response.getStatus());
						}
						String contentType = response.getHeader(CONTENT_TYPE);
						Logger.debug("content type: " + contentType);
						return status(response.getStatus(), response.getBodyAsStream()).as(contentType);
				
					}

				}
				);

		                    
		return resultPromise;
	}
	
	public static Promise<Result> waybackRoot() throws ActException {
		return wayback("");
	}

	
	/**Method to fetch number of crawled urls**/
	public static String getTotalCrawledUrls(String url) {
		  Logger.debug("getTotalCrawledUrls url:"+url);
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		  String wayBackUrl = Play.application().configuration().getString("application.wayback.url");
		try {
			db = dbf.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/***Check the http status code***/
		
		try {
			wayback_url = new URL(wayBackUrl+"/xmlquery.jsp?type=prefixquery&url="+url);
		} catch (MalformedURLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			http = (HttpURLConnection)wayback_url.openConnection();
			http.setRequestMethod("GET");
			http.connect();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			 statusCode = http.getResponseCode();
			 Logger.debug("getTotalCrawledUrls statusCode:"+ statusCode);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/********************************/
		
		if(statusCode==200){
		  try {
			doc = db.parse(wayback_url.openStream());
		
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		  NodeList nl = doc.getElementsByTagName("request");
	      Node n = nl.item(0).getChildNodes().item(9);  
	      Logger.debug("getTotalCrawledUrls = "+ n.getTextContent());
	      	     
	      return n.getTextContent();
		  
			}
			else{
				String value = "0";
				return value;
			}
		
		}
	
	/**Method to fetch number of times the specific url has been crawled**/
	public static String getTotalCrawledInstances(String url) {
		  Logger.debug("getTotalCrawledInstances url:"+url);
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		  String wayBackUrl = Play.application().configuration().getString("application.wayback.url");
		try {
			db = dbf.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/***Check the http status code***/
		
		try {
			wayback_url = new URL(wayBackUrl + "/xmlquery.jsp?type=urlquery&url=" + url);
		} catch (MalformedURLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			http = (HttpURLConnection)wayback_url.openConnection();
			http.setRequestMethod("GET");
			http.connect();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			 statusCode = http.getResponseCode();
			 Logger.debug("getTotalCrawledInstances statusCode:"+ statusCode);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/********************************/
		
		if(statusCode==200){
		  try {
			doc = db.parse(wayback_url.openStream());
		
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		  NodeList nl = doc.getElementsByTagName("request");
	      Node n = nl.item(0).getChildNodes().item(9);  
		
	      return n.getTextContent();
		  
			}
			else{
				String value = "0";
				return value;
			}
		
		}

	
	

}
