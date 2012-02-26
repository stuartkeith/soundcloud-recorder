package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import com.stuartkeith.soundcloud.recorder.model.SampleBufferModel;
	import com.stuartkeith.soundcloud.recorder.vo.SampleVO;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	public class MicrophoneService extends Actor 
	{
		// the maximum number of samples the service can store before it
		// automatically stops recording.
		protected var recordingBufferMaxSamples:int;
		
		protected var microphone:Microphone;
		
		// the recorded data is stored in this sampleBufferModel.
		// set to null if not currently recording.
		protected var sampleBufferModel:SampleBufferModel;
		protected var currentSampleVO:SampleVO;
		protected var samplesRemaining:int;
		
		public function MicrophoneService() 
		{
			// get the default microphone.
			microphone = Microphone.getMicrophone();
			
			// if no microphone is present, microphone will be null.
			if (microphone)
			{
				// set the rate to 44100Hz.
				microphone.rate = 44;
				// prevent the microphone from becoming inactive.
				microphone.setSilenceLevel(0);
				
				// this ensures the microphone access prompt will pop up now, rather than
				// when the record button is pressed.
				microphone.addEventListener(SampleDataEvent.SAMPLE_DATA, SAMPLE_DATA_listener);
			}
		}
		
		public function beginRecording(maxRecordingTimeSeconds:int):Boolean
		{
			// if there's no microphone, we can't go any further.
			if (!microphone)
				return false;
			
			// if we're already recording, stop first.
			stopRecording();
			
			// to convert from seconds to samples:
			// seconds * 44100 (samples per second)
			recordingBufferMaxSamples = maxRecordingTimeSeconds * 44100;
			
			// create a new buffer.
			currentSampleVO = new SampleVO();
			sampleBufferModel = new SampleBufferModel();
			sampleBufferModel.sampleVOHead = currentSampleVO;
			samplesRemaining = recordingBufferMaxSamples;
			
			dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_START, sampleBufferModel,
					sampleBufferModel.totalSamples, recordingBufferMaxSamples));
			
			return true;
		}
		
		public function stopRecording():void
		{
			if (sampleBufferModel)
			{
				// the last sample would have been created but not set, so we'll set it to 0.
				currentSampleVO.sample = 0;
				
				dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_COMPLETE, sampleBufferModel, 0,
						sampleBufferModel.totalSamples));
				
				sampleBufferModel = null;
				samplesRemaining = 0;
			}
		}
		
		public function getActivityLevel():Number
		{
			if (microphone)
			{
				var activityLevel:Number = microphone.activityLevel;
				
				// if the user has blocked the microphone, activityLevel
				// will be -1.
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
			if (sampleBufferModel)
			{
				// store event.data in a local variable for faster access.
				var sampleData:ByteArray = event.data;
				var samplesAvailable:int = sampleData.bytesAvailable / 4;
				// don't use all of the samples available if that means the
				// sound would be longer than the limit.
				var samplesToRead:int = samplesRemaining < samplesAvailable ? samplesRemaining : samplesAvailable;
				
				for (var i:int = 0; i < samplesToRead; i++)
				{
					// store the sample and create another sample for the next one.
					currentSampleVO.sample = sampleData.readFloat();
					currentSampleVO = currentSampleVO.nextSampleVO = new SampleVO();
				}
				
				samplesRemaining -= samplesToRead;
				sampleBufferModel.totalSamples += samplesToRead;
				
				if (samplesRemaining == 0)
					stopRecording();
				else
					dispatch(new SoundProgressEvent(SoundProgressEvent.RECORD_PROGRESS, sampleBufferModel,
							sampleBufferModel.totalSamples, recordingBufferMaxSamples));
			}
		}
	}
}
