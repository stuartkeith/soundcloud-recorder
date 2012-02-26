package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
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
				
				// this ensures the microphone access prompt will pop up now, rather than
				// when the record button is pressed.
				microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
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
			
			// create a new buffer.
			recordingBuffer = new ByteArray();
			
			dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_START, recordingBuffer, RECORDING_BUFFER_MAX));
			
			return true;
		}
		
		public function stopRecording():void
		{
			if (recordingBuffer)
			{
				// rewind the buffer so any listeners don't have to do it.
				recordingBuffer.position = 0;
				
				// do not specify bytesTotal when recording is complete, as the buffer is now fixed.
				dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_COMPLETE, recordingBuffer));
				
				recordingBuffer = null;
			}
		}
		
		public function getActivityLevel():Number
		{
			if (microphone)
			{
				var activityLevel:Number = microphone.activityLevel;
				
				if (activityLevel != -1)
					// activityLevel is 0 to 100: we want 0 to 1.
					return activityLevel / 100;
				else
					return 0;
			}
			else
			{
				return 0;
			}
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (recordingBuffer)
			{
				// copy the incoming data into the recordingBuffer.
				recordingBuffer.writeBytes(event.data);
				
				// clamp the length of the recording to the maximum.
				// need to do this before the event is dispatched, or
				// the reported samplesTotal might be incorrect.
				if (recordingBuffer.length > RECORDING_BUFFER_MAX)
					recordingBuffer.length = RECORDING_BUFFER_MAX;
				
				// is it time to automatically stop the recording?
				if (recordingBuffer.length == RECORDING_BUFFER_MAX)
				{
					// clamp the length of the recording to the maximum.
					recordingBuffer.length = RECORDING_BUFFER_MAX;
					
					// and stop the recording.
					stopRecording();
				}
				else
				{
					dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_PROGRESS, recordingBuffer,
							RECORDING_BUFFER_MAX));
				}
			}
		}
	}
}
