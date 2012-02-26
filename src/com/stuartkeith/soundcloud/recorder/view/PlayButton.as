package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.DisplayObject;
	
	public class PlayButton extends SimpleToggleButton 
	{
		[Embed(@source="asset/playButtonUp.png")]
		protected static const PlayButtonUp:Class;
		[Embed(@source="asset/playButtonDown.png")]
		protected static const PlayButtonDown:Class;
		[Embed(@source="asset/playButtonDisabled.png")]
		protected static const PlayButtonDisabled:Class;
		
		public function PlayButton()
		{
			super(new PlayButtonUp(), new PlayButtonDown(), new PlayButtonDisabled());
		}
	}
}
