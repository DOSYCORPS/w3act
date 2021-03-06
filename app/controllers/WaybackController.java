package controllers;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import models.User;
import play.Logger;
import play.Play;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import uk.bl.exception.ActException;

public class WaybackController extends Controller {

    /* BIGCDX Server*/
    private static String cdx_server_query_path = "?q=url:";
    private static String cdx_server_query_type_urlquery = "+type:urlquery";
    private static String cdx_server_query_type_prefixquery = "+type:prefixquery";

	private static URL wayback_url;

    public static String getCdxServerEndpoint() {
        String prefix = Play.application().configuration().getString("application.cdxserver.endpoint");
        if( prefix.endsWith("/")) {
            prefix.charAt(prefix.length() - 1);
        }
        return prefix;
    }
    public static String getWaybackEndpoint() {
		String prefix = Play.application().configuration().getString("application.wayback.url");
		if( ! prefix.endsWith("/")) {
			prefix = prefix + "/";
		}
		return prefix;
	}
	public static String getAccessResolverEndpoint() {
		String prefix = Play.application().configuration().getString("application.access.resolver.url");
		if( ! prefix.endsWith("/")) {
			prefix = prefix + "/";
		}
		return prefix;
	}
	
	public static String getWaybackQueryEndpoint() {
		return Play.application().configuration().getString("application.wayback.query.path");
	}

	@Security.Authenticated(SecuredController.class)
	public static Result wayback(String url) throws ActException, ClientProtocolException, IOException {
		
		User user = User.findByEmail(session().get("email"));
		if( ! user.isLDLMember() ) {
			return unauthorized(
					"unauthorized - you must be a member of a Legal Deposit library organisation to view the crawled resources"
					);
		}
				
		String wayBackUrl = getWaybackEndpoint();
		
		// Build up the wayback query:
		String waybackBuilder = wayBackUrl + url;
		String q = ctx()._requestHeader().rawQueryString();
		if( q != null && q.length() > 0 ) {
			Logger.info("Passing through raw Query String: "+q);
			waybackBuilder += "?"+q;
		}
		final String wayback = waybackBuilder;
		Logger.info("Using URL: "+wayback);

		// Build up URL and copy over query parameters:		
		CloseableHttpClient httpclient = HttpClientBuilder.create()
			    .disableRedirectHandling()
			    .build();
		//
		HttpGet httpGet = new HttpGet(wayback);
		CloseableHttpResponse response = httpclient.execute(httpGet);
		// If this looks like a redirect, return that:
		if ( response.getFirstHeader(LOCATION) != null ) {
			String location = response.getFirstHeader(LOCATION).getValue();
			response.close();
			Logger.info("Got LOCATION: "+location);
			// Issue the redirect directly...
			return redirect(location);
		}
		// Otherwise, return the body, copying over the headers:
		// Except this does not work, because doing this here overrides/breaks the Play frameworks response handling.
		//for( Header h : response.getAllHeaders() ) {
		//	response().setHeader(h.getName(), h.getValue());
		//}
		HttpEntity entity = response.getEntity();
		Header contentType = response.getFirstHeader(CONTENT_TYPE);
		Logger.debug("Response content type: " + contentType);
		if( contentType != null ) {
			return status(response.getStatusLine().getStatusCode(), entity.getContent()).as(contentType.getValue());
		} else {
			return status(response.getStatusLine().getStatusCode(), entity.getContent());
		}
	}
	
	public static Result waybackRoot() throws ActException, ClientProtocolException, IOException {
		return wayback("");
	}

	
	/**Method to fetch number of crawled urls**/
	public static int getTotalCrawledUrls(String url) {
		Logger.debug("getTotalCrawledUrls url:"+url);
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();

            /***Check the http status code***/

            wayback_url = new URL(getCdxServerEndpoint() + cdx_server_query_path + url + cdx_server_query_type_prefixquery);

            HttpURLConnection http = (HttpURLConnection)wayback_url.openConnection();
			http.setRequestMethod("GET");
			http.connect();

			int statusCode = http.getResponseCode();
			Logger.debug("getTotalCrawledUrls statusCode:"+ statusCode);

			/********************************/

			if(statusCode==200){
				Logger.debug("getTotalCrawledUrls parsing XML...");
				Document doc = db.parse(http.getInputStream());

				Logger.debug("getTotalCrawledUrls getting values from XML...");
				NodeList nl = doc.getElementsByTagName("result");
				Logger.debug("getTotalCrawledUrls = "+ nl.getLength());

				return nl.getLength();

			}
		}catch( Exception e ) {
			Logger.warn("Exception while lookup up getTotalCrawledUrls",e);
		}
		
		return 0;
	}

	/**Method to fetch number of times the specific url has been crawled**/
	public static int getTotalCrawledInstances(String url) {
		Logger.debug("getTotalCrawledInstances url:"+url);
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();

			/***Check the http status code***/

            wayback_url = new URL(getCdxServerEndpoint() + cdx_server_query_path + url + cdx_server_query_type_urlquery);

			HttpURLConnection http = (HttpURLConnection)wayback_url.openConnection();
			http.setRequestMethod("GET");
			http.connect();

			int statusCode = http.getResponseCode();
			Logger.debug("getTotalCrawledInstances statusCode:"+ statusCode);

			/********************************/

			if(statusCode==200){
				Document doc = db.parse(http.getInputStream());

				NodeList nl = doc.getElementsByTagName("result");

				return nl.getLength();

			}
		} catch (Exception e) {
			Logger.warn("Exception while lookup up getTotalCrawledInstances",e);
		}
		
		return 0;
	}
}

