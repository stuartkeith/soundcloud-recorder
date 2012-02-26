package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.DisplayObject;
	
	public class RecordButton extends SimpleToggleButton 
	{
		[Embed(@source="asset/recordButtonUp.png")]
		protected static const RecordButtonUp:Class;
		[Embed(@source="asset/recordButtonDown.png")]
		protected static const RecordButtonDown:Class;
		[Embed(@source="asset/recordButtonDisabled.png")]
		protected static const RecordButtonDisabled:Class;
		
		public function RecordButton()
		{
			super(new RecordButtonUp(), new RecordButtonDown(), new RecordButtonDisabled());
		}
	}
}
