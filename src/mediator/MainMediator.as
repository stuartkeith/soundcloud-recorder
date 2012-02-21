package mediator 
{
	import com.stuartkeith.soundcloud.recorder.MainView;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator 
	{
		[Inject] public var mainView:MainView;
		
		override public function onRegister():void 
		{
			
		}
	}
}
