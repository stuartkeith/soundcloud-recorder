package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneService;
	import org.robotlegs.mvcs.Command;
	
	public class StopRecordingCommand extends Command 
	{
		[Inject] public var microphoneService:MicrophoneService;
		
		override public function execute():void 
		{
			microphoneService.stopRecording();
		}
	}
}
