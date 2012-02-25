package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import com.stuartkeith.soundcloud.recorder.view.RecordView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class RecordViewMediator extends Mediator 
	{
		[Inject] public var recordView:RecordView;
		
		override public function onRegister():void 
		{
			// add context listeners.
			addContextListener(SoundProgressEvent.RECORD_START, RECORD_START_listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.RECORD_COMPLETE, RECORD_COMPLETE_listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.PLAYBACK_START, PLAYBACK_START_listener, SoundProgressEvent);
			addContextListener(SoundProgressEvent.PLAYBACK_COMPLETE, PLAYBACK_COMPLETE_listener, SoundProgressEvent);
			
			// add view listeners.
			addViewListener(RecordView.EVENT_RECORD, EVENT_RECORD_listener, Event);
			addViewListener(RecordView.EVENT_RECORD_STOP, EVENT_RECORD_STOP_listener, Event);
			addViewListener(RecordView.EVENT_PLAY, EVENT_PLAY_listener, Event);
			addViewListener(RecordView.EVENT_PLAY_STOP, EVENT_PLAY_STOP_listener, Event);
			addViewListener(RecordView.EVENT_UPLOAD, EVENT_UPLOAD_listener, Event);
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
		
		protected function EVENT_UPLOAD_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.BEGIN_UPLOAD));
		}
		
		// context listeners:
		
		public function PLAYBACK_START_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_PLAYING);
		}
		
		public function PLAYBACK_COMPLETE_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_RECORDED);
		}
		
		protected function RECORD_START_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_RECORDING);
		}
		
		protected function RECORD_COMPLETE_listener(event:Event):void 
		{
			recordView.changeState(RecordView.STATE_RECORDED);
		}
	}
}
