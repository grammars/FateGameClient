package com.anstu.jsock.utils
{
	import flash.utils.ByteArray;
	
	public class ByteBuffer
	{
		/** 默认的初始容量大小 */
		public static const CAPACITY:int=32;
		
		/** 默认的动态数据或文字的最大长度，400k */
		public static const MAX_DATA_LENGTH:int=400*1024;
	
		/** 字节数组 */
		protected var bytes:ByteArray;
		
		/** 按指定的字节数组构造一个字节缓存对象 */
		public function ByteBuffer(data:ByteArray=null)
		{
			if(data == null)
			{
				bytes = new ByteArray();
			}
			else
			{
				bytes = data;
			}
		}
		
		/** setByteArray */
		public function setByteArray(data:ByteArray):void
		{
			bytes = data;
		}
		
		/** 得到字节缓存的容积 */
		public function capacity():int
		{
			return bytes.length;
		}
		
		/** 设置字节缓存的容积，只能扩大容积 */
		public function setCapacity(len:int):void
		{
			var c:int=bytes.length;
			if(len<=c) return;
			bytes.length=len;
		}
		
		/** 得到字节缓存的长度 */
		public function top():int
		{
			return this.bytes.length;
		}
		
		/** 设置字节缓存的长度 */
		public function setTop(top:int):void
		{
			  setCapacity(top);	 
		}
		
		/** 得到字节缓存的偏移量 */
		public function offset():int
		{
			return this.bytes.position;
		}
		
		/** 设置字节缓存的偏移量 */
		public function setOffset(offset:int):void
		{
			if( this.bytes.position > top() )
			{
				throw new Error(this+" setOffset, invalid offset:"+this.bytes.position);
			}	
			this.bytes.position = offset;
		}
		
		/** 得到字节缓存的使用长度 */
		public function length():int
		{
			return this.bytes.bytesAvailable;
		}
		
		/** 得到字节缓存的字节数组，一般使用toArray()方法 */
		public function getByteArray():ByteArray
		{
			return bytes;
		}
		
		/** 得到指定偏移位置的字节 */
		public function readAt(pos:int):Number
		{
			return bytes[pos] as Number
		}
		
		/** 设置指定偏移位置的字节 */
		public function writeAt(b:int, pos:int):void
		{
			bytes[pos] = b;
		}
		
		/**
		 * 按当前偏移位置读入指定的字节数组
		 * 
		 * @param data 指定的字节数组
		 * @param pos 指定的字节数组的起始位置
		 * @param len 读入的长度
		 */
		public function read(data:ByteArray, pos:int, len:int):void
		{
			bytes.readBytes(data, pos, len);
		}
		
		/** 读出一个布尔值 */
		public function readBoolean():Boolean
		{
			return this.bytes.readBoolean();
		}
		
		/** 读出一个字节 */
		public function readByte():int
		{
			return this.bytes.readByte();
		}
		
		/** 读出一个无符号字节 */
		public function readUnsignedByte():int
		{
			return this.bytes.readUnsignedByte();
		}
		
		/** 读出一个字符 */
		public function readChar():String
		{
			return String.fromCharCode(readUnsignedShort());
		}
		
		/** 读出一个短整型数值 */
		public function readShort():int
		{
			return this.bytes.readShort();
		}
		
		/** 读出一个无符号的短整型数值 */
		public function readUnsignedShort():int
		{
			return this.bytes.readUnsignedShort();
		}
		
		/** 读出一个整型数值 */
		public function readInt():int
		{
			return this.bytes.readInt();
		}
		
		/** 读出一个浮点数值 */
		public function readFloat():Number
		{
			return this.bytes.readFloat();
		}
		
		/** 读出一个长整型数值 */
		public function readLong():Number
		{
			var l:Long = new Long();
			l.readFrom(this.bytes);
			return l.toNumber();
		}

		/** 读出一个long*/
		public function readLocalLong():Long
		{
			var l:Long = new Long();
			l.readFrom(this.bytes);
			return l;
		}
		
		/** 读出一个双浮点数值 */
		public function  readDouble():Number
		{
			return this.bytes.readDouble();
		}
		
		/**
		 * 读出动态长度， 数据大小采用动态长度，整数类型下，最大为512M 1xxx,xxxx表示(0~0x80) 0~128B
		 * 01xx,xxxx,xxxx,xxxx表示(0~0x4000) 0~16K
		 * 001x,xxxx,xxxx,xxxx,xxxx,xxxx,xxxx,xxxx表示(0~0x20000000) 0~512M
		 */
		public function readLength():int
		{
			var n:int=bytes[this.bytes.position]&0xff;
			if(n>=0x80)
			{
				this.bytes.position++;
				return n-0x80;
			}
			else if(n>=0x40)
				return readUnsignedShort()-0x4000;
			else if(n>=0x20)
				return readInt()-0x20000000;
			else
				throw new Error(this+" readLength, invalid number:"+n);
		}
		
		/** 读出一个指定长度的字节数组，可以为null */
		public function readData():ByteArray
		{
			var len:int = readLength()-1;
			if(len < 0) return null;
			if(len > MAX_DATA_LENGTH)
				throw new Error(this+" readData, data overflow:"+len);
			var data:ByteArray=new ByteArray();
			read(data, 0, len);
			return data;
		}
		
		/** 读出一个短字节数组，长度不超过254 */
		public function readShortData():ByteArray
		{
			var len:int = readUnsignedByte();
			if(len == 255) return null;
			var data:ByteArray = new ByteArray();
			if(len != 0) read(data,0,len);
			return data;
		}
		
		/** 读出一个指定长度的字符串 */
		public function readString(len:int):String
		{
			return this.bytes.readUTFBytes(len);
		}
		
		/** 读出一个短字符串，长度不超过254 */
		public function readShortString():String
		{
			var len:int = readUnsignedByte();
			if(len == 255) return null;
			return readString(len);
		}
		
		/** 读出一个字符串，长度不超过65534 */
		public function readLongString():String
		{
			var len:int = readUnsignedShort();
			if(len == 65535) return null;
			return readString(len);
		}
		
		/** 读出一个指定长度和编码类型的字符串 */
		public function readMultiByte(charsetName:String):String
		{
			var len:int = readLength()-1;
			if(len < 0) return null;
			if(len > MAX_DATA_LENGTH)
			{
				throw new Error(this+" readUTF, data overflow:"+len);
			}
			return this.bytes.readMultiByte(len,charsetName)
		}
		
		/** 读出一个指定长度的utf字符串 */
		public function readUTF():String
		{
			var len:int = readLength()-1;
			if(len < 0) return null;
			if(len > MAX_DATA_LENGTH){
				throw new Error(this+" readUTF, data overflow:"+len);
			}
			return this.bytes.readUTFBytes(len);
		}
		

		/**
		 * 写入指定字节数组
		 * 
		 * @param data 指定的字节数组
		 * @param pos 指定的字节数组的起始位置
		 * @param len 写入的长度
		 */
		public function write(data:ByteArray, pos:int=0, len:int=0):void
		{
			this.bytes.writeBytes(data,pos,len)
		}
		
		/** 写入一个布尔值 */
		public function writeBoolean(b:Boolean):void
		{
			this.bytes.writeBoolean(b);
		}
		
		/** 写入一个字节 */
		public function writeByte(b:int):void
		{
			this.bytes.writeByte(b);
		}
		
		/** 写入一个字符 */
		public function writeChar(c:int):void
		{
			writeShort(c);
		}
		
		/** 写入一个短整型数值 */
		public function writeShort(s:int):void
		{
			this.bytes.writeShort(s)
		}
		
		/** 在指定位置写入一个短整型数值，length不变 */
		public function writeShortAt(s:int, pos:int):void
		{
			var tp:int=this.bytes.position;
			this.bytes.position = pos;
			this.bytes.writeShort(s);
			this.bytes.position = tp;
		}
		
		/** 写入一个整型数值 */
		public function writeInt(i:int):void
		{
			this.bytes.writeInt(i);
		}
		
		/** 在指定位置写入一个整型数值，length不变 */
		public function writeIntAt(i:int,pos:int):void
		{
			var tp:int = this.bytes.position;
			this.bytes.position = pos;
			this.bytes.writeInt(i);
			this.bytes.position = tp;
		}
		
		/** 写入一个浮点数值 */
		public function writeFloat(f:Number):void
		{
			this.bytes.writeFloat(f);
		}
		
		/** 写入一个长整型数值 */
		public function writeLong(l:Number):void
		{
			var _l:Long = new Long(l);
			_l.writeTo(this.bytes);
		}

		/** 写入一个长整型数值 */
		public function writeLocalLong(l:Long):void
		{
			l.writeTo(this.bytes)
		}
		
		/** 写入一个双浮点数值 */
		public function writeDouble(d:Number):void
		{
			this.bytes.writeDouble(d);
		}
		
		/** 写入动态长度 */
		public function writeLength(len:int):void
		{
			if(len>=0x20000000||len<0)
				throw new Error(this+" writeLength, invalid len:"+len);
			if(len>=0x4000)
				writeInt(len+0x20000000);
			else if(len>=0x80)
				writeShort(len+0x4000);
			else
				writeByte(len+0x80);
		}
		
		/** 写入一个字节数组，可以为null */
		public function writeData(data:ByteArray):void
		{
			writeDataAt(data,0,(data!=null)?data.length:0);
		}
		
		/** 写入一个字节数组，可以为null */
		public function writeDataAt(data:ByteArray,pos:int,len:int):void
		{
			if(data==null)
			{
				writeLength(0);
				return;
			}
			writeLength(len+1);
			write(data,pos,len);
		}
		
		/** 写入一个字符串，可以为null */
		public function writeString(s:String):void
		{
			if(s!=null)
			{
				var temp:ByteArray=new ByteArray();
				temp.writeUTFBytes (s) 
				if(temp.length>65534)
					throw new Error(this+" writeString, invalid s:"+s);
				writeShort(temp.length);
				if(temp.length!=0) write(temp,0,temp.length);
			}
			else
				writeShort(65535);
		}
		
		/** 写入一个字符串，以指定的字符进行编码 */
		public function writeMultiByte(str:String, charsetName:String):void
		{
			if(str==null)
			{
				writeLength(0);
				return;
			}
			var data:ByteArray=new ByteArray();
			if(charsetName!=null)
			{
				try
				{
					data.writeMultiByte(str,charsetName);
				}
				catch(e:Error)
				{
					throw new Error(e+" writeUTF, invalid charsetName:"+charsetName);
				}
			}
			else{
				data.writeUTFBytes(str);
			}
			writeLength(data.length+1);
			write(data,0,data.length);
		}
		
		/** 写入一个utf字符串，可以为null */
		public function writeUTF(str:String):void
		{
			writeUTFAt(str,0,(str!=null)?str.length:0);
		}
		
		/** 写入一个utf字符串中指定的部分，可以为null */
		public function writeUTFAt( str:String,index:int,length:int):void
		{
			if(str==null)
			{
				writeLength(0);
				return;
			}
			var data:ByteArray=new ByteArray();
			data.writeUTFBytes(str.slice(index,length));
			writeLength(data.length+1);
			write(data,0,data.length);
		}
		
		/** writeUTFBytes */
		public function writeUTFBytes(str:String):void
		{
			bytes.writeUTFBytes(str);
		}
		
		/** 在指定位置写入一个字节，length不变 */
		public function writeByteAt(b:int, pos:int):void
		{
			var tp:int = this.bytes.position;
			this.bytes.writeByte(b);
			this.bytes.position = tp;
		}
		
		/** 得到字节缓存当前长度的字节数组 */
		public function toByteArray():ByteArray
		{
			var data:ByteArray =new ByteArray()
			data.writeBytes(bytes)
			return bytes;
		}
		
		/** 清除字节缓存对象 */
		public function clear():void
		{
			this.bytes.clear();
		}
		
		/** hashCode */
		public function hashCode():int
		{
			var hash:int=17;
			for(var i:int=this.bytes.length-1;i>=0;i--)
				hash=65537*hash+bytes[i];
			return hash;
		}
		
		public function equals(obj:Object):Boolean
		{
			if(this == obj) return true;
			if(obj is ByteBuffer)
			{
				var bb:ByteBuffer=obj as ByteBuffer;
				if(bb==null) return false;
				if(bb.top() != this.bytes.length) return false;
				if(bb.offset() != this.bytes.position) return false;
				for(var i:int=this.bytes.length-1; i>=0; i--)
				{
					if(bb.bytes[i] != bytes[i]) return false;
				}
				return true;
			}
			return false;
		}
		 
		public function  toString():String
		{
			return "["+this.bytes.length+","+this.bytes.position+"] ";
		}
		 
	}
}