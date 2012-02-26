package com.stuartkeith.soundcloud.recorder.view 
{
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
	import flash.events.Event;
	
	public class UploadedSoundViewEvent extends Event 
	{
		public static const NAVIGATE_TO_PERMALINK:String = "navigateToPermalink";
		public static const RECORD_ANOTHER_SOUND:String = "recordAnotherSound";
		
		protected var _soundVO:SoundVO;
		
		public function UploadedSoundViewEvent(type:String, $soundVO:SoundVO, bubbles:Boolean = false,
				cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundVO = $soundVO;
		}
		
		override public function clone():flash.events.Event 
		{
			return new UploadedSoundViewEvent(type, _soundVO, bubbles, cancelable);
		}
		
		public function get soundVO():SoundVO 
		{
			return _soundVO;
		}
	}
}
