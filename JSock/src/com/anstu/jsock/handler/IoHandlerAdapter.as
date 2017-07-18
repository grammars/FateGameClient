package com.anstu.jsock.handler
{
	import com.anstu.jsock.service.SocketService;
	
	public class IoHandlerAdapter implements IoHandler
	{
		public function IoHandlerAdapter()
		{
			//TODO: implement function
		}
		
		public function sessionOpened(service:SocketService):void
		{
			//TODO: implement function
		}
		
		public function sessionClosed(service:SocketService):void
		{
			//TODO: implement function
		}
		
		public function exceptionCaught(service:SocketService, err:Error):void
		{
			//TODO: implement function
		}
		
		public function messageReceived(service:SocketService, message:Object):void
		{
			//TODO: implement function
		}
	}
}