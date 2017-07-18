package com.anstu.jcommon.struct
{
	public class RefInt
	{
		private var _val:int = 0;
		public function set val(value:int):void
		{
			this._val = value;
		}
		public function get val():int
		{
			return this._val;
		}
		
		public function RefInt(pVal:int=0)
		{
			this._val = pVal;
		}
		
		public function toString():String
		{
			return this._val.toString();
		}
		
	}
}