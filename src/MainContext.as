package  
{
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
			
		}
	}
}
