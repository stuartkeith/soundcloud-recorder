package com.stuartkeith.soundcloud.recorder.view 
{
	import flash.display.Sprite;
	
	public class MainView extends Sprite 
	{
		protected var mainView_design:MainView_design;
		
		protected var childView:Sprite;
		
		public function MainView() 
		{
			super();
			
			mainView_design = new MainView_design();
			addChild(mainView_design);
		}
		
		protected function changeChildView(view:Sprite):void
		{
			if (childView)
				mainView_design.removeChild(childView);
			
			childView = view;
			
			if (childView)
			{
				mainView_design.addChild(childView);
				
				childView.x = mainView_design.childPosition.x - (childView.width / 2);
				childView.y = mainView_design.childPosition.y - (childView.height / 2);
			}
		}
		
		public function showAuthorisationError(error:String, errorDescription:String):void
		{
			mainView_design.header.text = "Authorisation Error";
			
			var authorisationView:AuthorisationView = new AuthorisationView();
			authorisationView.textField.text = "There was a problem with your authorisation. " +
					"SoundCloud said, '" + errorDescription + "' Try again?";
			
			changeChildView(authorisationView);
		}
		
		public function showAuthorisationView():void
		{
			mainView_design.header.text = "Authorisation Needed";
			
			var authorisationView:AuthorisationView = new AuthorisationView();
			authorisationView.textField.text = "Before you begin recording, please authorise this application " +
					"with SoundCloud so you can upload your sounds to your SoundCloud account.";
			
			changeChildView(authorisationView);
		}
	}
}
