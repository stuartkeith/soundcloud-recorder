package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RecordView extends Window 
	{
		// list of possible states this view supports, for use by mediator
		// usage: recordView.changeState(RecordView.STATE_INITIAL);
		public static const STATE_INITIAL:String = "stateInitial";
		public static const STATE_RECORDING:String = "stateRecording";
		public static const STATE_RECORDED:String = "stateRecorded";
		
		// list of events this view dispatches (components are not accessed directly by mediator)
		public static const EVENT_RECORD:String = "eventRecord";
		public static const EVENT_RECORD_STOP:String = "eventRecordStop";
		
		// maps states with events for the record button
		// if a match is not found, no event is dispatched
		protected static const recordButtonEventTypes:Object = {
			"stateInitial": "eventRecord",
			"stateRecording": "eventRecordStop",
			"stateRecorded": "eventRecord"
		};
		
		// as above, but maps states with events for the play button
		protected static const playButtonEventTypes:Object = {
		};
		
		// maps states to a desired window title
		protected static const stateTitles:Object = {
			"stateInitial": "Record a Sound",
			"stateRecording": "Recording a Sound...",
			"stateRecorded": "Recorded a Sound"
		};
		
		// set the currentState to the initial state
		protected var currentState:String = STATE_INITIAL;
		
		// components used by this view
		protected var recordButton:PushButton;
		protected var playButton:PushButton;
		
		public function RecordView(parent:DisplayObjectContainer) 
		{
			super(parent, 0, 0, "");
			
			// set up the window
			
			width = 320;
			height = 240;
			draggable = false;
			
			var spacing:int = 8;
			
			// create the containers
			
			var hBox:HBox = new HBox();
			hBox.alignment = HBox.MIDDLE;
			hBox.spacing = spacing;
			hBox.x = spacing;
			hBox.y = spacing;
			
			// create components and add listeners
			
			recordButton = new PushButton();
			recordButton.toggle = true;
			recordButton.addEventListener(MouseEvent.CLICK, onRecordButtonClicked);
			
			playButton = new PushButton();
			playButton.toggle = true;
			playButton.addEventListener(MouseEvent.CLICK, onPlayButtonClicked);
			
			// add components to containers
			
			addChild(hBox);
			
			hBox.addChild(recordButton);
			hBox.addChild(playButton);
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
		
		override public function draw():void 
		{
			// set the window's title to the relevant string
			// or an empty string if no relevant string found
			title = stateTitles[currentState] || "";
			
			// set the record button's properties for the current state
			recordButton.enabled = true;
			recordButton.selected = currentState == STATE_RECORDING;
			recordButton.label = recordButton.selected ? "Stop" : "Record";
			
			// set the play button's properties for the current state
			playButton.enabled = currentState == STATE_RECORDED;
			playButton.selected = false;
			playButton.label = playButton.selected ? "Stop" : "Play";
			
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
	}
}
