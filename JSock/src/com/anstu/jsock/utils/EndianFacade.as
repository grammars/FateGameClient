package com.anstu.jsock.utils
{
	import com.anstu.jcommon.def.CharsetConst;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class EndianFacade
	{
		public static var isBigEndian:Boolean = true;
		
		public function EndianFacade()
		{
		}
		
		/** 将Int64读取为String */
		static public function readInt64ToStr(source:IDataInput):String
		{
			if(isBigEndian == true)
			{
				return Endian4Big.readInt64ToStr(source);
			}
			else
			{
				return Endian4Little.readInt64ToStr(source);
			}
		}
		
		/**
		 * [暂不使用，未经验证]
		 * @param source
		 * @return 
		 */
		static public function readInt64(source:IDataInput):Number
		{
			if(isBigEndian == true)
			{
				return Endian4Big.readInt64(source);
			}
			else
			{
				return Endian4Little.readInt64(source);
			}
		}
		
		/**A7F8000000D6F6
		 * 
		 * 对INT64进行高地位转换 
		 * @param value
		 * @param destination
		 * 47278999994423035
		 * 47278999994423030
		 * 10000009C40
		 * 40 9c 00 00 00
		 */
		static public function writeInt64(destination:IDataOutput, value:Number):void
		{
			if(isBigEndian == true)
			{
				Endian4Big.writeInt64(destination, value);
			}
			else
			{
				Endian4Little.writeInt64(destination, value);
			}
		}
		
		/** readInt */
		static public function readInt(source:IDataInput):int
		{
			if(isBigEndian == true)
			{
				return source.readInt();
			}
			else
			{
				return Endian4Little.readInt(source);
			}
		}
		
		/** writeInt */
		static public function writeInt(destination:IDataOutput, value:int):void
		{
			if(isBigEndian == true)
			{
				destination.writeInt(value);
			}
			else
			{
				Endian4Little.writeInt(destination, value);
			}
		}
		
		/** readUnsignedInt */
		static public function readUnsignedInt(source:IDataInput):int
		{
			if(isBigEndian == true)
			{
				return source.readUnsignedInt();
			}
			else
			{
				return Endian4Little.readUnsignedInt(source);
			}
		}
		
		/** writeUnsignedInt */
		static public function writeUnsignedInt(destination:IDataOutput, value:int):void
		{
			if(isBigEndian == true)
			{
				destination.writeUnsignedInt(value);
			}
			else
			{
				Endian4Little.writeUnsignedInt(destination, value);
			}
		}
		
		/** readShort */
		static public function readShort(source:IDataInput):int
		{
			if(isBigEndian == true)
			{
				return source.readShort();
			}
			else
			{
				return Endian4Little.readShort(source);
			}
		}
		
		/** writeShort */
		static public function writeShort(destination:IDataOutput, value:int) : void
		{
			if(isBigEndian == true)
			{
				destination.writeShort(value);
			}
			else
			{
				Endian4Little.writeShort(destination, value);
			}
		}
		
		/** writeBytes */
		static public function writeBytes(destination:IDataOutput, value:*, length:int=0):void
		{
			if(isBigEndian == true)
			{
				Endian4Big.writeBytes(destination, value, length);
			}
			else
			{
				Endian4Little.writeBytes(destination, value, length);
			}
		}
		
		/** readBytes */
		static public function readBytes(source:IDataInput, length:int, offset:int=0):ByteArray
		{
			if(isBigEndian == true)
			{
				return Endian4Big.readBytes(source, length, offset);
			}
			else
			{
				return Endian4Little.readBytes(source, length, offset);
			}
		}
		
		/** readByte */
		static public function readByte(source:IDataInput):int
		{
			return source.readByte();
		}
		
		/** writeByte */
		static public function writeByte(destination:IDataOutput, value:int):void
		{
			destination.writeByte(value);
		}
		
		/** readBoolean */
		static public function readBoolean(source:IDataInput):Boolean
		{
			return source.readBoolean();
		}
		
		/** writeBoolean */
		static public function writeBoolean(destination:IDataOutput, value:Boolean):void
		{
			destination.writeBoolean(value);
		}
		
		/** readFloat */
		static public function readFloat(source:IDataInput):Number
		{
			if(isBigEndian == true)
			{
				return source.readFloat();
			}
			else
			{
				return Endian4Little.readFloat(source);
			}
		}
		
		/** writeFloat */
		static public function writeFloat(destination:IDataOutput, value:Number):void
		{
			if(isBigEndian == true)
			{
				destination.writeFloat(value);
			}
			else
			{
				Endian4Little.writeFloat(destination, value);
			}
		}
		
		/** readDouble */
		static public function readDouble(source:IDataInput):Number
		{
			if(isBigEndian == true)
			{
				return source.readDouble();
			}
			else
			{
				return Endian4Little.readDouble(source);
			}
		}
		
		/** writeDouble */
		static public function writeDouble(destination:IDataOutput, value:Number):void
		{
			if(isBigEndian == true)
			{
				destination.writeDouble(value);
			}
			else
			{
				Endian4Little.writeDouble(destination, value);
			}
		}
		
		/** readLong */
		static public function readLong(source:IDataInput):Long
		{
			return new Long().readFrom(source);
		}
		
		/** writeLong */
		static public function writeLong(destination:IDataOutput, value:Long):void
		{
			value.writeTo(destination);
		}
		
		/** readMultiByte */
		static public function readMultiByte(source:IDataInput, length:int=-1, charset:String=CharsetConst.UTF8):String
		{
			var len:int = source.readInt();
			if(length > 0) { len = length; }
			return source.readMultiByte(len, charset);
		}
		
		/** writeMultiByte */
		static public function writeMultiByte(destination:IDataOutput, value:String, length:int=-1, charset:String=CharsetConst.UTF8):void
		{
			var tmpBytes:ByteArray = new ByteArray();
			tmpBytes.writeMultiByte(value, charset);
			if(length > 0)
			{
				var fillCount:int = length - tmpBytes.position;//填充长度
				if(fillCount > 0)
				{
					tmpBytes.position = tmpBytes.position + fillCount - 1;
					tmpBytes.writeByte(0);
				}
			}
			destination.writeInt(tmpBytes.length);
			destination.writeBytes(tmpBytes, 0, tmpBytes.length);
		}
		
	}
}