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
			addContextListener(AuthorisationError.AUTHORISATION_ERROR, authorisationError, AuthorisationError);
			addContextListener(FrameworkEvent.AUTHORISATION_REQUIRED, authorisationRequired, Event);
			
			dispatch(new Event(FrameworkEvent.APPLICATION_READY));
		}
		
		protected function authorisationError(event:AuthorisationError):void 
		{
			mainView.showAuthorisationError(event.error, event.errorDescription);
		}
		
		protected function authorisationRequired(event:Event):void 
		{
			mainView.showAuthorisationView();
		}
	}
}
