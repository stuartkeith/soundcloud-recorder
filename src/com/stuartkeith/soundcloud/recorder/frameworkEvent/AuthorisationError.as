package com.stuartkeith.soundcloud.recorder.frameworkEvent 
{
	import flash.events.Event;
	
	public class AuthorisationError extends Event 
	{
		public static const AUTHORISATION_ERROR:String = "authorisationError";
		
		protected var _error:String;
		protected var _errorDescription:String;
		
		public function AuthorisationError(type:String, $error:String, $errorDescription:String, bubbles:Boolean = false,
				cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			_error = $error;
			_errorDescription = $errorDescription;
		}
		
		override public function clone():Event 
		{
			return new AuthorisationError(type, _error, _errorDescription, bubbles, cancelable);
		}
		
		public function get error():String 
		{
			return _error;
		}
		
		public function get errorDescription():String 
		{
			return _errorDescription;
		}
	}
}
