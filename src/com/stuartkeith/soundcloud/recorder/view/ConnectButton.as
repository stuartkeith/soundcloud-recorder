package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class ConnectButton extends SimpleButton 
	{
		[Embed(source="asset/connectButton.png")]
		protected var ConnectButtonBitmap:Class;
		
		public function ConnectButton() 
		{
			var connectButtonDisplayObject:DisplayObject = new ConnectButtonBitmap();
			
			super(connectButtonDisplayObject, connectButtonDisplayObject, connectButtonDisplayObject,
					connectButtonDisplayObject);
		}
	}
}
