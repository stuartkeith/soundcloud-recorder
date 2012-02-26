package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Component;
	import com.bit101.components.Style;
	import flash.display.Bitmap;
	import flash.display.Shape;
	
	public class MicrophoneActivityView extends Component 
	{
		[Embed(@source="asset/microphoneIcon.png")]
		protected static const MicrophoneIcon:Class;
		
		// this is the value the meter drops by if the requested value
		// is lower than the current value.
		protected static const METER_VELOCITY:Number = 0.037;
		
		protected var backgroundShape:Shape;
		// the activityShape's scaleY attribute is manipulated
		// to show the current value.
		protected var activityShape:Shape;
		protected var microphoneIcon:Bitmap;
		
		// value as shown on the meter.
		protected var _value:Number = 0;
		
		public function MicrophoneActivityView()
		{
			super();
		}
		
		override protected function addChildren():void 
		{
			super.addChildren();
			
			backgroundShape = new Shape();
			activityShape = new Shape();
			microphoneIcon = new MicrophoneIcon();
			
			addChild(backgroundShape);
			addChild(activityShape);
			addChild(microphoneIcon);
		}
		
		public function set value($value:Number):void 
		{
			// if the new value is higher than the current value,
			// update the meter straight away, so peaks in the audio
			// are shown.
			if ($value > _value)
			{
				_value = $value;
			}
			// if the new value is lower, we don't want to
			// have the meter immediately jump to the lower value,
			// we want to have it smoothly drop down.
			// otherwise peaks in the audio will disappear quickly and
			// we won't really be able to see them.
			else if ($value < _value)
			{
				var valueDifference:Number = _value - $value;
				
				if (valueDifference < METER_VELOCITY)
					_value = $value;
				else
					_value -= METER_VELOCITY;
			}
			
			// as the activityShape is placed at the bottom of the component,
			// the scaleY value must be a negative one, so it is scaled
			// upwards.
			activityShape.scaleY = -_value;
		}
		
		override public function draw():void 
		{
			super.draw();
			
			updateShape(backgroundShape, Style.BACKGROUND, width, height);
			updateShape(activityShape, Style.PROGRESS_BAR, width, height);
			
			// position the foreground at the base of the component.
			activityShape.y = height;
			activityShape.scaleY = 0;
			
			// centre the icon.
			microphoneIcon.x = (width / 2) - (microphoneIcon.width / 2);
			microphoneIcon.y = height - microphoneIcon.height - microphoneIcon.x;
		}
		
		protected function updateShape(shape:Shape, color:uint, width:Number, height:Number):void 
		{
			shape.graphics.clear();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
		}
	}
}
