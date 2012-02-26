package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RecordView extends Window 
	{
		// list of possible states this view supports, for use by mediator
		// usage: recordView.changeState(RecordView.STATE_INITIAL);
		public static const STATE_INITIAL:String = "stateInitial";
		public static const STATE_RECORDING:String = "stateRecording";
		public static const STATE_RECORDED:String = "stateRecorded";
		public static const STATE_PLAYING:String = "statePlaying";
		
		// list of events this view dispatches (components are not accessed directly by mediator)
		public static const EVENT_RECORD:String = "eventRecord";
		public static const EVENT_RECORD_STOP:String = "eventRecordStop";
		public static const EVENT_PLAY:String = "eventPlay";
		public static const EVENT_PLAY_STOP:String = "eventPlayStop";
		public static const EVENT_UPLOAD:String = "eventUpload";
		
		// maps states with events for the record button
		// if a match is not found, no event is dispatched
		protected static const recordButtonEventTypes:Object = {
			"stateInitial": "eventRecord",
			"stateRecording": "eventRecordStop",
			"stateRecorded": "eventRecord"
		};
		
		// as above, but maps states with events for the play button
		protected static const playButtonEventTypes:Object = {
			"stateRecorded": "eventPlay",
			"statePlaying": "eventPlayStop"
		};
		
		// maps states to a desired window title
		protected static const stateTitles:Object = {
			"stateInitial": "Record a Sound",
			"stateRecording": "Recording a Sound...",
			"stateRecorded": "Recorded a Sound",
			"statePlaying": "Playing the Sound"
		};
		
		// set the currentState to the initial state
		protected var currentState:String = STATE_INITIAL;
		
		// components used by this view
		protected var microphoneActivityView:MicrophoneActivityView;
		protected var timeView:TimeView;
		protected var recordButton:RecordButton;
		protected var playButton:PlayButton;
		protected var uploadButton:PushButton;
		
		public function RecordView() 
		{
			super(null, 0, 0, "");
			
			// set up the window
			
			width = 440;
			height = 152;
			draggable = false;
			
			var spacing:int = 8;
			
			// create the containers
			
			var hBox:HBox = new HBox();
			hBox.x = spacing;
			hBox.y = spacing;
			hBox.spacing = spacing;
			
			var buttonHBox:HBox = new HBox();
			buttonHBox.alignment = HBox.MIDDLE;
			buttonHBox.spacing = spacing;
			
			var vBox:VBox = new VBox();
			vBox.alignment = VBox.CENTER;
			vBox.spacing = spacing;
			
			// create components and add listeners
			
			microphoneActivityView = new MicrophoneActivityView();
			microphoneActivityView.width = 32;
			microphoneActivityView.height = 116;
			
			timeView = new TimeView();
			timeView.width = 384;
			timeView.height = 32;
			
			recordButton = new RecordButton();
			recordButton.addEventListener(MouseEvent.CLICK, onRecordButtonClicked);
			
			playButton = new PlayButton();
			playButton.addEventListener(MouseEvent.CLICK, onPlayButtonClicked);
			
			uploadButton = new PushButton();
			uploadButton.label = "Upload to SoundCloud";
			uploadButton.width += spacing * 4;
			uploadButton.addEventListener(MouseEvent.CLICK, onUploadButtonClicked);
			
			// add components to containers
			
			addChild(hBox);
			
			hBox.addChild(microphoneActivityView);
			hBox.addChild(vBox);
			
			vBox.addChild(timeView);
			vBox.addChild(buttonHBox);
			
			buttonHBox.addChild(recordButton);
			buttonHBox.addChild(playButton);
			
			vBox.addChild(uploadButton);
		}
		
		public function changeState(state:String):void
		{
			// if a new state is specified, invalidate the component so it will be redrawn on the next frame
			
			if (state != currentState)
			{
				currentState = state;
				
				invalidate();
			}
		}
		
		public function updateMicrophoneActivity(value:Number):void
		{
			microphoneActivityView.value = value;
		}
		
		override public function draw():void 
		{
			// set the window's title to the relevant string
			// or an empty string if no relevant string found
			title = stateTitles[currentState] || "";
			
			// set the record button's properties for the current state
			recordButton.enabled = currentState != STATE_PLAYING;
			recordButton.isToggled = currentState == STATE_RECORDING;
			
			// set the play button's properties for the current state
			playButton.enabled = currentState == STATE_RECORDED || currentState == STATE_PLAYING;
			playButton.isToggled = currentState == STATE_PLAYING;
			
			uploadButton.enabled = currentState == STATE_RECORDED;
			
			super.draw();
		}
		
		protected function dispatchEventType(eventType:String):void
		{
			if (eventType)
				dispatchEvent(new Event(eventType));
		}
		
		protected function onRecordButtonClicked(event:MouseEvent):void 
		{
			dispatchEventType(recordButtonEventTypes[currentState]);
		}
		
		protected function onPlayButtonClicked(event:MouseEvent):void 
		{
			dispatchEventType(playButtonEventTypes[currentState]);
		}
		
		protected function onUploadButtonClicked(event:MouseEvent):void 
		{
			dispatchEvent(new Event(EVENT_UPLOAD));
		}
	}
}
