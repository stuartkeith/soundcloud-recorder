package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.AuthorisationError;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadEvent;
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneService;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator 
	{
		[Inject] public var microphoneService:MicrophoneService;
		[Inject] public var mainView:MainView;
		
		override public function onRegister():void 
		{
			addContextListener(AuthorisationError.AUTHORISATION_ERROR, AUTHORISATION_ERROR_listener, AuthorisationError);
			addContextListener(FrameworkEvent.AUTHORISATION_REQUIRED, AUTHORISATION_REQUIRED_listener, Event);
			addContextListener(FrameworkEvent.AUTHORISATION_SUCCESSFUL, AUTHORISATION_SUCCESSFUL_listener, Event);
			addContextListener(FrameworkEvent.BEGIN_UPLOAD, BEGIN_UPLOAD_listener, Event);
			addContextListener(UploadEvent.UPLOADING, UPLOADING_listener, UploadEvent);
			addContextListener(UploadEvent.UPLOADED, UPLOADED_listener, UploadEvent);
			
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
			// this ensures the microphone access prompt will pop up now, rather than
			// when the record button is pressed.
			microphoneService;
			
			mainView.showRecordingView();
		}
		
		protected function BEGIN_UPLOAD_listener(event:Event):void 
		{
			mainView.showUploadSoundView();
		}
		
		protected function UPLOADING_listener(event:UploadEvent):void 
		{
			mainView.showUploadingSoundView();
		}
		
		protected function UPLOADED_listener(event:UploadEvent):void 
		{
			var title:String = event.response["title"];
			var permalinkURL:String = event.response["permalink-url"];
			
			mainView.showUploadedSoundView(title, permalinkURL);
		}
	}
}
