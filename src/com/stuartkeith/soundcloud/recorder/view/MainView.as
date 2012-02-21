package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.Sprite;
	
	public class MainView extends Sprite 
	{
		protected var mainView_design:MainView_design;
		
		public function MainView() 
		{
			super();
			
			mainView_design = new MainView_design();
			addChild(mainView_design);
		}
	}
}
