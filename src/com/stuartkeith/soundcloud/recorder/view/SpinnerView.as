package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Window;
	import flash.display.Sprite;
	
	public class SpinnerView extends Window 
	{
		[Embed(source="asset/spinner.swf")]
		protected var Spinner:Class;
		
		public function SpinnerView($title:String) 
		{
			super();
			
			// set up the window.
			
			width = 192;
			height = 64;
			draggable = false;
			title = $title;
			
			// add the spinner animation.
			var spinner:Sprite = new Spinner();
			addChild(spinner);
			
			// centre it in the window.
			spinner.x = (width / 2) - (spinner.width / 2);
			spinner.y = ((height - titleBar.height) / 2) - (spinner.height / 2);
		}
	}
}
