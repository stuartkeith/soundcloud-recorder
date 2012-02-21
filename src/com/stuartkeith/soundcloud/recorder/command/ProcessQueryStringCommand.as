package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.AuthorisationError;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLVariables;
	import org.robotlegs.mvcs.Command;
	
	public class ProcessQueryStringCommand extends Command 
	{
		/*
		 * Get the query string passed to the page by calling a JavaScript
		 * function defined in the host page. The SoundCloud authorisation
		 * state can be read from there.
		 */
		
		override public function execute():void 
		{
			var queryString:String = ExternalInterface.call("getQueryString");
			
			if (queryString)
			{
				// convert the queryString into a urlVariables for easy access.
				var urlVariables:URLVariables = new URLVariables(queryString);
				
				if (urlVariables.error)
				{
					dispatch(new AuthorisationError(AuthorisationError.AUTHORISATION_ERROR,
							urlVariables.error, urlVariables.error_description));
					
					return;
				}
			}
			
			// if we get this far then either the querystring was blank or there has
			// been an unforeseen error, so we'll ask the user to authorise.
			
			dispatch(new Event(FrameworkEvent.AUTHORISATION_REQUIRED));
		}
	}
}
