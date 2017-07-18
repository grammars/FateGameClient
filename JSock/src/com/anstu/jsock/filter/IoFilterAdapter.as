package com.anstu.jsock.filter
{
	import com.anstu.jsock.service.SocketService;
	
	public class IoFilterAdapter implements IoFilter
	{
		public function IoFilterAdapter()
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
		
		public function messageReceived(service:SocketService):void
		{
			//TODO: implement function
		}
		
		public function filterWrite(service:SocketService, message:Object):void
		{
			//TODO: implement function
		}
		
	}
}