package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.NavigateToURLEvent;
	import com.stuartkeith.soundcloud.recorder.view.UploadedSoundViewEvent;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class UploadedSoundViewMediator extends Mediator 
	{
		override public function onRegister():void 
		{
			addViewListener(UploadedSoundViewEvent.NAVIGATE_TO_PERMALINK, NAVIGATE_TO_PERMALINK_listener,
					UploadedSoundViewEvent);
			addViewListener(UploadedSoundViewEvent.RECORD_ANOTHER_SOUND, RECORD_ANOTHER_SOUND_listener,
					UploadedSoundViewEvent);
		}
		
		protected function NAVIGATE_TO_PERMALINK_listener(event:UploadedSoundViewEvent):void 
		{
			dispatch(new NavigateToURLEvent(NavigateToURLEvent.NAVIGATE_TO_URL, event.soundVO.permalinkURL, "_blank"));
		}
		
		protected function RECORD_ANOTHER_SOUND_listener(event:UploadedSoundViewEvent):void 
		{
			dispatch(new Event(FrameworkEvent.AUTHORISATION_SUCCESSFUL));
		}
	}
}
