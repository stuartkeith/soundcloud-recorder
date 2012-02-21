package com.stuartkeith.soundcloud.recorder 
{
	import com.stuartkeith.soundcloud.recorder.command.ProcessQueryStringCommand;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.mediator.ConnectButtonMediator;
	import com.stuartkeith.soundcloud.recorder.mediator.MainMediator;
	import com.stuartkeith.soundcloud.recorder.view.ConnectButton;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
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
			// map views to mediators
			mediatorMap.mapView(MainView, MainMediator);
			mediatorMap.mapView(ConnectButton, ConnectButtonMediator);
			
			// map framework events to commands
			commandMap.mapEvent(FrameworkEvent.APPLICATION_READY, ProcessQueryStringCommand);
			
			// call super (this will dispatch STARTUP_COMPLETE).
			super.startup();
		}
	}
}
