package 
{
	import com.stuartkeith.soundcloud.recorder.MainContext;
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		protected var mainContext:MainContext;
		
		public function Main():void 
		{
			mainContext = new MainContext(this);
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(new MainView());
		}
	}
}
