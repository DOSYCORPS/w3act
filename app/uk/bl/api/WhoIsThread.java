package uk.bl.api;

import models.Target;
import play.Logger;
import uk.bl.exception.WhoisException;
import uk.bl.scope.Scope;

/**
 * This class executes WhoIs value calculation for targets
 * in a thread.
 */
public class WhoIsThread implements Runnable  {

	Target target;
	int number;
	
	public WhoIsThread(Target target, int number) {
        this.target = target;
        this.number = number;
    }
	
    public void run() {
    	synchronized (target) {
	        try {
				boolean res = Scope.checkWhoisThread(number);
				target.isInScopeUkRegistrationValue = res;
			} catch (WhoisException e) {
				Logger.error("WhoIsThread error: " + e.getStackTrace());
			}
	        target.notify();
	        Logger.debug("WhoIs thread DONE!");
    	}
    }
}