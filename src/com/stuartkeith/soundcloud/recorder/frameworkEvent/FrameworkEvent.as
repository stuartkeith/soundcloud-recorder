package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	public class FrameworkEvent 
	{
		/*
		 * These are events that are not attached to any custom event class.
		 * Use flash.event.Event.
		 */
		
		public static const APPLICATION_READY:String = "applicationReady";
		public static const AUTHORISATION_REQUIRED:String = "authorisationRequired";
		public static const AUTHORISATION_SUCCESSFUL:String = "authorisationSuccessful";
		public static const CONNECT_TO_SOUNDCLOUD:String = "connectToSoundCloud";
		public static const BEGIN_RECORDING:String = "beginRecording";
	}
}
