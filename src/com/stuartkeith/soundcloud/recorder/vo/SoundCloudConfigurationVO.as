package com.stuartkeith.soundcloud.recorder.vo 
{
	public class SoundCloudConfigurationVO 
	{
		public var accessToken:String;
		public var authorisationURL:String;
		public var clientID:String;
		public var redirectURI:String;
		
		public function SoundCloudConfigurationVO(parameters:Object)
		{
			clientID = parameters.soundCloudClientID;
			redirectURI = parameters.soundCloudRedirectURI;
			
			var URLTemplate:String = parameters.soundCloudAuthorisationURLTemplate;
			
			authorisationURL = URLTemplate.replace("$CLIENT_ID$", clientID).replace("$REDIRECT_URI$", redirectURI);
		}
	}
}
