/**
 * 
 */
package uk.bl.api;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import com.google.common.net.InternetDomainName;

import play.Logger;
import uk.bl.Const.ScopeType;
import uk.bl.exception.ActException;
import uk.bl.scope.Scope;
import models.FieldUrl;
import models.Target;

/**
 * Look for any kind of license at a higher level.
 * 
 * Loop over Targets that may cover each URL.
 * For each one, it checks if it might apply to the current target, and whether 
 * it's a NPLD or licensed Target.
 * This means checking that all URLs are covered by the 'parent'.
 * Every URL must be covered by at least on Target.
 * 
 * @author andy
 *
 */
public class OverallLicenseStatus {
	
	public final boolean inNPLDScope;
	
	public final boolean licensePending;
	
	public final boolean licensedOrPending;
	
	public final boolean inheritedLicense;
	
	public final boolean inheritedLicensePending;
	
	public final boolean inheritedLicenseOrPending;
	
	public final boolean licensedOrPendingIncludingInherited;
	
	public final boolean pendingIncludingInherited;
	
	public final boolean inheritedNPLDScope;
	
	public final Set<Target> NPLDParents = new LinkedHashSet<Target>();
	
	public final Set<Target> licenseParents = new LinkedHashSet<Target>();

	public OverallLicenseStatus(Target target) {
		int npldc = 0, lc = 0, total_lc = 0;
		for (FieldUrl fieldUrl : target.fieldUrls) {
			Logger.info("Looking for inherited licensed for "+fieldUrl.url);
			if( fieldUrl.domain == null && fieldUrl.url != null ) {
				try {
					fieldUrl.domain = Scope.getDomainFromUrl(fieldUrl.url);
				} catch (ActException e) {
					Logger.warn("Could not parse "+fieldUrl.url);
				}
			}
			// Skip null domains:			
			if(  StringUtils.isEmpty(fieldUrl.domain) ) {
				Logger.error("No fieldUrl.domain for "+fieldUrl.url);
				continue;
			}
			
			// Determine the parent paths:
			List<String> parentPaths = null;
			try {
				parentPaths = getParentPaths(fieldUrl.url);
			} catch (Exception e) {
				continue;
			}
			
			// Look for targets:
			List<Target> tp = Target.findAllTargetsForParentUrls(getParentDomain(fieldUrl.domain),parentPaths);
			if( tp == null ) {
				Logger.debug("Found no potential matches.");
				continue;
			}
			Logger.debug("Found " + tp.size() + " potential matches.");
			for( Target t :  tp ) {
				if( t.id.equals(target.id)) {
					Logger.info("Skipping "+t.title);
					continue;
				}
				Logger.debug("Checking "+t.title +" "+t.fieldUrls);
				// Check if the scoping of the target applies here:
				for( FieldUrl pt : t.fieldUrls) {
					Logger.debug("Checking "+pt.url);
					// If one of the 'parent's' URLs is a prefix of this one:
					if( inheritsFromTo( pt,t.scope, fieldUrl ) ) {
						// Check if this is in scope, but without forcing a full re-check (e.g. whois):
						boolean isInScope = t.isInScopeAllWithoutLicense();
						if( isInScope ) {
							Logger.info("Found licensed parent for "+fieldUrl.url+", inScope="+isInScope);
							NPLDParents.add(t);
							npldc++;
						}
						// Also check if a license process is underway:
						boolean midLic = ! t.enableLicenseCreation();
						// Check is mid-licensed or licensed but without a licenseStatus:
						if( midLic || t.checkLicense() ) {
							Logger.info("Found licensed parent for "+fieldUrl.url+", mid-licensing="+midLic);
							licenseParents.add(t);
							if( t.checkLicense() ) lc++;
							total_lc++;
						}
					} else {
						Logger.info("Parent license does not apply to "+fieldUrl.url);						
					}
				}
			}
		}
		
		// Record if either was sufficient:
		if(total_lc == target.fieldUrls.size()) {
			if( lc == target.fieldUrls.size() ) {
				this.inheritedLicense = true;
				this.inheritedLicensePending = false;
			} else {
				this.inheritedLicense = false;
				this.inheritedLicensePending = true;
			}
		} else {
			this.inheritedLicense = false;
			if( lc > 0 ) {
				this.inheritedLicensePending = true;
			} else {
				this.inheritedLicensePending = false;				
			}
		}
		if(npldc == target.fieldUrls.size()) { 
			this.inheritedNPLDScope = true;
		} else {
			this.inheritedNPLDScope = false;
		}
		
		// And finally record the direct status:
		this.inNPLDScope = target.isInScopeAllWithoutLicense();
		if (target.enableLicenseCreation() == false) {
			licensedOrPending = true;
			if( target.checkLicense() ) {
				licensePending = false;
			} else {
				licensePending = true;				
			}
		} else {
			licensedOrPending = false;
			licensePending = false;
		}
		
		// Overall
		inheritedLicenseOrPending = (inheritedLicensePending || inheritedLicense);
		pendingIncludingInherited = (licensePending||inheritedLicensePending);
		licensedOrPendingIncludingInherited = (licensedOrPending || inheritedLicense || inheritedLicensePending);
	}
	
	/**
	 * Get the parent domain name, in order to find inheritence candidates:
	 * @param domain
	 * @return
	 */
	private static String getParentDomain(String hostname) {
		hostname = stripWWW(hostname);
		try {
			InternetDomainName idn = InternetDomainName.from(hostname);
			// Get the private domain, if there is one:
			if( idn.isUnderPublicSuffix() ) {
				InternetDomainName domain = idn.topPrivateDomain();
				// If the domain is not just a naked TLD, return it:
				if( domain != null && domain.toString().contains(".")) {
					return domain.toString();
				}
			}
		} catch( IllegalArgumentException e ) {
			Logger.info("Could not parse "+hostname+" as a domain name.");
		}
		return hostname;
	}
	
	/**
	 * 
	 * @param url
	 * @return
	 * @throws URISyntaxException 
	 */
	private static List<String> getParentPaths(String url) throws URISyntaxException {
		ArrayList<String> parentPaths = new ArrayList<String>();
		URI turl = new URI(url);
		String path = turl.normalize().getPath();
		String[] parts = path.split("/");
		String current = "";
		for( int i = 0; i < parts.length; i++ ) {
			// Don't include the last bit or any blanks:
			if( i < parts.length -1 && (! "".equals(parts[i]) ) ) {
				current = current +  "/" + parts[i];
				parentPaths.add(current);
				Logger.info("Scanning path parts "+current);
			}
		}
		return parentPaths;
	}

	/** 
	 * Checks whether a child URL should inherit from a parent one, given the scope.
	 * 
	 * @param parent
	 * @param scope
	 * @param child
	 * @return
	 */
	private boolean inheritsFromTo(FieldUrl parent, String scope, FieldUrl child ) {
		if( ScopeType.root.name().equals(scope) ) {
			String nurl = stripWWW(child.url);
			String pnurl = stripWWW(parent.url);
			Logger.debug("Checking root scope for: "+nurl+" under "+pnurl);
			return nurl.startsWith(pnurl);
		} else if( ScopeType.subdomains.name().equals(scope)) {
			String pdom = parent.domain;
			if( pdom != null) {
				pdom = pdom.replaceFirst("^www\\.", "");
				Logger.debug("Checking domain scope for: "+child.domain+" under "+pdom);
				return child.domain.endsWith(pdom);
			} else {
				Logger.error("The DOMAIN should not be null for " + parent);
				return false;
			}
		} else {
			Logger.error("UNSUPPORTED SCOPE "+scope);
		}
		return false;
	}
	
	private static String stripWWW( String url ) {
		String nurl = url.toLowerCase();
		if( nurl.startsWith("http://www.") || nurl.startsWith("https://www.")) {
			nurl = nurl.replaceFirst("www\\.", "");
		}
		return nurl;
	}
}

