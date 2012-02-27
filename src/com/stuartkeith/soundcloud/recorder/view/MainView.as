package com.stuartkeith.soundcloud.recorder.view 
{
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MainView extends Sprite 
	{
		protected var childView:Sprite;
		
		public function MainView() 
		{
			super();
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(event:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.RESIZE, centreChildView, false, 0, true);
		}
		
		protected function changeChildView(view:Sprite):void
		{
			if (childView)
				removeChild(childView);
			
			childView = view;
			
			if (childView)
			{
				addChild(childView);
				
				centreChildView();
			}
		}
		
		protected function centreChildView(event:Event=null):void 
		{
			if (childView)
			{
				childView.x = (stage.stageWidth / 2) - (childView.width / 2);
				childView.y = (stage.stageHeight / 2) - (childView.height / 2);
			}
		}
		
		public function showAuthorisationView(errorDescription:String):void
		{
			changeChildView(new AuthorisationView(errorDescription));
		}
		
		public function showConnectingToSoundCloudView():void
		{
			changeChildView(new SpinnerView("Connecting to SoundCloud..."));
		}
		
		public function showRecordingView():void
		{
			changeChildView(new RecordView());
		}
		
		public function showUploadSoundView():void
		{
			changeChildView(new UploadSoundView());
		}
		
		public function showUploadingSoundView(soundVO:SoundVO):void
		{
			changeChildView(new SpinnerView("Uploading '" + soundVO.title + "' to SoundCloud..."));
		}
		
		public function showUploadedSoundView(soundVO:SoundVO):void
		{
			changeChildView(new UploadedSoundView(soundVO));
		}
	}
}
