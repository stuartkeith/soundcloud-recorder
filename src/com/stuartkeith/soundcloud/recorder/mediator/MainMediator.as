package com.stuartkeith.soundcloud.recorder.mediator 
{
	import com.stuartkeith.soundcloud.recorder.view.MainView;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator 
	{
		[Inject] public var mainView:MainView;
		
		override public function onRegister():void 
		{
			
		}
	}
}
