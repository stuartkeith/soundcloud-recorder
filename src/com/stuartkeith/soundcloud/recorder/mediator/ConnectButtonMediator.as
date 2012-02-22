package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class ConnectButtonMediator extends Mediator 
	{
		override public function onRegister():void 
		{
			addViewListener(MouseEvent.CLICK, CLICK_listener, MouseEvent);
		}
		
		protected function CLICK_listener(event:MouseEvent):void 
		{
			dispatch(new Event(FrameworkEvent.CONNECT_TO_SOUNDCLOUD));
		}
	}
}
