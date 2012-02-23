package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadRequestEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class UploadSoundViewMediator extends Mediator 
	{
		override public function onRegister():void 
		{
			// pass the event on
			addViewListener(UploadRequestEvent.UPLOAD_REQUEST, dispatch, UploadRequestEvent);
		}
	}
}
