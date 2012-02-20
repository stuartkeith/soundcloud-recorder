package 
{
	import flash.display.Sprite;
	
	public class Main extends Sprite 
	{
		protected var mainContext:MainContext;
		
		public function Main():void 
		{
			mainContext = new MainContext(this);
		}
	}
}
