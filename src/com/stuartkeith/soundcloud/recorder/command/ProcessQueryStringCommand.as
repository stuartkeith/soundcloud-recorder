package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.AuthorisationErrorEvent;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
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
		
		[Inject] public var soundCloudConfigurationVO:SoundCloudConfigurationVO;
		
		override public function execute():void 
		{
			// call the JavaScript function that returns the query string
			var queryString:String = ExternalInterface.call("getQueryString");
			
			if (queryString)
			{
				// convert the queryString into a urlVariables for easy access.
				var urlVariables:URLVariables = new URLVariables(queryString);
				
				// if there's an access token available, store it in
				// soundCloudConfigurationVO and dispatch an event
				if (urlVariables.access_token)
				{
					soundCloudConfigurationVO.accessToken = urlVariables.access_token;
					
					dispatch(new Event(FrameworkEvent.AUTHORISATION_SUCCESSFUL));
					
					return;
				}
				// if there's been an error, dispatch an event
				else if (urlVariables.error)
				{
					dispatch(new AuthorisationErrorEvent(AuthorisationErrorEvent.AUTHORISATION_ERROR,
							urlVariables.error, urlVariables.error_description));
					
					return;
				}

			}
			
			// if we get this far then either the querystring was blank or there has
			// been an unrecognised response, so we'll ask the user to authorise.
			
			dispatch(new Event(FrameworkEvent.AUTHORISATION_REQUIRED));
		}
	}
}
