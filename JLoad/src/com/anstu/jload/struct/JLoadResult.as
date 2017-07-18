package com.anstu.jload.struct
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.net.NetStream;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;

	public class JLoadResult
	{
		private var _value:*;
		public function set value(v:*):void
		{
			this._value = v;
		}
		public function get value():* { return _value; }
		
		public function JLoadResult()
		{
			//
		}
		
		public function getBmp():Bitmap { return Bitmap(_value); }
		public function getMovieClip():MovieClip { return MovieClip(_value); }
		public function getDomain():ApplicationDomain { return ApplicationDomain(_value); }
		public function getText():String { return String(_value); }
		public function getBinary():ByteArray { return ByteArray(_value); }
		public function getURLVar():URLVariables { return URLVariables(_value); }
		public function getXML():XML { return XML(_value); }
		public function getSound():Sound { return Sound(_value); }
		public function getStream():NetStream { return NetStream(_value); }
	}
}