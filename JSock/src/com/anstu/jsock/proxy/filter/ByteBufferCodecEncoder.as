package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.filter.ProtocolEncoder;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.utils.ByteBuffer;
	
	import flash.utils.ByteArray;
	
	public class ByteBufferCodecEncoder implements ProtocolEncoder
	{
		public function ByteBufferCodecEncoder()
		{
		}
		
		public function encode(service:SocketService, message:Object):void
		{
			var buffer:ByteBuffer = message as ByteBuffer;
			service.getSocket().writeInt(buffer.top());
			service.getSocket().writeBytes(buffer.toByteArray());
		}
		
		public function dispose(service:SocketService):void
		{
		}
	}
}