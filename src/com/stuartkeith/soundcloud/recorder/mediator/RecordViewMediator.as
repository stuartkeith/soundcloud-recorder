package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.view.RecordView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class RecordViewMediator extends Mediator 
	{
		[Inject] public var recordView:RecordView;
		
		override public function onRegister():void 
		{
			addViewListener(RecordView.EVENT_RECORD, EVENT_RECORD_listener, Event);
		}
		
		protected function EVENT_RECORD_listener(event:Event):void 
		{
			dispatch(new Event(FrameworkEvent.BEGIN_RECORDING));
		}
	}
}
