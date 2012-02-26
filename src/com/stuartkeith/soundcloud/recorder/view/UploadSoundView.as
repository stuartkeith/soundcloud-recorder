package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadEvent;
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
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
			super(parent, 0, 0, "Upload the Sound to SoundCloud");
			
			// set up the window
			
			width = 182;
			height = 108 + titleBar.height;
			draggable = false;
			
			var spacing:int = 8;
			
			// create containers
			var vBox:VBox = new VBox();
			vBox.alignment = VBox.CENTER;
			vBox.x = spacing;
			vBox.y = spacing;
			vBox.spacing = spacing;
			
			var titleHBox:HBox = new HBox();
			titleHBox.spacing = spacing;
			
			var tagsHBox:HBox = new HBox();
			tagsHBox.spacing = spacing;
			
			// create components and add listeners
			soundTitleInputText = new InputText();
			soundTitleInputText.width = 128;
			soundTitleInputText.addEventListener(Event.CHANGE, soundTitleInputText_CHANGE_listener, false, 0, true);
			
			soundIsPublicCheckBox = new CheckBox();
			soundIsPublicCheckBox.label = "Share publicly?";
			
			soundTagsInputText = new InputText();
			soundTagsInputText.width = 128;
			
			uploadButton = new PushButton();
			uploadButton.enabled = false;
			uploadButton.label = "Upload";
			uploadButton.addEventListener(MouseEvent.CLICK, uploadButton_CLICK_listener, false, 0, true);
			
			// add components to container
			
			addChild(vBox);
			
			titleHBox.addChild(new Label(null, 0, 0, "Title:"));
			titleHBox.addChild(soundTitleInputText);
			vBox.addChild(titleHBox)
			
			tagsHBox.addChild(new Label(null, 0, 0, "Tags:"));
			tagsHBox.addChild(soundTagsInputText);
			vBox.addChild(tagsHBox);
			
			vBox.addChild(soundIsPublicCheckBox);
			vBox.addChild(uploadButton);
		}
		
		protected function soundTitleInputText_CHANGE_listener(event:Event):void 
		{
			uploadButton.enabled = soundTitleInputText.text.length > 0;
		}
		
		protected function uploadButton_CLICK_listener(event:MouseEvent):void 
		{
			var soundVO:SoundVO = new SoundVO();
			
			soundVO.title = soundTitleInputText.text;
			soundVO.isPublic = soundIsPublicCheckBox.selected;
			soundVO.tags = soundTagsInputText.text;
			
			dispatchEvent(new UploadEvent(UploadEvent.REQUEST_UPLOAD, soundVO));
		}
	}
}
