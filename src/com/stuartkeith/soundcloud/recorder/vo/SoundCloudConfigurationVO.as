package com.stuartkeith.soundcloud.recorder.vo 
{
	public class SoundCloudConfigurationVO 
	{
		// the access token passed via the query string.
		public var accessToken:String;
		// SoundCloud's authorisation URL
		public var authorisationURL:String;
		// the app's client ID.
		public var clientID:String;
		// the maximimum length of a recorded sound.
		public var maxRecordingTimeSeconds:int;
		// SoundCloud redirects back to this URI post-authorisation.
		public var redirectURI:String;
		// the URL to which the app should upload recorded sounds.
		public var trackURL:String;
		
		public function SoundCloudConfigurationVO(parameters:Object)
		{
			clientID = parameters.soundCloudClientID;
			maxRecordingTimeSeconds = parameters.maxRecordingTimeSeconds || 60;
			redirectURI = parameters.soundCloudRedirectURI;
			trackURL = parameters.soundCloudTrackURL;
			
			// render the authorisation template.
			var urlTemplate:String = parameters.soundCloudAuthorisationURLTemplate;
			
			authorisationURL = urlTemplate.replace("$CLIENT_ID$", clientID).replace("$REDIRECT_URI$", redirectURI);
		}
	}
}
