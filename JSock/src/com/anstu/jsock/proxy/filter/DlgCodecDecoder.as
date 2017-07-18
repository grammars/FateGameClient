package com.anstu.jsock.proxy.filter
{
	import com.anstu.jcommon.def.CharsetConst;
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.filter.ProtocolDecoder;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class DlgCodecDecoder implements ProtocolDecoder
	{	
		private static const SLASH_R:int = 13;// \r
		private static const SLASH_N:int = 10;// \n
		
		public function DlgCodecDecoder()
		{
		}
		
		private var errNow:Boolean = false;
		
		public function decode(service:SocketService):void
		{
			var sock:Socket = service.getSocket();
			if(errNow == true)
			{
				while(sock.bytesAvailable >= 2)
				{
					var x:int = sock.readByte();
					if(x == SLASH_R)
					{
						x = sock.readByte();
						if(x == SLASH_N)
						{
							errNow = false;
							break;
						}
					}
				}
			}
			if(errNow == true)
			{
				return;
			}
			while(sock.bytesAvailable >= 6)
			{
				var contentSize:int = EndianFacade.readInt(sock);
				if(contentSize <= 0 || sock.bytesAvailable < (contentSize+2))
				{
					Log.error("遇到一个非法包");
					errNow = true;
					break;
				}
				var content:String = EndianFacade.readMultiByte(sock, contentSize, CharsetConst.UTF8);
				var slashR:int = EndianFacade.readByte(sock);
				var slashN:int = EndianFacade.readByte(sock);
				if(slashR != SLASH_R || slashN != SLASH_N)
				{
					Log.error("遇到一个非法包");
					errNow = true;
				}
				else
				{
					Log.debug("成功解析了一个包");
					//trace(content);
					service.getHandler().messageReceived(service, content);
				}
			}
		}
		
		public function dispose(service:SocketService):void
		{
		}
	}
}