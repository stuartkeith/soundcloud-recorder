package com.stuartkeith.soundcloud.recorder 
{
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.mediator.MainMediator;
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
			
			// call super (this will dispatch STARTUP_COMPLETE).
			super.startup();
		}
	}
}
