package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.Sprite;
	
	public class MainView extends Sprite 
	{
		protected var childView:Sprite;
		
		public function MainView() 
		{
			super();
		}
		
		protected function changeChildView(view:Sprite):void
		{
			if (childView)
				removeChild(childView);
			
			childView = view;
			
			if (childView)
			{
				addChild(childView);
				
				childView.x = (stage.stageWidth / 2) - (childView.width / 2);
				childView.y = (stage.stageHeight / 2 ) - (childView.height / 2);
			}
		}
		
		public function showAuthorisationError(error:String, errorDescription:String):void
		{
			changeChildView(new AuthorisationErrorView(errorDescription));
		}
		
		public function showAuthorisationView():void
		{
			changeChildView(new AuthorisationView());
		}
		
		public function showRecordingView():void
		{
			changeChildView(new RecordView());
		}
		
		public function showUploadSoundView():void
		{
			changeChildView(new UploadSoundView());
		}
		
		public function showUploadingSoundView():void
		{
			changeChildView(new UploadingSoundView());
		}
		
		public function showUploadedSoundView(title:String, permalinkURL:String):void
		{
			changeChildView(new UploadedSoundView(title, permalinkURL));
		}
	}
}
