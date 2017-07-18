package com.anstu.jsock.utils
{
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class Long
	{
		/** new一个同值的Long */	
		public static function newFromLong(value:Long):Long
		{
			var l:Long = new Long();
			l.clone(value);
			return l;
		}
		
		private static const LEN:int = 64;
		private static const VALID:int = 53;
		/** Boolean[64]0:false 1:true
		 * Boolean[0]存放符号位, false为正数, true为负数 */
		private var cache:Array;

		public function Long(value:Number=0)
		{
			buildCache();
			fromNumber(value);
		}
		
		private function buildCache():void
		{
			cache = new Array();
			for(var i:int = 0; i < LEN; i++)
			{
				cache.push(false);
			}
		}
		
		private var _positive:Boolean = true;
		public function set positive(value:Boolean):void
		{
			if(_positive != value)
			{
				_positive = value;
				flip();
			}
		}
		public function get positive():Boolean { return _positive; }
		
		/** 翻转，正变负，负变正 */
		private function flip():void
		{
			var i:int = 0;
			for(i = 0; i < LEN; i++)
			{
				cache[i] = !cache[i];
			}
			for(i = LEN-1; i >= 0; i--)
			{
				if(cache[i] == false)
				{
					cache[i] = true;
					break;
				}
				else
				{
					cache[i] = false;
				}
			}
		}
		
		/** Number=>Long */
		public function fromNumber(value:Number):Long
		{
			var absVal:Number = Math.abs(value);
			for (var i:int = LEN-1; i > 0; i--)
			{
				if(i < LEN-VALID-1)
				{
					cache[i] = false;
				}
				else
				{
					if(absVal >= 0 && (absVal & 1) != 0)
					{
						cache[i] = true;
					}
					else
					{
						cache[i] = false;
					}
					//trace(absVal + "--" + (absVal & 1) + "==" + cache[i]);
					absVal = Math.abs(absVal / 2);
				}
			}
			cache[0] = false;
			
			this.positive = value >= 0 ? true : false;
			
			return this;
		}
		
		/** Long=>Number(具有局限性) */
		public function toNumber():Number
		{
			var num:Number = 0;
			var offset:int = 0;
			
			if(positive == false) { flip(); }//翻转，方便计算
			
			for (var i:int = LEN-1; i >= LEN-VALID-1; i--)
			{
				if( cache[i] == true )
				{
					num += (Math.pow(2,offset));
				}
				offset++;
			}
			
			if(positive == false) { num = -num; flip(); }//恢复翻转
			
			return num;
		}
		
		/** Date=>Long */
		public function fromDate(value:Date):Long
		{
			return fromNumber(value.time);
		}
		
		/** Long=>Date */
		public function toDate():Date
		{
			var date:Date = new Date();
			date.time = toNumber();
			return date;
		}

		/** 从IDataInput中读出 */
		public function readFrom(source:IDataInput):Long
		{
			var byteArr:Array = [];
			var byte0:int = source.readByte();
			var byte1:int = source.readByte();
			var byte2:int = source.readByte();
			var byte3:int = source.readByte();
			var byte4:int = source.readByte();
			var byte5:int = source.readByte();
			var byte6:int = source.readByte();
			var byte7:int = source.readByte();
			
			if(EndianFacade.isBigEndian)
			{
				byteArr.push(byte0,byte1,byte2,byte3,byte4,byte5,byte6,byte7);
			}
			else
			{
				byteArr.push(byte7,byte6,byte5,byte4,byte3,byte2,byte1,byte0);
			}
			
			var cid:int = 0;
			for(var ac:int = 0; ac < 8; ac++)
			{
				var curByte:int = byteArr[ac];
				for(var i:int = 0; i < 8; i++)
				{
					cache[cid] = ((curByte>>(7-i))&1) == 0 ? false : true ;
					cid++;
				}
			}
			return this;
		}

		/** 写入到IDataOutput */
		public function writeTo(target:IDataOutput):void
		{
			var byteArr:Array = [];
			var cid:int = 0;
			for(var ac:int = 0; ac < 8; ac++)
			{
				var curByte:int = 0;
				for(var i:int = 0; i < 8; i++)
				{
					curByte += cache[cid] == true ? (1<<(7-i)) : 0 ;
					cid++;
				}
				byteArr.push(curByte);
			}
			if(EndianFacade.isBigEndian)
			{
				target.writeByte(byteArr[0]);
				target.writeByte(byteArr[1]);
				target.writeByte(byteArr[2]);
				target.writeByte(byteArr[3]);
				target.writeByte(byteArr[4]);
				target.writeByte(byteArr[5]);
				target.writeByte(byteArr[6]);
				target.writeByte(byteArr[7]);
			}
			else
			{
				target.writeByte(byteArr[7]);
				target.writeByte(byteArr[6]);
				target.writeByte(byteArr[5]);
				target.writeByte(byteArr[4]);
				target.writeByte(byteArr[3]);
				target.writeByte(byteArr[2]);
				target.writeByte(byteArr[1]);
				target.writeByte(byteArr[0]);
			}
		}

		/** 判断是否相等 */
		public function euqals(l:Long):Boolean
		{
			return this.toBinaryString() == l.toBinaryString();
		}
		
		/**
		 * 与Long比较
		 * 大返回1，小返回-1，等于返回0
		 */
		public function compare(value:Long):int
		{
			if (euqals(value))
			{
				return 0;
			}
			if (this.toNumber() > value.toNumber())
			{
				return 1
			}
			if (this.toNumber() < value.toNumber())
			{
				return -1
			}
			return 0
		}

		/**
		 * 与Number比较
		 * 大返回1，小返回-1，等于返回0
		 */
		public function compareNum(value:Number):int
		{
			var long:Long = new Long(value);
			return compare(long);
		}

		/** clone */
		public function clone(value:Long):void
		{
			for(var i:int = 0; i < LEN; i++)
			{
				cache[i] = value.cache[i];
			}
		}
		
		/** fromString */
		public function fromString(value:String):Long
		{
			var num:Number = 0;
			if(-1 != value.indexOf("0x"))
			{
				//十六进制
				var pure:String = value.replace("0x", "");
				if(pure.length <= 8)
				{
					num = parseInt(pure, 16);
				}
				else
				{
					if(pure.length >= 16)
					{
						pure = pure.slice(pure.length-16, pure.length);
					}
					var highStr:String = pure.slice(0, pure.length-8);
					var lowStr:String = pure.slice(pure.length-8, pure.length);
					//trace("highStr=" + highStr + " lowStr=" + lowStr);
					var high:Number = parseInt(highStr, 16);
					var low:Number = parseInt(lowStr, 16);
					num = high * Math.pow(2,32) + low;
				}
			}
			else
			{
				//十进制
				num = parseFloat(value);
			}
			fromNumber(num);
			return this;
		}
		
		/** 获取二进制字符 */
		public function toBinaryString():String
		{
			var str:String = "";
			for(var i:int = 0; i < LEN; i++)
			{
				str += cache[i] == true ? "1" : "0";
			}
			return str;
		}
		
		/** 获取十六进制字符 */
		public function toHexString():String
		{
			var str:String = "0x";
			var cid:int = 0;
			for(var ac:int = 0; ac < 8; ac++)
			{
				var curByte:int = 0;
				for(var i:int = 0; i < 8; i++)
				{
					curByte += cache[cid] == true ? (1<<(7-i)) : 0 ;
					cid++;
				}
				if(curByte < 16)
				{
					str += "0";
				}
				str += curByte.toString(16);
			}
			return str;
		}
		
		/** toString */
		public function toString():String
		{
			return toHexString();
		}

	}
}