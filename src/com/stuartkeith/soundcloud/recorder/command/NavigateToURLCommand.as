package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.NavigateToURLEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import org.robotlegs.mvcs.Command;
	
	public class NavigateToURLCommand extends Command 
	{
		[Inject] public var navigateToURLEvent:NavigateToURLEvent;
		
		override public function execute():void 
		{
			navigateToURL(new URLRequest(navigateToURLEvent.url), navigateToURLEvent.window);
		}
	}
}
