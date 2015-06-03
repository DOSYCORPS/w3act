package controllers;

import java.io.IOException;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import play.Logger;
import play.Play;
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
	
	
//	public static String sayHello(String url) {
//		  Document dom = request().body().asXml();
//		  Logger.debug("DOM:"+dom + request() + request().body());
//		  if(dom == null) {
//		    return badRequest("Expecting Xml data");
//		  } else {
//		    String name = XPath.selectText("http://www.webarchive.org.uk/wayback/archive/xmlquery.jsp?type=prefixquery&url=" + url, dom);
//		    if(name == null) {
//		      return badRequest("Missing parameter [name]");
//		    } else {
//		      return ok("Hello " + name);
//		    }
//		  }
//		  Request request=this.getLoggedRequest();
//		  request.url="http://www.webarchive.org.uk/wayback/archive/xmlquery.jsp?type=prefixquery&url=" + url;
//		  request.method="GET";
//		  Response response=makeRequest(request);
//		  Logger.debug("NIL:"+response);
//		  if (response == null)
//			  return ("Expecting Xml data");
//		  else
//		  return ("Hello");
		
//		}
	
	/**Method to fetch number of crawled urls**/
	public static String show(String url) {
		  Logger.debug("url:"+url);
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();		  
		try {
			db = dbf.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/***Check the http status code***/
		
		try {
			wayback_url = new URL("http://www.webarchive.org.uk/wayback/archive/xmlquery.jsp?type=prefixquery&url="+url);
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
			 Logger.debug("statusCode:"+ statusCode);
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
		  
		  TransformerFactory tf = TransformerFactory.newInstance();
		  Transformer transformer = null;
		try {
			transformer = tf.newTransformer();
		} catch (TransformerConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		  transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		  StringWriter writer = new StringWriter();
		  try {
			transformer.transform(new DOMSource(doc), new StreamResult(writer));
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  String output = writer.getBuffer().toString().replaceAll("\n|\r", "");		 
		  
		 int start = output.indexOf("<numresults>");
		 int end = output.indexOf("</numresults>");
		 String value = output.substring(start+12, end);
		 Logger.debug("DOC:"+ value);
		 
		 return value;
		  
			}
			else{
				String value = "0";
				return value;
			}
		
		}
	
	/**Method to fetch number of times the specific url has been crawled**/
	public static String show1(String url) {
		  Logger.debug("url:"+url);
		  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();		  
		try {
			db = dbf.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/***Check the http status code***/
		
		try {
			wayback_url = new URL("http://www.webarchive.org.uk/wayback/archive/xmlquery.jsp?type=urlquery&url="+url);
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
			 Logger.debug("statusCode:"+ statusCode);
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
		  
		  TransformerFactory tf = TransformerFactory.newInstance();
		  Transformer transformer = null;
		try {
			transformer = tf.newTransformer();
		} catch (TransformerConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		  transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		  StringWriter writer = new StringWriter();
		  try {
			transformer.transform(new DOMSource(doc), new StreamResult(writer));
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  String output = writer.getBuffer().toString().replaceAll("\n|\r", "");		 
		  
		 int start = output.indexOf("<numresults>");
		 int end = output.indexOf("</numresults>");
		 String value = output.substring(start+12, end);
		 Logger.debug("DOC:"+ value);
		 
		 return value;
		  
			}
			else{
				String value = "0";
				return value;
			}
		
		}

	
	

}
