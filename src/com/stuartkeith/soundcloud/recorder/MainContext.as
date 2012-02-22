package com.stuartkeith.soundcloud.recorder 
{
	import com.stuartkeith.soundcloud.recorder.command.*;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.mediator.*;
	import com.stuartkeith.soundcloud.recorder.service.*;
	import com.stuartkeith.soundcloud.recorder.view.*;
	import com.stuartkeith.soundcloud.recorder.vo.*;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context 
	{
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void 
		{
			// create a SoundCloudConfigurationVO and inject it as a singleton for use in commands
			var soundCloudConfigurationVO:SoundCloudConfigurationVO = new SoundCloudConfigurationVO(contextView.loaderInfo.parameters);
			injector.mapValue(SoundCloudConfigurationVO, soundCloudConfigurationVO);
			
			// inject services
			injector.mapSingleton(MicrophoneService);
			
			// map views to mediators
			mediatorMap.mapView(MainView, MainMediator);
			mediatorMap.mapView(ConnectButton, ConnectButtonMediator);
			mediatorMap.mapView(RecordView, RecordViewMediator);
			
			// map framework events to commands
			commandMap.mapEvent(FrameworkEvent.APPLICATION_READY, ProcessQueryStringCommand);
			commandMap.mapEvent(FrameworkEvent.BEGIN_RECORDING, BeginRecordingCommand);
			commandMap.mapEvent(FrameworkEvent.CONNECT_TO_SOUNDCLOUD, NavigateToSoundCloudAuthorisationURLCommand);
			
			// call super (this will dispatch STARTUP_COMPLETE).
			super.startup();
		}
	}
}
