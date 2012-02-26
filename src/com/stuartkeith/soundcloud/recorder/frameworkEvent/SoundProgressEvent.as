package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import com.stuartkeith.soundcloud.recorder.model.SampleBufferModel;
	import flash.events.Event;
	
	public class SoundProgressEvent extends Event 
	{
		public static const RECORD_START:String = "recordStart";
		public static const RECORD_PROGRESS:String = "recordProgress";
		public static const RECORD_COMPLETE:String = "recordComplete";
		
		public static const PLAYBACK_START:String = "playbackStart";
		public static const PLAYBACK_PROGRESS:String = "playbackProgress";
		public static const PLAYBACK_COMPLETE:String = "playbackComplete";
		
		protected var _sampleBufferModel:SampleBufferModel;
		protected var _samplesWritten:int;
		protected var _samplesTotal:int;
		protected var _secondsWritten:int;
		protected var _secondsTotal:int;
		
		public function SoundProgressEvent(type:String, $sampleBufferModel:SampleBufferModel, $samplesWritten:int,
				$samplesTotal:int, bubbles:Boolean = false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_sampleBufferModel = $sampleBufferModel;
			
			_samplesWritten = $samplesWritten;
			_samplesTotal = $samplesTotal;
			
			// there are 44100 samples per second, so divide by 44100.
			_secondsWritten = _samplesWritten / 44100;
			_secondsTotal = _samplesTotal / 44100;
		}
		
		override public function clone():Event 
		{
			return new SoundProgressEvent(type, _sampleBufferModel, _samplesWritten, _samplesTotal, bubbles, cancelable);
		}
		
		public function get sampleBufferModel():SampleBufferModel 
		{
			return _sampleBufferModel;
		}
		
		public function get samplesWritten():int 
		{
			return _samplesWritten;
		}
		
		public function get samplesTotal():int 
		{
			return _samplesTotal;
		}
		
		public function get secondsWritten():int 
		{
			return _secondsWritten;
		}
		
		public function get secondsTotal():int 
		{
			return _secondsTotal;
		}
	}
}
