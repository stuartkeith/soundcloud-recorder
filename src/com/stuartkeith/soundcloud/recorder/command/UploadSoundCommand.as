package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadRequestEvent;
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
		[Inject] public var uploadRequestEvent:UploadRequestEvent;
		
		override public function execute():void 
		{
			var sharing:String = uploadRequestEvent.soundIsPublic ? "public" : "private";
			
			// convert the recordingBuffer to a format SoundCloud will understand: a 32 bit mono WAVE file.
			var waveBuffer:ByteArray = WaveFormat.writeWaveFormat(1, 44100, recordingModel.recordingBuffer);
			
			soundCloudService.uploadSound(waveBuffer, soundCloudConfigurationVO.accessToken,
					uploadRequestEvent.soundTitle, sharing, uploadRequestEvent.soundTags);
		}
	}
}
