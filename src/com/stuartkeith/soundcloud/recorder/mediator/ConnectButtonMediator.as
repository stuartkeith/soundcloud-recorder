package com.stuartkeith.soundcloud.recorder.mediator 
{
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class ConnectButtonMediator extends Mediator 
	{
		override public function onRegister():void 
		{
			addViewListener(MouseEvent.CLICK, onMouseEvent, MouseEvent);
		}
		
		protected function onMouseEvent(event:MouseEvent):void 
		{
			
		}
	}
}
