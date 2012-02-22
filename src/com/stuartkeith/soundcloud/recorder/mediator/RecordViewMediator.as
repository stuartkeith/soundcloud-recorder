package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneService;
	import com.stuartkeith.soundcloud.recorder.view.RecordView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class RecordViewMediator extends Mediator 
	{
		[Inject] public var recordView:RecordView;
		
		override public function onRegister():void 
		{
			// add context listeners.
			addContextListener(MicrophoneService.EVENT_RECORDING_BEGUN, EVENT_RECORDING_BEGUN_listener, Event);
			addContextListener(MicrophoneService.EVENT_RECORDING_STOPPED, EVENT_RECORDING_STOPPED_listener, Event);
			
			// add view listeners.
			addViewListener(RecordView.EVENT_RECORD, EVENT_RECORD_listener, Event);
			addViewListener(RecordView.EVENT_RECORD_STOP, EVENT_RECORD_STOP_listener, Event);
			addViewListener(RecordView.EVENT_PLAY, EVENT_PLAY_listener, Event);
			addViewListener(RecordView.EVENT_PLAY_STOP, EVENT_PLAY_STOP_listener, Event);
		}
		
		// view listeners:
		
		protected function EVENT_PLAY_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.BEGIN_PLAYING));
		}
		
		protected function EVENT_PLAY_STOP_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.STOP_PLAYING));
		}
		
		protected function EVENT_RECORD_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.BEGIN_RECORDING));
		}
		
		protected function EVENT_RECORD_STOP_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.STOP_RECORDING));
		}
		
		// context listeners:
		
		protected function EVENT_RECORDING_BEGUN_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_RECORDING);
		}
		
		protected function EVENT_RECORDING_STOPPED_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_RECORDED);
		}
	}
}
