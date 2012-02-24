package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.events.Event;
	
	public class UploadedSoundViewEvent extends Event 
	{
		public static const NAVIGATE_TO_PERMALINK:String = "navigateToPermalink";
		public static const RECORD_ANOTHER_SOUND:String = "recordAnotherSound";
		
		protected var _soundTitle:String;
		protected var _soundPermalinkURL:String;
		
		public function UploadedSoundViewEvent(type:String, $soundTitle:String, $soundPermalinkURL:String,
				bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundTitle = $soundTitle;
			_soundPermalinkURL = $soundPermalinkURL;
		}
		
		public function get soundTitle():String 
		{
			return _soundTitle;
		}
		
		public function get soundPermalinkURL():String 
		{
			return _soundPermalinkURL;
		}
	}
}
