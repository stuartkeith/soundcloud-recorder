package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import com.stuartkeith.soundcloud.recorder.model.SampleBufferModel;
	import com.stuartkeith.soundcloud.recorder.vo.SampleVO;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class SoundOutputService extends Actor 
	{
		// the maximum number of samples to output each update.
		// the Flash player requires it to be >= 2048.
		protected static const MAX_OUTPUT_SAMPLES:uint = 2048;
		
		// the sound instance used to output sound.
		protected var outputSound:Sound;
		
		// the current recording being played back.
		// may be null if no recording is being played.
		protected var sampleBufferModel:SampleBufferModel;
		protected var currentSampleVO:SampleVO;
		protected var samplesWritten:int;
		protected var samplesRemaining:int;
		
		public function SoundOutputService() 
		{
			outputSound = new Sound();
			
			outputSound.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
		}
		
		public function startPlaying($sampleBufferModel:SampleBufferModel):void
		{
			// if a recording is already playing, stop it.
			stopPlaying();
			
			if ($sampleBufferModel)
			{
				// create a new buffer.
				sampleBufferModel = $sampleBufferModel;
				currentSampleVO = sampleBufferModel.sampleVOHead;
				samplesWritten = 0;
				samplesRemaining = sampleBufferModel.totalSamples;
				
				dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_START, sampleBufferModel,
						samplesWritten, sampleBufferModel.totalSamples));
				
				// start streaming the sound.
				outputSound.play();
			}
		}
		
		public function stopPlaying():void
		{
			if (sampleBufferModel)
			{
				dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_COMPLETE, sampleBufferModel,
							samplesWritten, sampleBufferModel.totalSamples));
				
				sampleBufferModel = null;
				currentSampleVO = null;
				samplesWritten = 0;
				samplesRemaining = 0;
			}
		}
		
		protected function SAMPLE_DATA_listener(event:SampleDataEvent):void 
		{
			if (sampleBufferModel)
			{
				// store event.data in a local variable for faster access.
				var outputBuffer:ByteArray = event.data;
				
				var currentSample:Number;
				
				// we will output either the rest of the samples or
				// MAX_OUTPUT_SAMPLES samples, whichever is lower.
				var samplesToRead:int = samplesRemaining < MAX_OUTPUT_SAMPLES ? samplesRemaining : MAX_OUTPUT_SAMPLES;
				
				for (var i:uint = 0; i < samplesToRead; i++)
				{
					currentSample = currentSampleVO.sample;
					
					// the input is mono, the output is stereo...
					// so output each sample twice.
					outputBuffer.writeFloat(currentSample);
					outputBuffer.writeFloat(currentSample);
					
					// go to the next sampleVO in the linked list.
					currentSampleVO = currentSampleVO.nextSampleVO;
				}
				
				samplesRemaining -= samplesToRead;
				samplesWritten += samplesToRead;
				
				if (samplesRemaining == 0)
					stopPlaying();
				else
					dispatch(new SoundProgressEvent(SoundProgressEvent.PLAYBACK_PROGRESS, sampleBufferModel,
						samplesWritten, sampleBufferModel.totalSamples));
			}
		}
	}
}
