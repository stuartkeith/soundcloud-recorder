package com.stuartkeith.soundcloud.recorder.vo 
{
	public class SoundCloudConfigurationVO 
	{
		public var accessToken:String;
		public var authorisationURL:String;
		public var clientID:String;
		// the maximum number of seconds the service will record for until it
		// automatically stops recording.
		public var maxRecordingTimeSeconds:int;
		public var redirectURI:String;
		public var trackURL:String;
		
		public function SoundCloudConfigurationVO(parameters:Object)
		{
			clientID = parameters.soundCloudClientID;
			maxRecordingTimeSeconds = parameters.maxRecordingTimeSeconds || 60;
			redirectURI = parameters.soundCloudRedirectURI;
			trackURL = parameters.soundCloudTrackURL;
			
			var URLTemplate:String = parameters.soundCloudAuthorisationURLTemplate;
			
			authorisationURL = URLTemplate.replace("$CLIENT_ID$", clientID).replace("$REDIRECT_URI$", redirectURI);
		}
	}
}
