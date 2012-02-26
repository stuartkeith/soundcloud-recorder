package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
	import flash.events.Event;
	
	public class UploadEvent extends Event 
	{
		// request that an upload take place.
		public static const REQUEST_UPLOAD:String = "requestUpload";
		// uploading has begun.
		public static const UPLOADING:String = "uploading";
		// upload was successful. carries response XML.
		public static const UPLOADED:String = "uploaded";
		// there was an error during uploading.
		public static const UPLOAD_ERROR:String = "uploadError";
		
		protected var _soundVO:SoundVO;
		
		public function UploadEvent(type:String, $soundVO:SoundVO, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundVO = $soundVO;
		}
		
		override public function clone():flash.events.Event 
		{
			return new UploadEvent(type, _soundVO, bubbles, cancelable);
		}
		
		public function get soundVO():SoundVO 
		{
			return _soundVO;
		}
	}
}
