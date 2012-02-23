package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.service.SoundOutputService;
	import org.robotlegs.mvcs.Command;
	
	public class StopPlayingCommand extends Command 
	{
		[Inject] public var soundOutputService:SoundOutputService;
		
		override public function execute():void 
		{
			soundOutputService.stopPlaying();
		}
	}
}
