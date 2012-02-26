package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	
	public class AuthorisationView extends Window 
	{
		protected var text:Text;
		protected var connectButton:ConnectButton;
		
		public function AuthorisationView()
		{
			super(null, 0, 0, getTitleString());
			
			width = 320;
			height = 240;
			draggable = false;
			
			var vBox:VBox = new VBox(this, 8, 8);
			vBox.alignment = VBox.CENTER;
			vBox.spacing = 8;
			
			text = new Text(vBox, 0, 0, getLabelString());
			connectButton = new ConnectButton();
			
			text.editable = false;
			text.selectable = false;
			text.width = width - (vBox.spacing * 2);
			text.height = height - _titleBar.height - connectButton.height - (vBox.spacing * 3);
			vBox.addChild(text);
			
			vBox.addChild(connectButton);
		}
		
		protected function getTitleString():String
		{
			return "SoundCloud Authorisation Required";
		}
		
		protected function getLabelString():String
		{
			return "Before you begin recording, please authorise this application " +
					"with SoundCloud so you can upload your sounds to your SoundCloud account.";
		}
	}
}
