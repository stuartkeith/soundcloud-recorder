package com.stuartkeith.soundcloud.recorder.command 
{
	import com.stuartkeith.soundcloud.recorder.vo.SoundCloudConfigurationVO;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
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
			navigateToURL(new URLRequest(soundCloudConfigurationVO.authorisationURL), "_top");
		}
	}
}
