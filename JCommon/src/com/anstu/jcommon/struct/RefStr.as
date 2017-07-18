package com.anstu.jcommon.struct
{
	public class RefStr
	{
		private var _val:String = "";
		public function set val(value:String):void
		{
			this._val = value;
		}
		public function get val():String
		{
			return this._val;
		}
		
		public function RefStr(pVal:String="")
		{
			this._val = pVal;
		}
		
		public function toString():String
		{
			return this._val;
		}
	}
}