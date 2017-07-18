package com.anstu.jsock.proxy.filter
{
	import com.anstu.jcommon.def.CharsetConst;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.filter.ProtocolEncoder;
	
	import flash.utils.ByteArray;
	
	public class DlgCodecEncoder implements ProtocolEncoder
	{
		public function DlgCodecEncoder()
		{
		}
		
		public function encode(service:SocketService, message:Object):void
		{
			var data:ByteArray = new ByteArray();
			var strBytes:ByteArray = new ByteArray();
			strBytes.writeMultiByte(message.toString(), CharsetConst.UTF8);
			data.writeInt(strBytes.length);
			data.writeBytes(strBytes);
			data.writeByte(13);
			data.writeByte(10);
			service.getSocket().writeBytes(data);
		}
		
		public function dispose(service:SocketService):void
		{
		}
	}
}