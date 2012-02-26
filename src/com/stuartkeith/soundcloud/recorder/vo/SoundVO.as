package com.stuartkeith.soundcloud.recorder.vo 
{
	public class SoundVO 
	{
		public var title:String = "Untitled";
		public var tags:String = "";
		// should be "public" or "private".
		public var sharing:String = "private";
		public var permalinkURL:String = "";
		
		protected var _isPublic:Boolean;
		
		public function get isPublic():Boolean 
		{
			return _isPublic;
		}
		
		public function set isPublic(value:Boolean):void 
		{
			_isPublic = value;
			
			sharing = value ? "public" : "private";
		}
	}
}
