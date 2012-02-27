package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	public class FrameworkEvent 
	{
		/*
		 * These are events that are not attached to any custom event class.
		 * Use with flash.event.Event.
		 */
		
		public static const APPLICATION_READY:String = "applicationReady";
		public static const AUTHORISATION_SUCCESSFUL:String = "authorisationSuccessful";
		public static const CONNECT_TO_SOUNDCLOUD:String = "connectToSoundCloud";
		public static const BEGIN_PLAYING:String = "beginPlaying";
		public static const STOP_PLAYING:String = "stopPlaying";
		public static const BEGIN_RECORDING:String = "beginRecording";
		public static const STOP_RECORDING:String = "stopRecording";
		public static const BEGIN_UPLOAD:String = "beginUpload";
	}
}
