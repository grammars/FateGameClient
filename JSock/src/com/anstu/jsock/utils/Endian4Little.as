package com.anstu.jsock.utils
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class Endian4Little
	{
		public function Endian4Little()
		{
		}
		
		static private var buffer:ByteArray = new ByteArray();
		
		/**
		 * 对INT进行高低位转换
		 * 代替 IDataInput 接口的 readInt方法
		 * IDataInput接口用于提供一组读取2进制数据的方法
		 * @param source 读取的位置
		 * @return 
		 */
		static public function readInt(source:IDataInput):int
		{
			buffer.clear();
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			var v3:int = source.readByte();
			var v4:int = source.readByte();
			buffer.position = 0;
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position = 0;
			return buffer.readInt();
		}
		
		/**
		 * 对INT进行高低位转换
		 * 代替IDataOutput的writeInt方法
		 * @param value
		 * @param destination
		 */
		static public function writeInt(destination:IDataOutput, value:int):void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeInt(value);
			destination.writeByte(buffer[3]);
			destination.writeByte(buffer[2]);	
			destination.writeByte(buffer[1]);
			destination.writeByte(buffer[0]);
		}
		
		/** readFloat */
		static public function readFloat(source:IDataInput):Number
		{
			buffer.clear();
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			var v3:int = source.readByte();
			var v4:int = source.readByte();
			buffer.position = 0;
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position = 0;
			return buffer.readFloat();
		}
		
		/** writeFloat */
		static public function writeFloat(destination:IDataOutput, value:Number):void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeFloat(value);
			destination.writeByte(buffer[3]);
			destination.writeByte(buffer[2]);	
			destination.writeByte(buffer[1]);
			destination.writeByte(buffer[0]);
		}
		
		/** readUnsignedInt */
		static public function readUnsignedInt(source:IDataInput):int
		{
			buffer.clear();
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			var v3:int = source.readByte();
			var v4:int = source.readByte();
			buffer.position = 0;
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position = 0;
			return buffer.readUnsignedInt();
		}
		
		/** writeUnsignedInt */
		static public function writeUnsignedInt(destination:IDataOutput, value:int):void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeUnsignedInt(value);
			destination.writeByte(buffer[3]);
			destination.writeByte(buffer[2]);	
			destination.writeByte(buffer[1]);
			destination.writeByte(buffer[0]);
		}
		
		/** 将Int64读取为String */
		static public function readInt64ToStr(source:IDataInput):String
		{
			var v1:int = source.readUnsignedByte();
			var v2:int = source.readUnsignedByte();
			var v3:int = source.readUnsignedByte();
			var v4:int = source.readUnsignedByte();
			var v5:int = source.readUnsignedByte();
			var v6:int = source.readUnsignedByte();
			var v7:int = source.readUnsignedByte();
			var v8:int = source.readUnsignedByte();
			//
			var res:String = "";
			res += "_" + v8;
			res += "_" + v7;
			res += "_" + v6;
			res += "_" + v5;
			res += "_" + v4;
			res += "_" + v3;
			res += "_" + v2;
			res += "_" + v1;
			return res;
		}
		
		/**
		 * 对INT64进行高低位转换
		 * @param source
		 * @return 
		 */
		static public function readInt64(source:IDataInput):Number
		{
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			var v3:int = source.readByte();
			var v4:int = source.readByte();
			var v5:int = source.readByte();
			var v6:int = source.readByte();
			var v7:int = source.readByte();
			var v8:int = source.readByte();
			
			v1=v1&0x000000ff;
			v2=v2&0x000000ff;
			v3=v3&0x000000ff;
			v4=v4&0x000000ff;
			v5=v5&0x000000ff;
			v6=v6&0x000000ff;
			v7=v7&0x000000ff;
			v8=v8&0x000000ff;
			
			var v1r2:Number = v1;
			var v2r2:Number = v2;
			var v3r2:Number = v3;
			var v4r2:Number = v4;
			var v5r2:Number = v5;
			var v6r2:Number = v6;
			var v7r2:Number = v7;
			var v8r2:Number = v8;
			
			var reInt64:Number = 0;
			reInt64=v7r2*281474976710656+v6r2*1099511627776+v5r2*4294967296+v4r2*16777216+v3r2*65536+v2r2*256+v1r2;
			
			return reInt64;
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
			//待验证
			var v1:Number = Math.floor(value) &0x000000ff ;
			var v2:Number = Math.floor(value/256)&0x000000ff;
			var v3:Number = Math.floor(value/65536)&0x000000ff;
			var v4:Number = Math.floor(value/16777216)&0x000000ff;
			var v5:Number = Math.floor(value/4294967296)&0x000000ff;
			var v6:Number = Math.floor(value/1099511627776)&0x000000ff;
			var v7:Number = Math.floor(value/281474976710656)&0x000000ff;
			var v8:Number = 0;
			
			destination.writeByte(v1);
			destination.writeByte(v2);
			destination.writeByte(v3);
			destination.writeByte(v4);
			destination.writeByte(v5);
			destination.writeByte(v6);
			destination.writeByte(v7);
			destination.writeByte(v8);
		}
		
		/** readDouble */
		static public function readDouble(source:IDataInput):Number
		{
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			var v3:int = source.readByte();
			var v4:int = source.readByte();
			var v5:int = source.readByte();
			var v6:int = source.readByte();
			var v7:int = source.readByte();
			var v8:int = source.readByte();
			
			buffer.clear();
			buffer.position = 0;
			buffer.writeByte(v8);
			buffer.writeByte(v7);
			buffer.writeByte(v6);
			buffer.writeByte(v5);
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			
			return buffer.readDouble();
		}
		
		/** writeDouble */
		static public function writeDouble(destination:IDataOutput, value:Number):void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeDouble(value);
			destination.writeByte(buffer[7]);
			destination.writeByte(buffer[6]);
			destination.writeByte(buffer[5]);
			destination.writeByte(buffer[4]);
			destination.writeByte(buffer[3]);
			destination.writeByte(buffer[2]);
			destination.writeByte(buffer[1]);
			destination.writeByte(buffer[0]);
		}
		
		/**
		 * 对Short进行高低位转换
		 */
		static public function readShort(source:IDataInput):int
		{
			buffer.clear();
			buffer.position = 0;
			var v1:int = source.readByte();
			var v2:int = source.readByte();
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position = 0;
			return buffer.readShort();
		}
		
		/**
		 * 对Short进行高低位转换
		 */
		static public function writeShort(destination:IDataOutput, value:int) : void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeShort(value);
			buffer.position = 0 ;
			destination.writeByte(buffer[1]);
			destination.writeByte(buffer[0]);
		}
		
		/** writeBytes */
		static public function writeBytes(destination:IDataOutput, value:*, length:int=0):void
		{
			if(value && value is ByteArray)
			{
				destination.writeBytes(value, 0, length);
			}
			else
			{
				for(var i:int = 0; i < length; i++) { destination.writeByte(0); }
			}
		}
		
		/** readBytes */
		static public function readBytes(source:IDataInput, length:int, offset:int=0):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			source.readBytes(bytes, offset, length);
			return bytes;
		}
		
	}
}