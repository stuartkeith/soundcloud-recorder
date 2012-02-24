package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import flash.events.Event;
	
	public class NavigateToURLEvent extends Event 
	{
		public static const NAVIGATE_TO_URL:String = "navigateToURL";
		
		protected var _url:String;
		protected var _window:String;
		
		public function NavigateToURLEvent(type:String, $url:String, $window:String,
				bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_url = $url;
			_window = $window;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function get window():String 
		{
			return _window;
		}
		
		override public function clone():flash.events.Event 
		{
			return new NavigateToURLEvent(type, _url, _window, bubbles, cancelable);
		}
	}
}
