package com.anstu.jsock.proxy.filter
{
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.filter.ProtocolDecoder;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class FreeByteCodecDecoder implements ProtocolDecoder
	{
		/** 消息体最大字节长(单位:byte) */
		private static const MSG_BODY_MAX_LEN:int = 128*1024;
		
		private var bytesCache:ByteArray = new ByteArray();
		
		public function FreeByteCodecDecoder()
		{
		}
		
		
		public function decode(service:SocketService):void
		{
			var sock:Socket = service.getSocket();
			sock.readBytes(bytesCache, bytesCache.position, sock.bytesAvailable);
			
			var result:Boolean = digestBytes(service);
			while(result)
			{
				result = digestBytes(service);
			}
		}
		
		private var length:int = 0;
		public function digestBytes(service:SocketService):Boolean
		{
			if(bytesCache.bytesAvailable < 4)
			{
				return false;
			}
			length = EndianFacade.readInt(bytesCache);
			if(length <= 0 || length > MSG_BODY_MAX_LEN)
			{
				var eat:ByteArray = new ByteArray();
				bytesCache.readBytes(eat, 0, bytesCache.bytesAvailable);
				Log.error("消息长度异常，当前bytesCache已被清空 bytesCache.bytesAvailable=", bytesCache.bytesAvailable);
				return false;
			}
			if(bytesCache.bytesAvailable < length)
			{
				bytesCache.position = bytesCache.position - 4;
				return false;
			}
			var message:ByteArray = EndianFacade.readBytes(bytesCache, length);
			service.getHandler().messageReceived(service, message);
			return true;
		}
		
		public function dispose(service:SocketService):void
		{
		}
		
	}
}