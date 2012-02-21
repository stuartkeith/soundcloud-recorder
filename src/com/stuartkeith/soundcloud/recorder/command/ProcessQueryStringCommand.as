package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
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
			
			if (!queryString)
			{
				// if the querystring is empty then we need to prompt the user
				// to authorise.
				
				dispatch(new Event(FrameworkEvent.AUTHORISATION_REQUIRED));
			}
		}
	}
}
