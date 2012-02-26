package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.SoundProgressEvent;
	import com.stuartkeith.soundcloud.recorder.model.RecordingModel;
	import org.robotlegs.mvcs.Command;
	
	public class StoreRecordingCommand extends Command 
	{
		[Inject] public var soundProgressEvent:SoundProgressEvent;
		[Inject] public var recordingModel:RecordingModel;
		
		override public function execute():void 
		{
			recordingModel.recordedSampleBufferModel = soundProgressEvent.sampleBufferModel;
		}
	}
}
