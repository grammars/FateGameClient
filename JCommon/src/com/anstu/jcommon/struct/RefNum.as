package com.anstu.jcommon.struct
{
	public class RefNum
	{
		private var _val:Number = 0;
		public function set val(value:Number):void
		{
			this._val = value;
		}
		public function get val():Number
		{
			return this._val;
		}
		
		public function RefNum(pVal:Number=0)
		{
			this._val = pVal;
		}
		
		public function toString():String
		{
			return this._val.toString();
		}
	}
}