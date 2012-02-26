package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.model.RecordingModel;
	import com.stuartkeith.soundcloud.recorder.service.SoundOutputService;
	import org.robotlegs.mvcs.Command;
	
	public class BeginPlayingCommand extends Command 
	{
		[Inject] public var recordingModel:RecordingModel;
		[Inject] public var soundOutputService:SoundOutputService;
		
		override public function execute():void 
		{
			soundOutputService.startPlaying(recordingModel.recordedSampleBufferModel);
		}
	}
}
