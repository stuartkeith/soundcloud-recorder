package com.stuartkeith.soundcloud.recorder.service 
{
	import com.stuartkeith.soundcloud.recorder.frameworkEvent.UploadEvent;
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
		protected var isLoading:Boolean;
		
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
		
		public function uploadSound(waveBuffer:ByteArray, accessToken:String, title:String, sharing:String,
				tags:String=null):void
		{
			if (!isLoading)
			{
				isLoading = true;
				
				// add access token and track options.
				// track[title] is mandatory.
				multipartURLLoader.addVariable("oauth_token", accessToken);
				multipartURLLoader.addVariable("track[title]", title);
				multipartURLLoader.addVariable("track[sharing]", sharing);
				
				if (tags)
					multipartURLLoader.addVariable("track[tag_list]", tags);
				
				// add the file with a dummy filename.
				multipartURLLoader.addFile(waveBuffer, "filename.wav",  "track[asset_data]", "audio/wav");
				
				try
				{
					multipartURLLoader.load("https://api.soundcloud.com/tracks.xml");
				}
				catch (error:Error)
				{
					dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR));
				}
				
				dispatch(new UploadEvent(UploadEvent.UPLOADING));
			}
		}
		
		protected function cleanUp():void
		{
			multipartURLLoader.clearFiles();
			multipartURLLoader.clearVariables();
			
			isLoading = false;
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void 
		{
			cleanUp();
			
			dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR));
		}
		
		protected function onHTTPStatus(event:HTTPStatusEvent):void 
		{
			
		}
		
		protected function onIOError(event:IOErrorEvent):void 
		{
			cleanUp();
			
			dispatch(new UploadEvent(UploadEvent.UPLOAD_ERROR));
		}
		
		protected function onProgress(event:ProgressEvent):void 
		{
			
		}
		
		protected function onComplete(event:Event):void 
		{
			cleanUp();
			
			var response:XML = new XML(multipartURLLoader.data);
			
			dispatch(new UploadEvent(UploadEvent.UPLOADED, response));
		}
	}
}
