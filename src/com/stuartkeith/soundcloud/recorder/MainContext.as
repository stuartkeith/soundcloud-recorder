package com.stuartkeith.soundcloud.recorder 
{
	import com.stuartkeith.soundcloud.recorder.command.NavigateToSoundCloudAuthorisationURLCommand;
	import com.stuartkeith.soundcloud.recorder.command.ProcessQueryStringCommand;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.mediator.ConnectButtonMediator;
	import com.stuartkeith.soundcloud.recorder.mediator.MainMediator;
	import com.stuartkeith.soundcloud.recorder.mediator.RecordViewMediator;
	import com.stuartkeith.soundcloud.recorder.view.ConnectButton;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import com.stuartkeith.soundcloud.recorder.view.RecordView;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
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
			
			// map views to mediators
			mediatorMap.mapView(MainView, MainMediator);
			mediatorMap.mapView(ConnectButton, ConnectButtonMediator);
			mediatorMap.mapView(RecordView, RecordViewMediator);
			
			// map framework events to commands
			commandMap.mapEvent(FrameworkEvent.APPLICATION_READY, ProcessQueryStringCommand);
			commandMap.mapEvent(FrameworkEvent.CONNECT_TO_SOUNDCLOUD, NavigateToSoundCloudAuthorisationURLCommand);
			
			// call super (this will dispatch STARTUP_COMPLETE).
			super.startup();
		}
	}
}
