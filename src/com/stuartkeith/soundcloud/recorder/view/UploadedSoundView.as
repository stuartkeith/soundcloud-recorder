package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import flash.events.MouseEvent;
	
	public class UploadedSoundView extends Window 
	{
		protected var soundTitle:String;
		protected var soundPermalinkURL:String;
		
		public function UploadedSoundView($soundTitle:String, $soundPermalinkURL:String) 
		{
			super();
			
			soundTitle = $soundTitle;
			soundPermalinkURL = $soundPermalinkURL;
			
			// set up the window.
			
			width = 304;
			height = 110;
			title = "Uploaded to SoundCloud!";
			draggable = false;
			
			// create containers
			
			var vBox:VBox = new VBox();
			vBox.spacing = 8;
			vBox.x = vBox.spacing;
			vBox.y = vBox.spacing;
			vBox.alignment = VBox.CENTER;
			
			// create components
			
			var soundTitleLabel:Label = new Label();
			soundTitleLabel.text = "'" + soundTitle + "' was successfully uploaded.";
			
			var soundPermalinkURLButton:PushButton = new PushButton();
			soundPermalinkURLButton.width = width - (vBox.spacing * 2);
			soundPermalinkURLButton.label = "View '" + soundTitle + "' on SoundCloud";
			soundPermalinkURLButton.addEventListener(MouseEvent.CLICK, soundPermalinkURLButton_CLICK_listener);
			
			var recordAnotherSoundButton:PushButton = new PushButton();
			recordAnotherSoundButton.width = soundPermalinkURLButton.width;
			recordAnotherSoundButton.label = "Record another sound";
			recordAnotherSoundButton.addEventListener(MouseEvent.CLICK, recordAnotherSoundButton_CLICK_listener);
			
			// add components to container
			
			addChild(vBox);
			
			vBox.addChild(soundTitleLabel);
			vBox.addChild(soundPermalinkURLButton);
			vBox.addChild(recordAnotherSoundButton);
		}
		
		protected function soundPermalinkURLButton_CLICK_listener(event:MouseEvent):void 
		{
			dispatchEvent(new UploadedSoundViewEvent(UploadedSoundViewEvent.NAVIGATE_TO_PERMALINK, soundTitle,
					soundPermalinkURL));
		}
		
		protected function recordAnotherSoundButton_CLICK_listener(event:MouseEvent):void 
		{
			dispatchEvent(new UploadedSoundViewEvent(UploadedSoundViewEvent.RECORD_ANOTHER_SOUND, soundTitle,
					soundPermalinkURL));
		}
	}
}
