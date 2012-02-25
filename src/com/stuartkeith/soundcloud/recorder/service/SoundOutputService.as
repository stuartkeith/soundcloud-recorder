package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class SoundOutputService extends Actor 
	{
		// the maximum number of bytes to output each update.
		// bytes = number of samples * 4 bytes per sample.
		protected static const MAX_OUTPUT_BYTES:uint = 2048 * 4;
		
		// the sound instance used to output sound.
		protected var outputSound:Sound;
		
		// the current recording being played back.
		// may be null if no recording is being played.
		protected var currentRecordingBuffer:ByteArray;
		
		public function SoundOutputService() 
		{
			outputSound = new Sound();
			
			outputSound.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
		}
		
		public function startPlaying(recordingBuffer:ByteArray):void
		{
			// if a recording is already playing, stop it.
			if (currentRecordingBuffer)
				stopPlaying();
			
			if (recordingBuffer)
			{
				currentRecordingBuffer = recordingBuffer;
				
				recordingBuffer.position = 0;
				
				dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_START, currentRecordingBuffer));
				
				outputSound.play();
			}
		}
		
		public function stopPlaying():void
		{
			dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_COMPLETE, currentRecordingBuffer));
			
			currentRecordingBuffer = null;
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (currentRecordingBuffer)
			{
				// store event.data in a local variable for faster access.
				var outputBuffer:ByteArray = event.data;
				// store currentBuffer.bytesAvailable in a local variable for faster access.
				var bytesAvailable:uint = currentRecordingBuffer.bytesAvailable;
				// process as many bytes as possible from the recording: capped at MAX_OUTPUT_BYTES.
				var bytesToProcess:uint = bytesAvailable < MAX_OUTPUT_BYTES ? bytesAvailable : MAX_OUTPUT_BYTES;
				// each float/Number is four bytes in size.
				var floatsToProcess:uint = bytesToProcess / 4;
				
				var currentFloat:Number;
				
				// read the desired number of floats from currentRecordingBuffer.
				for (var i:uint = 0; i < floatsToProcess; i++)
				{
					currentFloat = currentRecordingBuffer.readFloat();
					
					// the currentRecordingBuffer is mono, the outputBuffer
					// needs to be stereo... so output each float twice.
					outputBuffer.writeFloat(currentFloat);
					outputBuffer.writeFloat(currentFloat);
				}
				
				// if there weren't enough bytes to fill the output buffer,
				// we've run out of bytes. stop the playback.
				if (bytesToProcess != MAX_OUTPUT_BYTES)
					stopPlaying();
				else
					dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_PROGRESS, currentRecordingBuffer));
			}
		}
	}
}
