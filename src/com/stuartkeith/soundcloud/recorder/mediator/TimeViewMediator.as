package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import com.stuartkeith.soundcloud.recorder.view.TimeView;
	import org.robotlegs.mvcs.Mediator;
	
	public class TimeViewMediator extends Mediator 
	{
		[Inject] public var timeView:TimeView;
		
		override public function onRegister():void 
		{
			addContextListener(SoundProgressEvent.PLAYBACK_START, listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.PLAYBACK_PROGRESS, listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.PLAYBACK_COMPLETE, listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.RECORD_START, listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.RECORD_PROGRESS, listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.RECORD_COMPLETE, listener, SoundProgressEvent);
		}
		
		protected function listener(event:SoundProgressEvent):void 
		{
			timeView.currentTime = event.secondsWritten;
			timeView.finishTime = event.secondsTotal;
			// only show the current time if the user is recording or playing back a sound.
			timeView.showCurrentTime = event.type == SoundProgressEvent.PLAYBACK_PROGRESS ||
					event.type == SoundProgressEvent.RECORD_PROGRESS;
		}
	}
}
