package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadEvent;
	import com.stuartkeith.soundcloud.recorder.model.RecordingModel;
	import com.stuartkeith.soundcloud.recorder.service.SoundCloudService;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
	import com.stuartkeith.utils.WaveFormat;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Command;
	
	public class UploadSoundCommand extends Command 
	{
		[Inject] public var recordingModel:RecordingModel;
		[Inject] public var soundCloudConfigurationVO:SoundCloudConfigurationVO;
		[Inject] public var soundCloudService:SoundCloudService;
		[Inject] public var uploadEvent:UploadEvent;
		
		override public function execute():void 
		{
			// convert the recordingBuffer to a format SoundCloud will understand: a 32 bit mono WAVE file.
			var waveBuffer:ByteArray = WaveFormat.writeWaveFormat(1, 44100, recordingModel.recordedSampleBufferModel);
			
			soundCloudService.uploadSound(soundCloudConfigurationVO.trackURL, waveBuffer,
					soundCloudConfigurationVO.accessToken, uploadEvent.soundVO);
		}
	}
}
