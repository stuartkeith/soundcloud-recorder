package com.stuartkeith.soundcloud.recorder.service 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class MicrophoneServiceEvent extends Event 
	{
		public static const RECORDING_COMPLETE:String = "recordingComplete";
		
		protected var _soundBuffer:ByteArray;
		
		public function MicrophoneServiceEvent(type:String, $soundBuffer:ByteArray,
				bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_soundBuffer = $soundBuffer;
		}
		
		public function get soundBuffer():ByteArray 
		{
			return _soundBuffer;
		}
	}
}
