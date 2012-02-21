package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator 
	{
		[Inject] public var mainView:MainView;
		
		override public function onRegister():void 
		{
			dispatch(new Event(FrameworkEvent.APPLICATION_READY));
		}
	}
}
