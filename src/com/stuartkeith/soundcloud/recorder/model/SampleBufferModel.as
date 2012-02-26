package com.stuartkeith.soundcloud.recorder.model 
{
	import com.stuartkeith.soundcloud.recorder.vo.SampleVO;
	
	// SampleBufferModel - a linked list.
	public class SampleBufferModel 
	{
		public var sampleVOHead:SampleVO;
		public var totalSamples:uint;
	}
}
