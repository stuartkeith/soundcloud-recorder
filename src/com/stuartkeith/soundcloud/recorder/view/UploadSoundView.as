package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadRequestEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class UploadSoundView extends Window 
	{
		// components used by this view
		
		protected var soundTitleInputText:InputText;
		protected var soundIsPublicCheckBox:CheckBox;
		protected var soundTagsInputText:InputText;
		protected var uploadButton:PushButton;
		
		public function UploadSoundView(parent:DisplayObjectContainer=null) 
		{
			super(parent, 0, 0, "Upload to SoundCloud");
			
			// set up the window
			
			width = 320;
			height = 240;
			draggable = false;
			
			var spacing:int = 8;
			
			// create container
			var vBox:VBox = new VBox();
			vBox.alignment = VBox.CENTER;
			vBox.x = spacing;
			vBox.y = spacing;
			vBox.spacing = spacing;
			
			// create components and add listeners
			soundTitleInputText = new InputText();
			soundTitleInputText.addEventListener(Event.CHANGE, soundTitleInputText_CHANGE_listener);
			
			soundIsPublicCheckBox = new CheckBox();
			soundIsPublicCheckBox.label = "Share publicly?";
			
			soundTagsInputText = new InputText();
			
			uploadButton = new PushButton();
			uploadButton.enabled = false;
			uploadButton.label = "Upload";
			uploadButton.addEventListener(MouseEvent.CLICK, uploadButton_CLICK_listener);
			
			// add components to container
			
			addChild(vBox);
			
			vBox.addChild(new Label(null, 0, 0, "Title:"));
			vBox.addChild(soundTitleInputText);
			vBox.addChild(soundIsPublicCheckBox);
			vBox.addChild(new Label(null, 0, 0, "Tags:"));
			vBox.addChild(soundTagsInputText);
			vBox.addChild(uploadButton);
		}
		
		protected function soundTitleInputText_CHANGE_listener(event:Event):void 
		{
			uploadButton.enabled = soundTitleInputText.text.length > 0;
		}
		
		protected function uploadButton_CLICK_listener(event:MouseEvent):void 
		{
			dispatchEvent(new UploadRequestEvent(UploadRequestEvent.UPLOAD_REQUEST, soundTitleInputText.text,
					soundIsPublicCheckBox.selected, soundTagsInputText.text));
		}
	}
}
