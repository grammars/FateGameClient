package com.anstu.jsock.filter
{
	import com.anstu.jsock.service.SocketService;

	public interface ProtocolDecoder
	{
		function decode(service:SocketService):void;
		
		function dispose(service:SocketService):void;
	}
}