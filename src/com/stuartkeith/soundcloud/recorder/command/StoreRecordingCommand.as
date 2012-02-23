package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.model.RecordingModel;
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneServiceEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StoreRecordingCommand extends Command 
	{
		[Inject] public var microphoneServiceEvent:MicrophoneServiceEvent;
		[Inject] public var recordingModel:RecordingModel;
		
		override public function execute():void 
		{
			recordingModel.recordingBuffer = microphoneServiceEvent.soundBuffer;
		}
	}
}
