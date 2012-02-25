package com.stuartkeith.soundcloud.recorder.view 
{
	import com.bit101.components.Component;
	import com.bit101.components.Style;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class LabelAligned extends Component 
	{
		protected var _text:String = "";
		protected var textField:TextField;
		
		public function LabelAligned(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0) 
		{
			super(parent, xpos, ypos);
		}
		
		override protected function init():void 
		{
			super.init();
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		override protected function addChildren():void 
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = Style.LABEL_TEXT;
			textFormat.font = Style.fontName;
			textFormat.size = Style.fontSize;
			
			textField = new TextField();
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.defaultTextFormat = textFormat;
			textField.embedFonts = Style.embedFonts;
			textField.mouseEnabled = false;
			textField.selectable = false;
			
			addChild(textField);
			
			draw();
		}
		
		override public function draw():void 
		{
			super.draw();
			
			textField.text = _text;
			
			// always align the textfield in the centre of the component.
			
			textField.x = (width / 2) - Math.round(textField.width / 2);
			
			var gap:Number = textField.height - textField.textHeight;
			
			textField.y = (height / 2) - Math.round((textField.height + gap) / 2) + 1;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			if (_text != value)
			{
				_text = value;
				
				invalidate();
			}
		}
	}
}
