package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class SimpleToggleButton extends SimpleButton 
	{
		protected var normalState:DisplayObject;
		protected var toggledState:DisplayObject;
		protected var disabledState:DisplayObject;
		protected var _isToggled:Boolean;
		
		public function SimpleToggleButton(normalState:DisplayObject = null, toggledState:DisplayObject = null,
				disabledState:DisplayObject=null)
		{
			super();
			
			this.normalState = normalState;
			this.toggledState = toggledState;
			this.disabledState = disabledState;
			
			updateState();
		}
		
		override public function set enabled(value:Boolean):void 
		{
			super.enabled = value;
			
			updateState();
		}
		
		public function get isToggled():Boolean 
		{
			return _isToggled;
		}
		
		public function set isToggled(value:Boolean):void 
		{
			_isToggled = value;
			
			updateState();
		}
		
		protected function updateState():void
		{
			var state:DisplayObject;
			
			if (!enabled)
				state = disabledState;
			else
				state = _isToggled ? toggledState : normalState;
				
			if (upState != state)
				upState = downState = overState = hitTestState = state;
		}
	}
}
