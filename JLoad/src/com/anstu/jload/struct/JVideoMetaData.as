package com.anstu.jload.struct
{
	public class JVideoMetaData
	{
		public var audiocodecid:int;
		public var audiodatarate:Number;
		public var audiosamplerate:Number;
		public var audiosamplesize:Number;
		public var duration:Number;
		public var encoder:String;
		public var filesize:Number;
		public var framerate:Number;
		public var width:Number;
		public var height:Number;
		public var length:Number;
		public var stereo:Number;
		public var videocodecid:int;
		public var videodatarate:Number;
		
		public function JVideoMetaData(param:*=null)
		{
			parse(param);
		}
		
		public function parse(param:*):void
		{
			if(param != null)
			{
				audiocodecid = param["audiocodecid"];
				audiodatarate = param["audiodatarate"];
				audiosamplerate = param["audiosamplerate"];
				audiosamplesize = param["audiosamplesize"];
				duration = param["duration"];
				encoder = param["encoder"];
				filesize = param["filesize"];
				framerate = param["framerate"];
				width = param["width"];
				height = param["height"];
				length = param["length"];
				stereo = param["stereo"];
				videocodecid = param["videocodecid"];
				videodatarate = param["videodatarate"];
			}
		}
		
		public function toString():String
		{
			var echo:String = "[JVideoMetaData]";
			echo += "audiocodecid=" + audiocodecid + " ";
			echo += "audiodatarate=" + audiodatarate + " ";
			echo += "audiosamplerate=" + audiosamplerate + " ";
			echo += "audiosamplesize=" + audiosamplesize + " ";
			echo += "duration=" + duration + " ";
			echo += "encoder=" + encoder + "\r";
			echo += "filesize=" + filesize + " ";
			echo += "framerate=" + framerate + " ";
			echo += "width=" + width + " ";
			echo += "height=" + height + " ";
			echo += "length=" + length + " ";
			echo += "stereo=" + stereo + " ";
			echo += "videocodecid=" + videocodecid + " ";
			echo += "videodatarate=" + videodatarate;
			return echo;
		}
		
	}
}