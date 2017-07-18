package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.filter.ProtocolDecoder;
	import com.anstu.jsock.service.SocketService;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class ByteBufferCodecDecoder implements ProtocolDecoder
	{
		public function ByteBufferCodecDecoder()
		{
		}
		
		public function decode(service:SocketService):void
		{
			readData(service);
		}
		
		private static const HEAD_LENGTH:int = 4;
		private var isReadHead:Boolean = false;
		private var len:int = -1;
		private var dataBuffer:ByteArray = new ByteArray();
		
		private function readData(service:SocketService):void
		{
			var socket:Socket = service.getSocket();
			if (!this.isReadHead && socket.bytesAvailable >= HEAD_LENGTH)//如果还没读过头部则读一次。
			{
				len = socket.readInt();
				this.isReadHead = true;
			}
			//trace("是否读过头部->" + isReadHead + "缓冲区字节数->" + this.socket.bytesAvailable);
			if (isReadHead && socket.bytesAvailable >= len)//如果读了头部，并且当前可读长度大于等于消息长度，则开始读取
			{
				dataBuffer.clear();
				socket.readBytes(dataBuffer, 0, len);
				service.getHandler().messageReceived(service, dataBuffer);
				this.isReadHead = false;
			}
			else
			{
				return;
			}
			//trace("当前剩余可读为 -->" + socket.bytesAvailable);
			//如果是读过头，则如果当前消息大于消息长度则再次调用读取，否则则判断是否可读头部
			socket.bytesAvailable >= HEAD_LENGTH && readData(service);
		}
		
		public function dispose(service:SocketService):void
		{
		}
	}
}