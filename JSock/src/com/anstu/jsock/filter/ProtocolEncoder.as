package com.anstu.jsock.filter
{
	import com.anstu.jsock.service.SocketService;

	public interface ProtocolEncoder
	{
		function encode(service:SocketService, message:Object):void;
		
		function dispose(service:SocketService):void;
	}
}