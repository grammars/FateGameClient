package com.anstu.jload
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	
	public class JLoaderDemo extends Sprite
	{
		public var logHook:Function;
		
		private var jl:JLoader = new JLoader();
		
		public function JLoaderDemo()
		{
			super();
		}
		
		public function run():void
		{
			jl.progressInterval = 1000;
			jl.addEventListener(JLoadEvent.FINISH, __finish);
			jl.addEventListener(JLoadEvent.PROGRESS, __progress);
			
			const DEFAULT_MASK:int = M_Progress | M_HttpStatus;
			
			//const BASE_URL:String = "http://arttecme.freevar.com/load/";
			//const BASE_URL:String = "http://121.199.1.180/load/";
			//const BASE_URL:String = "http://192.168.1.28/load/";
			//const BASE_URL:String = "http://28.com/load/";
			const BASE_URL:String = "";
			
			jl.add(makeTask("#djs.swf#", JLoadTask.TYPE_DISPLAY_CONTENT, BASE_URL+"djs.swf", false, 9, DEFAULT_MASK));
			jl.add(makeTask("#config.xml#", JLoadTask.TYPE_DATA_XML, BASE_URL+"config.xml", false, 7, DEFAULT_MASK));
			jl.add(makeTask("#page.php#", JLoadTask.TYPE_DATA_TEXT, BASE_URL+"page.php", false, 5, DEFAULT_MASK));
			jl.add(makeTask("#1003.map#", JLoadTask.TYPE_DATA_BINARY, BASE_URL+"1003.map", false, 5, DEFAULT_MASK));
			jl.add(makeTask("#wrong#", JLoadTask.TYPE_DISPLAY_CONTENT, BASE_URL+"no.exist", false, -1, DEFAULT_MASK));
			jl.add(makeTask("#class#", JLoadTask.TYPE_CLASS_DOMAIN, BASE_URL+"class.swf", false, -2, DEFAULT_MASK));
			jl.add(makeTask("#sound#", JLoadTask.TYPE_SOUND, BASE_URL+"ainy.mp3", false, 1, DEFAULT_MASK));
			jl.add(makeTask("#flv#", JLoadTask.TYPE_VIDEO, BASE_URL+"intro.flv", false, 10, DEFAULT_MASK));
			
			//jl.remove(pageTask);
			//jl.remove(pageTask.uuid);
			
			//jl.printState();
			jl.start();
			//jl.printState();
		}
		
		private static const M_Start:int = 1;
		private static const M_Progress:int = 2;
		private static const M_Complete:int = 4;
		private static const M_Init:int = 8;
		private static const M_Open:int = 16;
		private static const M_HttpStatus:int = 32;
		private static const M_IOError:int = 64;
		private static const M_SecurityError:int = 128;
		private static const M_Fail:int = 256;
		private static const M_VideoMetaData:int = 512;
		private function makeTask(name:String, type:String, url:String, inSameDomain:Boolean=true, priority:int=0, mask:int=0):JLoadTask
		{
			var t:JLoadTask = new JLoadTask(type, url, inSameDomain, priority);
			t.name = name;
			if((mask&M_Start) != M_Start) t.onStart = onStart;
			if((mask&M_Progress) != M_Progress) t.onProgress = onProgress;
			if((mask&M_Complete) != M_Complete) t.onComplete = onComplete;
			if((mask&M_Init) != M_Init) t.onInit = onInit;
			if((mask&M_Open) != M_Open) t.onOpen = onOpen;
			if((mask&M_HttpStatus) != M_HttpStatus) t.onHttpStatus = onHttpStatus;
			if((mask&M_IOError) != M_IOError) t.onIOError = onIOError;
			if((mask&M_SecurityError) != M_SecurityError) t.onSecurityError = onSecurityError;
			if((mask&M_Fail) != M_Fail) t.onFail = onFail;
			if((mask&M_VideoMetaData) != M_VideoMetaData) t.onVideoMetaData = onVideoMetaData;
			return t;
		}
		
		private function __finish(e:JLoadEvent):void
		{
			log("--------------结束了");
			jl.printState();
			jl = null;
		}
		
		private function __progress(e:JLoadEvent):void
		{
			log("下载速度", e.speed.toFixed(2), "KB/s");
		}
		
		private function onStart(t:JLoadTask):void
		{
			log("onStart t.uuid=" + t.uuid + " t.url=" + t.url);
		}
		
		private function onProgress(t:JLoadTask):void
		{
			log("onProgress ", t);
		}
		
		private function onComplete(t:JLoadTask):void
		{
			log("onComplete t.uuid=" + t.uuid + " t.url=" + t.url);
			//if(t.result.ge)
			if(t.type == JLoadTask.TYPE_CLASS_DOMAIN)
			{
				var PIC_CLS:Class = t.result.getDomain().getDefinition("pic.jpeg") as Class;
				var bmd:BitmapData = new PIC_CLS(0,0);
				var pic:Bitmap = new Bitmap(bmd);
				pic.scaleX = pic.scaleY = 0.3;
				pic.alpha = 0.5;
				this.addChild(pic);
				//
				var InsideCls:Class = t.result.getDomain().getDefinition("aspac.InsideCls") as Class;
				new InsideCls();
			}
			else if(t.type == JLoadTask.TYPE_DATA_BINARY)
			{
				var bytes:ByteArray = t.result.getBinary();
				bytes.readByte();
				bytes.readByte();
				bytes.readByte();
				log("this is BINARY:", t.result.getBinary().readUnsignedByte().toString(16));
			}
			else if(t.type == JLoadTask.TYPE_DATA_TEXT)
			{
				log("this is text:", t.result.getText());
			}
			else if(t.type == JLoadTask.TYPE_DATA_VARIABLES)
			{
				log("this is urlval:", t.result.getURLVar().toString());
			}
			else if(t.type == JLoadTask.TYPE_DATA_XML)
			{
				log("this is XML:", t.result.getXML());
			}
			else if(t.type == JLoadTask.TYPE_DISPLAY_CONTENT)
			{
				this.addChild(DisplayObject(t.result.value));
			}
			else if(t.type == JLoadTask.TYPE_SOUND)
			{
				
			}
			else if(t.type == JLoadTask.TYPE_VIDEO)
			{
				
			}
		}
		
		private function onInit(t:JLoadTask):void
		{
			log("onInit t.uuid=" + t.uuid + " t.url=" + t.url);
		}
		
		private function onOpen(t:JLoadTask):void
		{
			log("onOpen t.uuid=" + t.uuid + " t.url=" + t.url);
			if(t.type == JLoadTask.TYPE_SOUND)
			{
				t.result.getSound().play();
			}
			else if(t.type == JLoadTask.TYPE_VIDEO)
			{
				
			}
		}
		
		private function onHttpStatus(t:JLoadTask):void
		{
			log("onHttpStatus t.uuid=" + t.uuid + " t.url=" + t.url + " httpStatus=" + t.status.httpStatus);
		}
		
		private function onIOError(t:JLoadTask):void
		{
			log("onIOError t.uuid=" + t.uuid + " t.url=" + t.url);
		}
		
		private function onSecurityError(t:JLoadTask):void
		{
			log("onSecurityError t.uuid=" + t.uuid + " t.url=" + t.url);
		}
		
		private function onFail(t:JLoadTask):void
		{
			log("onFail t.uuid=" + t.uuid + " t.url=" + t.url);
		}
		
		private function onVideoMetaData(t:JLoadTask):void
		{
			log("onVideoMetaData " + t.info.videoMetaData);
			var v:Video = new Video(400, 300);
			v.x = 300;
			v.attachNetStream(t.result.getStream());
			var ns:NetStream = t.result.getStream();
			ns.resume();
			this.addChild(v);
		}
		
		private function log(...args):void
		{
			trace("[demo]", args);
			if(logHook != null)
			{
				logHook(args);
			}
		}
		
		
	}
}