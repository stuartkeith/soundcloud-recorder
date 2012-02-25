package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class SoundProgressEvent extends Event 
	{
		public static const RECORD_START:String = "recordStart";
		public static const RECORD_PROGRESS:String = "recordProgress";
		public static const RECORD_COMPLETE:String = "recordComplete";
		
		public static const PLAYBACK_START:String = "playbackStart";
		public static const PLAYBACK_PROGRESS:String = "playbackProgress";
		public static const PLAYBACK_COMPLETE:String = "playbackComplete";
		
		protected var _soundBuffer:ByteArray;
		protected var _samplesWritten:int;
		protected var _samplesTotal:int;
		protected var _secondsWritten:int;
		protected var _secondsTotal:int;
		
		public function SoundProgressEvent(type:String, $soundBuffer:ByteArray, $bytesTotal:int=-1,
				bubbles:Boolean = false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundBuffer = $soundBuffer;
			
			// there are 4 bytes per sample, so divide by 4.
			_samplesWritten = $soundBuffer.position / 4;
			
			// if bytesTotal is not specified, use the number
			// of bytes in the soundBuffer instead.
			if ($bytesTotal < 0)
				_samplesTotal = $soundBuffer.length / 4;
			else
				_samplesTotal = $bytesTotal / 4;
			
			// there are 44100 samples per second, so divide
			// by 44100.
			_secondsWritten = Math.floor(_samplesWritten / 44100);
			_secondsTotal = Math.floor(_samplesTotal / 44100);
		}
		
		override public function clone():Event 
		{
			return new SoundProgressEvent(type, _soundBuffer, _samplesTotal, bubbles, cancelable);
		}
		
		public function get soundBuffer():ByteArray 
		{
			return _soundBuffer;
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
