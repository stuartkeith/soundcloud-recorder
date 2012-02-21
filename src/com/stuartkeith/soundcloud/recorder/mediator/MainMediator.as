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
			addContextListener(FrameworkEvent.AUTHORISATION_REQUIRED, authorisationRequired, Event);
			
			dispatch(new Event(FrameworkEvent.APPLICATION_READY));
		}
		
		protected function authorisationRequired(event:Event):void 
		{
			mainView.showAuthorisationView();
		}
	}
}
