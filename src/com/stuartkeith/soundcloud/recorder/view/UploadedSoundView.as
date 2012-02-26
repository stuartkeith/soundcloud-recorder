package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
	import flash.events.MouseEvent;
	
	public class UploadedSoundView extends Window 
	{
		protected var soundVO:SoundVO;
		
		public function UploadedSoundView($soundVO:SoundVO) 
		{
			super();
			
			soundVO = $soundVO;
			
			// set up the window:
			
			width = 304;
			height = 110;
			title = "Uploaded to SoundCloud!";
			draggable = false;
			
			// create containers:
			
			var vBox:VBox = new VBox();
			vBox.spacing = 8;
			vBox.x = vBox.spacing;
			vBox.y = vBox.spacing;
			vBox.alignment = VBox.CENTER;
			
			// create components:
			
			var soundTitleLabel:Label = new Label();
			soundTitleLabel.text = "'" + soundVO.title + "' was successfully uploaded.";
			
			var soundPermalinkURLButton:PushButton = new PushButton();
			soundPermalinkURLButton.width = width - (vBox.spacing * 2);
			soundPermalinkURLButton.label = "View '" + soundVO.title + "' on SoundCloud";
			soundPermalinkURLButton.addEventListener(MouseEvent.CLICK, soundPermalinkURLButton_CLICK_listener,
					false, 0, true);
			
			var recordAnotherSoundButton:PushButton = new PushButton();
			recordAnotherSoundButton.width = soundPermalinkURLButton.width;
			recordAnotherSoundButton.label = "Record another sound";
			recordAnotherSoundButton.addEventListener(MouseEvent.CLICK, recordAnotherSoundButton_CLICK_listener,
					false, 0, true);
			
			// add components to container:
			
			addChild(vBox);
			
			vBox.addChild(soundTitleLabel);
			vBox.addChild(soundPermalinkURLButton);
			vBox.addChild(recordAnotherSoundButton);
		}
		
		protected function soundPermalinkURLButton_CLICK_listener(event:MouseEvent):void 
		{
			dispatchEvent(new UploadedSoundViewEvent(UploadedSoundViewEvent.NAVIGATE_TO_PERMALINK, soundVO));
		}
		
		protected function recordAnotherSoundButton_CLICK_listener(event:MouseEvent):void 
		{
			dispatchEvent(new UploadedSoundViewEvent(UploadedSoundViewEvent.RECORD_ANOTHER_SOUND, soundVO));
		}
	}
}
