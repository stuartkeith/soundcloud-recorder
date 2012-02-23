package com.stuartkeith.soundcloud.recorder.service 
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class SoundOutputService extends Actor 
	{
		public static const EVENT_PLAYING:String = "eventPlaying";
		public static const EVENT_STOPPED:String = "eventStopped";
		
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
				
				outputSound.play();
				
				dispatch(new Event(EVENT_PLAYING));
			}
		}
		
		public function stopPlaying():void
		{
			currentRecordingBuffer = null;
			
			dispatch(new Event(EVENT_STOPPED));
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (currentRecordingBuffer)
			{
				// store event.data in a local variable for faster access.
				var outputBuffer:ByteArray = event.data;
				// store currentBuffer.bytesAvailable in a local variable for faster access.
				var bytesAvailable:uint = currentRecordingBuffer.bytesAvailable;
				// process as many bytes as possible from the recording - capped at MAX_OUTPUT_BYTES.
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
			}
		}
	}
}
