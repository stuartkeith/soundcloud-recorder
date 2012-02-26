package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Component;
	import com.bit101.components.Style;
	import flash.display.Sprite;
	
	public class TimeView extends Component 
	{
		// components:
		protected var currentTimeLabel:LabelAligned;
		protected var startTimeLabel:LabelAligned;
		protected var finishTimeLabel:LabelAligned;
		protected var timeTotalSprite:Sprite;
		protected var timeElapsedSprite:Sprite;
		
		// values:
		protected var _currentTime:int;
		protected var _startTime:int;
		protected var _finishTime:int;
		protected var _showCurrentTime:Boolean;
		
		// flags:
		protected var sizeIsDirty:Boolean = true;
		protected var currentTimeIsDirty:Boolean = true;
		protected var startTimeIsDirty:Boolean = true;
		protected var finishTimeIsDirty:Boolean = true;
		
		public function TimeView() 
		{
			super();
			
			// create components.
			currentTimeLabel = new LabelAligned();
			startTimeLabel = new LabelAligned();
			finishTimeLabel = new LabelAligned();
			timeTotalSprite = new Sprite();
			timeElapsedSprite = new Sprite();
			
			addChild(startTimeLabel);
			addChild(timeTotalSprite);
			addChild(timeElapsedSprite);
			addChild(finishTimeLabel);
			addChild(currentTimeLabel);
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			
			sizeIsDirty = true;
			
			invalidate();
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			
			sizeIsDirty = true;
			
			invalidate();
		}
		
		override public function setSize(w:Number, h:Number):void 
		{
			super.setSize(w, h);
			
			sizeIsDirty = true;
			
			invalidate();
		}
		
		public function set currentTime(value:int):void
		{
			if (value != _currentTime)
			{
				_currentTime = value;
				
				currentTimeIsDirty = true;
				
				invalidate();
			}
		}
		
		public function set startTime(value:int):void
		{
			if (value != _startTime)
			{
				_startTime = value;
				
				startTimeIsDirty = true;
				
				invalidate();
			}
		}
		
		public function set finishTime(value:int):void
		{
			if (value != _finishTime)
			{
				_finishTime = value;
				
				finishTimeIsDirty = true;
				
				invalidate();
			}
		}
		
		public function set showCurrentTime(value:Boolean):void 
		{
			if (value != _showCurrentTime)
			{
				_showCurrentTime = value;
				
				invalidate();
			}
		}
		
		protected function secondsToLabel(seconds:int):String
		{
			// casting to int always rounds down.
			var minutes:int = seconds / 60;
			// calculate remaining seconds.
			var remainingSeconds:int = seconds % 60;
			
			// if under ten remaining seconds, pad the string with a zero (so 9 == "09").
			var remainingSecondsString:String = (remainingSeconds < 10 ? "0" : "") + remainingSeconds.toString();
			
			return minutes.toString() + ":" + remainingSecondsString;
		}
		
		protected function drawSprites(width:Number, height:Number):void
		{
			drawSprite(timeElapsedSprite, Style.PROGRESS_BAR, width, height);
			drawSprite(timeTotalSprite, Style.BACKGROUND, width, height);
		}
		
		protected function drawSprite(sprite:Sprite, color:uint, width:Number, height:Number):void 
		{
			sprite.graphics.clear();
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0, 0, width, height);
			sprite.graphics.endFill();
		}
		
		override public function draw():void 
		{
			if (sizeIsDirty)
			{
				sizeIsDirty = false;
				
				var labelWidth:int = width / 10;
				var heightHalved:Number = height / 2;
				
				currentTimeLabel.width = startTimeLabel.width = finishTimeLabel.width = labelWidth;
				currentTimeLabel.height = startTimeLabel.height = finishTimeLabel.height = heightHalved;
				startTimeLabel.y = heightHalved;
				finishTimeLabel.y = startTimeLabel.y;
				
				finishTimeLabel.x = width - labelWidth;
				
				timeTotalSprite.x = timeElapsedSprite.x = labelWidth;
				timeTotalSprite.y = heightHalved;
				timeElapsedSprite.y = timeTotalSprite.y;
				
				drawSprites(width - (labelWidth * 2), heightHalved);
			}
			
			if (startTimeIsDirty)
			{
				startTimeIsDirty = false;
				
				startTimeLabel.text = secondsToLabel(_startTime);
			}
			
			if (finishTimeIsDirty)
			{
				finishTimeIsDirty = false;
				
				finishTimeLabel.text = secondsToLabel(_finishTime);
			}
			
			currentTimeLabel.visible = _showCurrentTime;
			
			if (currentTimeIsDirty)
			{
				currentTimeIsDirty = false;
				
				// get the ratio of the current_time within the time range.
				// so with a range of 50 seconds to 150 seconds, current time == 100 seconds:
				// ratio would be 0.5.
				
				var currentTimeAsRatio:Number = (_currentTime - _startTime) / (_finishTime - _startTime);
				
				timeElapsedSprite.scaleX = currentTimeAsRatio;
				
				currentTimeLabel.text = secondsToLabel(_currentTime);
				
				// position the currentTimeLabel, centred above the current time.
				currentTimeLabel.x = timeTotalSprite.x + Math.ceil(timeTotalSprite.width * currentTimeAsRatio) - (currentTimeLabel.width / 2);
			}
			
			super.draw();
		}
	}
}
