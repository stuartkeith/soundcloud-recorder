package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RecordView extends Window 
	{
		// list of possible states this view supports, for use by mediator.
		// usage: recordView.changeState(RecordView.STATE_INITIAL);
		public static const STATE_INITIAL:String = "stateInitial";
		public static const STATE_RECORDING:String = "stateRecording";
		public static const STATE_RECORDED:String = "stateRecorded";
		public static const STATE_PLAYING:String = "statePlaying";
		
		// list of events this view dispatches (components are not accessed directly by mediator).
		public static const EVENT_RECORD:String = "eventRecord";
		public static const EVENT_RECORD_STOP:String = "eventRecordStop";
		public static const EVENT_PLAY:String = "eventPlay";
		public static const EVENT_PLAY_STOP:String = "eventPlayStop";
		public static const EVENT_UPLOAD:String = "eventUpload";
		
		// maps states with events for the record button.
		// if a match is not found, no event is dispatched.
		protected static const recordButtonEventTypes:Object = {
			"stateInitial": "eventRecord",
			"stateRecording": "eventRecordStop",
			"stateRecorded": "eventRecord"
		};
		
		// as above, but maps states with events for the play button.
		protected static const playButtonEventTypes:Object = {
			"stateRecorded": "eventPlay",
			"statePlaying": "eventPlayStop"
		};
		
		// maps states to a desired window title.
		protected static const stateTitles:Object = {
			"stateInitial": "Record a Sound",
			"stateRecording": "Recording a Sound...",
			"stateRecorded": "Recorded a Sound",
			"statePlaying": "Playing the Sound"
		};
		
		// set the currentState to the initial state.
		protected var currentState:String = STATE_INITIAL;
		
		// components used by this view:
		protected var microphoneActivityView:MicrophoneActivityView;
		protected var timeView:TimeView;
		protected var recordButton:RecordButton;
		protected var playButton:PlayButton;
		protected var uploadButton:PushButton;
		
		public function RecordView() 
		{
			super();
			
			// set up the window:
			
			width = 440;
			height = 148;
			draggable = false;
			
			// create components and add listeners:
			
			microphoneActivityView = new MicrophoneActivityView();
			
			timeView = new TimeView();
			
			recordButton = new RecordButton();
			recordButton.addEventListener(MouseEvent.CLICK, onRecordButtonClicked, false, 0, true);
			
			playButton = new PlayButton();
			playButton.addEventListener(MouseEvent.CLICK, onPlayButtonClicked, false, 0, true);
			
			uploadButton = new PushButton();
			uploadButton.label = "Upload to SoundCloud";
			uploadButton.addEventListener(MouseEvent.CLICK, onUploadButtonClicked, false, 0, true);
			
			// add and position components:
			
			addChild(microphoneActivityView);
			addChild(timeView);
			addChild(recordButton);
			addChild(playButton);
			addChild(uploadButton);
			
			var spacing:int = 8;
			
			microphoneActivityView.x = spacing * 2;
			microphoneActivityView.y = spacing * 2;
			microphoneActivityView.width = 32;
			microphoneActivityView.height = 96;
			
			timeView.width = 368;
			timeView.height = 32;
			timeView.x = microphoneActivityView.x + microphoneActivityView.width + spacing;
			timeView.y = 16;
			
			recordButton.x = timeView.x + (spacing * 4);
			recordButton.y = 64;
			
			playButton.x = recordButton.x + recordButton.width + (spacing * 2);
			playButton.y = recordButton.y;
			
			uploadButton.width = 176;
			uploadButton.height = 48;
			uploadButton.x = playButton.x + playButton.width + (spacing * 2);
			uploadButton.y = playButton.y;
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
