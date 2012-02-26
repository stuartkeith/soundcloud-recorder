package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.service.MicrophoneService;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
	import org.robotlegs.mvcs.Command;
	
	public class BeginRecordingCommand extends Command 
	{
		[Inject] public var microphoneService:MicrophoneService;
		[Inject] public var soundCloudConfigurationVO:SoundCloudConfigurationVO;
		
		override public function execute():void 
		{
			microphoneService.beginRecording(soundCloudConfigurationVO.maxRecordingTimeSeconds);
		}
	}
}
