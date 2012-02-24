package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import flash.events.Event;
	
	public class UploadEvent extends Event 
	{
		// uploading has begun.
		public static const UPLOADING:String = "uploading";
		// upload was successful. carries response XML.
		public static const UPLOADED:String = "uploaded";
		// there was an error during uploading.
		public static const UPLOAD_ERROR:String = "uploadError";
		
		protected var _response:XML;
		
		public function UploadEvent(type:String, $response:XML=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_response = $response;
		}
		
		public function get response():XML 
		{
			return _response;
		}
		
		override public function clone():flash.events.Event 
		{
			return new UploadEvent(type, _response, bubbles, cancelable);
		}
	}
}
