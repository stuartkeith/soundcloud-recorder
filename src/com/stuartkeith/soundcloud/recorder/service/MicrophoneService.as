package com.stuartkeith.soundcloud.recorder.service 
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class MicrophoneService extends Actor 
	{
		public static const EVENT_RECORDING_BEGUN:String = "eventRecordingBegun";
		
		// the maximum number of seconds the service will record for until it
		// automatically stops recording.
		protected static const RECORDING_MAX_SECONDS:int = 10;
		
		// the maximum number of bytes the service can store before it
		// automatically stops recording.
		// to convert from seconds to bytes:
		// bytes = seconds * 44100 (samples per second) * 4 (bytes per sample)
		protected static const RECORDING_BUFFER_MAX:int = RECORDING_MAX_SECONDS * 44100 * 4;
		
		protected var microphone:Microphone;
		
		// the recorded data is stored in this byteArray.
		// set to null if not currently recording.
		protected var recordingBuffer:ByteArray;
		
		public function MicrophoneService() 
		{
			// get the default microphone.
			microphone = Microphone.getMicrophone();
			
			// if no microphone is present, microphone will be null.
			if (microphone)
			{
				microphone.rate = 44;
				// prevent the microphone from becoming inactive.
				microphone.setSilenceLevel(0);
			}
		}
		
		public function beginRecording():Boolean
		{
			// if there's no microphone, we can't go any further.
			if (!microphone)
				return false;
			
			// if we're already recording, stop first.
			if (recordingBuffer)
				stopRecording();
			
			// add the event listener for the incoming sound data.
			microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
			
			// create a new buffer.
			recordingBuffer = new ByteArray();
			
			dispatch(new Event(EVENT_RECORDING_BEGUN));
			
			return true;
		}
		
		public function stopRecording():void
		{
			if (recordingBuffer)
			{
				microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
				
				// rewind the buffer so any listeners don't have to do it.
				recordingBuffer.position = 0;
				
				dispatch(new MicrophoneServiceEvent(MicrophoneServiceEvent.RECORDING_COMPLETE, recordingBuffer));
				
				recordingBuffer = null;
			}
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (recordingBuffer)
			{
				// scale the activityLevel down, from 0-100 to 0-1.
				var activityLevel:Number = microphone.activityLevel / 100;
				
				// copy the incoming data into the recordingBuffer
				recordingBuffer.writeBytes(event.data);
				
				// is it time to automatically stop the recording?
				if (recordingBuffer.length >= RECORDING_BUFFER_MAX)
				{
					// clamp the length of the recording to the maximum.
					recordingBuffer.length = RECORDING_BUFFER_MAX;
					
					// and stop the recording.
					stopRecording();
				}
			}
		}
	}
}
