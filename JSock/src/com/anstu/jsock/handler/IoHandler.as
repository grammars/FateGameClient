package com.anstu.jsock.handler
{
	import com.anstu.jsock.service.SocketService;

	public interface IoHandler
	{
		/** 会话已打开 */
		function sessionOpened(service:SocketService):void;
		
		/** 会话被关闭 */
		function sessionClosed(service:SocketService):void;
		
		/** 异常捕捉 */
		function exceptionCaught(service:SocketService, err:Error):void;
		
		/** 接收到消息 */
		function messageReceived(service:SocketService, message:Object):void;
	}
}