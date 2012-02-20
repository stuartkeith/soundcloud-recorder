package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		public function Main():void 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, _this_ADDED_TO_STAGE);
		}
		
		private function _this_ADDED_TO_STAGE(event:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _this_ADDED_TO_STAGE);
		}
	}
}
