package com.stuartkeith.soundcloud.recorder.service 
{
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class MicrophoneService extends Actor 
	{
		// the maximum number of seconds the service will record for until it
		// automatically stops recording.
		protected static const RECORDING_MAX_SECONDS:int = 10;
		
		// the maximum number of bytes the service can store before it
		// automatically stops recording.
		// to convert from seconds to bytes:
		// bytes = seconds * 44100 (samples per second) * 4 (bytes per sample)
		protected static const RECORDING_BUFFER_MAX:int = RECORDING_MAX_SECONDS * 44100 * 4;
		
		protected var microphone:Microphone;
		protected var isRecording:Boolean;
		
		// the recorded audio is stored in this byteArray.
		protected var recordingBuffer:ByteArray;
		
		// the number of bytes recorded. use this instead of
		// recordingBuffer.length: the recordingBuffer is not reset in between
		// recordings in order to prevent deallocation of memory, so
		// recordingBuffer.length does not necessarily return the current
		// recording's length.
		protected var recordingBufferLength:int;
		
		public function MicrophoneService() 
		{
			recordingBuffer = new ByteArray();
			
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
			if (isRecording)
				stopRecording();
			
			// add the event listener for the incoming sound data.
			microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
			
			// reset the recordingBuffer.position and recordingBufferLength.
			// note the recordingBuffer is not cleared, so
			// recordingBuffer.length will not be accurate, use
			// recordingBufferLength instead.
			recordingBuffer.position = 0;
			recordingBufferLength = 0;
			
			isRecording = true;
			
			return true;
		}
		
		public function stopRecording():void
		{
			if (isRecording)
			{
				microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
				
				isRecording = false;
			}
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (isRecording)
			{
				// scale the activityLevel down, from 0-100 to 0-1.
				var activityLevel:Number = microphone.activityLevel / 100;
				
				// add the length of the incoming data
				recordingBufferLength += event.data.length;
				
				// copy the incoming data into the recordingBuffer
				recordingBuffer.writeBytes(event.data);
				
				// is it time to automatically stop the recording?
				if (recordingBufferLength >= RECORDING_BUFFER_MAX)
				{
					// clamp the length of the recording to the maximum.
					recordingBufferLength = RECORDING_BUFFER_MAX;
					
					// and stop the recording.
					stopRecording();
				}
			}
		}
	}
}
