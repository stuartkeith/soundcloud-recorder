package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.AuthorisationErrorEvent;
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.FrameworkEvent;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
	import flash.events.Event;
	import org.robotlegs.mvcs.Command;
	
	public class ProcessSoundCloudConfigurationVOCommand extends Command 
	{
		[Inject] public var soundCloudConfigurationVO:SoundCloudConfigurationVO;
		
		override public function execute():void 
		{
			if (soundCloudConfigurationVO.lastError)
			{
				dispatch(new AuthorisationErrorEvent(AuthorisationErrorEvent.AUTHORISATION_ERROR,
						"Error", soundCloudConfigurationVO.lastError));
			}
			else if (soundCloudConfigurationVO.accessToken)
			{
				dispatch(new Event(FrameworkEvent.AUTHORISATION_SUCCESSFUL));
			}
		}
	}
}
