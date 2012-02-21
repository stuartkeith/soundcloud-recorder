package  
{
	import com.stuartkeith.soundcloud.recorder.MainView;
	import flash.display.DisplayObjectContainer;
	import mediator.MainMediator;
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
