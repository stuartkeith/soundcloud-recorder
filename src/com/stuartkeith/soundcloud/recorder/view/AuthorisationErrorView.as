package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.DisplayObjectContainer;
	
	public class AuthorisationErrorView extends AuthorisationView 
	{
		protected var errorDescription:String;
		
		public function AuthorisationErrorView($errorDescription:String) 
		{
			errorDescription = $errorDescription;
			
			super();
		}
		
		override protected function getTitleString():String 
		{
			return "Authorisation Error";
		}
		
		override protected function getLabelString():String 
		{
			return "There was a problem with your authorisation.\n\n" +
					"SoundCloud said, '" + errorDescription + "'\n\n" +
					"Try again?";
		}
	}
}
