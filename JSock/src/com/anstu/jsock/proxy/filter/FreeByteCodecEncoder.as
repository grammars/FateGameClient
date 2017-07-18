package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.filter.ProtocolEncoder;
	
	import flash.utils.ByteArray;
	
	public class FreeByteCodecEncoder implements ProtocolEncoder
	{
		public function FreeByteCodecEncoder()
		{
		}
		
		public function encode(service:SocketService, message:Object):void
		{
			var data:ByteArray = new ByteArray();
			var bodyBytes:ByteArray = message as ByteArray;
			data.writeInt(bodyBytes.length);
			data.writeBytes(bodyBytes);
			service.getSocket().writeBytes(data);
		}
		
		public function dispose(service:SocketService):void
		{
		}
	}
}