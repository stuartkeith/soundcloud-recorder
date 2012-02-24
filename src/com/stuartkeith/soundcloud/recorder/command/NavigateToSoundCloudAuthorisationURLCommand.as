package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.NavigateToURLEvent;
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
	import org.robotlegs.mvcs.Command;
	
	public class NavigateToSoundCloudAuthorisationURLCommand extends Command 
	{
		/*
		 * Uses the authorisationURL stored in the SoundCloudConfigurationVO
		 * to navigate to SoundCloud's authorisation URL.
		 */
		
		[Inject] public var soundCloudConfigurationVO:SoundCloudConfigurationVO;
		
		override public function execute():void 
		{
			dispatch(new NavigateToURLEvent(NavigateToURLEvent.NAVIGATE_TO_URL,
					soundCloudConfigurationVO.authorisationURL, "_top"));
		}
	}
}
