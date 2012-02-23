package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import flash.events.Event;
	
	public class UploadRequestEvent extends Event 
	{
		public static const UPLOAD_REQUEST:String = "uploadRequest";
		
		protected var _soundTitle:String;
		protected var _soundIsPublic:Boolean;
		protected var _soundTags:String;
		
		public function UploadRequestEvent(type:String, $soundTitle:String, $soundIsPublic:Boolean,
				$soundTags:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundTitle = $soundTitle;
			_soundIsPublic = $soundIsPublic;
			_soundTags = $soundTags;
			
		}
		
		public function get soundTitle():String 
		{
			return _soundTitle;
		}
		
		public function get soundIsPublic():Boolean 
		{
			return _soundIsPublic;
		}
		
		public function get soundTags():String 
		{
			return _soundTags;
		}
	}
}
