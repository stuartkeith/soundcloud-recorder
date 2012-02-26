package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadEvent;
	import com.stuartkeith.soundcloud.recorder.vo.SoundVO;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	import ru.inspirit.net.MultipartURLLoader;
	
	public class SoundCloudService extends Actor 
	{
		protected var multipartURLLoader:MultipartURLLoader;
		// the sound currently being uploaded. null if uploading
		// not taking place.
		protected var soundVO:SoundVO;
		
		public function SoundCloudService() 
		{
			super();
			
			multipartURLLoader = new MultipartURLLoader();
			
			multipartURLLoader.addEventListener(Event.COMPLETE, onComplete, false, 0, false);
			multipartURLLoader.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, false);
			multipartURLLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, false);
			multipartURLLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus, false, 0, false);
			multipartURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, false);
		}
		
		public function uploadSound(waveBuffer:ByteArray, accessToken:String, $soundVO:SoundVO):void
		{
			if (!soundVO)
			{
				soundVO = $soundVO;
				
				// add access token and track options.
				// track[title] is mandatory.
				multipartURLLoader.addVariable("oauth_token", accessToken);
				multipartURLLoader.addVariable("track[title]", soundVO.title);
				multipartURLLoader.addVariable("track[sharing]", soundVO.sharing);
				
				if (soundVO.tags)
					multipartURLLoader.addVariable("track[tag_list]", soundVO.tags);
				
				// add the file with a dummy filename.
				multipartURLLoader.addFile(waveBuffer, "filename.wav",  "track[asset_data]", "audio/wav");
				
				try
				{
					multipartURLLoader.load("https://api.soundcloud.com/tracks.xml");
				}
				catch (error:Error)
				{
					dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR, soundVO));
				}
				
				dispatch(new UploadEvent(UploadEvent.UPLOADING, soundVO));
			}
		}
		
		protected function cleanUp():void
		{
			multipartURLLoader.clearFiles();
			multipartURLLoader.clearVariables();
			
			soundVO = null;
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void 
		{
			dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR, soundVO));
			
			cleanUp();
		}
		
		protected function onHTTPStatus(event:HTTPStatusEvent):void 
		{
			
		}
		
		protected function onIOError(event:IOErrorEvent):void 
		{
			dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR, soundVO));
			
			cleanUp();
		}
		
		protected function onProgress(event:ProgressEvent):void 
		{
			
		}
		
		protected function onComplete(event:Event):void 
		{
			var response:XML = new XML(multipartURLLoader.data);
			
			soundVO.permalinkURL = response["permalink-url"];
			soundVO.sharing = response["sharing"];
			soundVO.tags = response["tag-list"];
			soundVO.title = response["title"];
			
			dispatch(new UploadEvent(UploadEvent.UPLOADED, soundVO));
			
			cleanUp();
		}
	}
}
