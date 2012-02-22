package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.AuthorisationError;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator 
	{
		[Inject] public var mainView:MainView;
		
		override public function onRegister():void 
		{
			addContextListener(AuthorisationError.AUTHORISATION_ERROR, AUTHORISATION_ERROR_listener, AuthorisationError);
			addContextListener(FrameworkEvent.AUTHORISATION_REQUIRED, AUTHORISATION_REQUIRED_listener, Event);
			addContextListener(FrameworkEvent.AUTHORISATION_SUCCESSFUL, AUTHORISATION_SUCCESSFUL_listener, Event);
			
			dispatch(new Event(FrameworkEvent.APPLICATION_READY));
		}
		
		protected function AUTHORISATION_ERROR_listener(event:AuthorisationError):void 
		{
			mainView.showAuthorisationError(event.error, event.errorDescription);
		}
		
		protected function AUTHORISATION_REQUIRED_listener(event:Event):void 
		{
			mainView.showAuthorisationView();
		}
		
		protected function AUTHORISATION_SUCCESSFUL_listener(event:Event):void 
		{
			mainView.showRecordingView();
		}
	}
}
