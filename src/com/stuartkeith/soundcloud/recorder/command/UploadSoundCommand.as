package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadRequestEvent;
	import org.robotlegs.mvcs.Command;
	
	public class UploadSoundCommand extends Command 
	{
		[Inject] public var uploadRequestEvent:UploadRequestEvent;
		
		override public function execute():void 
		{
			
		}
	}
}
