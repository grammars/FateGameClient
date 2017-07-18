package com.anstu.jsock.service
{
	import com.anstu.jcommon.def.Macro;
	import com.anstu.jcommon.def.NetConst;
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.filter.IoFilter;
	import com.anstu.jsock.handler.IoHandler;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class SocketService
	{
		private var sock:Socket;
		private var host:String;
		private var port:int;
		
		private var connTimes:int = 0;
		
		private var filter:IoFilter;
		private var handler:IoHandler;
		
		public function getSocket():Socket { return sock; }
		public function getHandler():IoHandler { return handler; }
		
		public function SocketService(filter:IoFilter, handler:IoHandler)
		{
			this.sock = new Socket();
			registerFilter(filter);
			registerHandler(handler);
		}
		
		/** 注册过滤器 */
		private function registerFilter(filter:IoFilter):void
		{
			this.filter = filter;
		}
		
		/** 注册处理器 */
		public function registerHandler(handler:IoHandler):void
		{
			this.handler = handler;
		}
		
		/** Socket是否连接 */
		public function isConnected():Boolean
		{
			return this.sock.connected;
		}
		
		/** addListener */
		private function addListener():void
		{
			this.sock.addEventListener(Event.CONNECT, onConnectHandler);
			this.sock.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			this.sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			this.sock.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			this.sock.addEventListener(Event.CLOSE, onCloseHandler);
		}
		
		/** removeListener */
		private function removeListener():void
		{
			this.sock.removeEventListener(Event.CONNECT, onConnectHandler);
			this.sock.removeEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			this.sock.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			this.sock.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			this.sock.removeEventListener(Event.CLOSE, onCloseHandler);
		}
		
		/** onConnectHandler */
		private function onConnectHandler(event:Event):void
		{
			Log.info("SocketService::onConnectHandler");
			filter.sessionOpened(this);
			handler.sessionOpened(this);
		}
		
		/** onCloseHandler */
		private function onCloseHandler(event:Event):void
		{
			Log.info("SocketService::onCloseHandler");
			filter.sessionClosed(this);
			handler.sessionClosed(this);
		}
		
		/** onIoErrorHandler */
		private function onIoErrorHandler(event:IOErrorEvent):void
		{
			Log.error("SocketService::onIoErrorHandler");
			filter.exceptionCaught(this, new Error(event.text));
			handler.exceptionCaught(this, new Error(event.text));
		}
		
		
		/** onSecurityErrorHandler */
		private function onSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			Log.error("SocketService::onSecurityErrorHandler");
			filter.exceptionCaught(this, new Error(event.text));
			handler.exceptionCaught(this, new Error(event.text));
		}
		
		
		/** onSocketDataHandler */
		private function onSocketDataHandler(event:ProgressEvent):void
		{
			Log.debug("SocketService::onSocketDataHandler");
			filter.messageReceived(this);
		}
		
		
		/** connect */
		public function connect(host:String=Macro.STR_NULL, port:int=Macro.INT_NULL):void
		{
			if(host != Macro.STR_NULL) { this.host = host; }
			if(port != Macro.INT_NULL) { this.port = port; }
			Log.debug("SocketService::connect(" + this.host + "," + this.port + ")");
			addListener();
			if (this.sock.connected)
			{
				this.sock.close();
			}
			this.sock.connect(this.host, this.port);
		}
		
		/** disconnect */
		public function disconnect():void
		{
			Log.info("SocketService::disconnect");
			removeListener();
			this.sock.close();
		}
		
		/** 安全沙箱问题解决者 */
		private function safeSandboxSolve():void
		{
			Log.info("SocketService::safeSandboxSolve");
			this.sock.connect(this.host, NetConst.HTTPS_PORT);
		}
		
		/** 发送消息 */
		public function sendMessage(message:Object):void
		{
			if(this.sock.connected)
			{
				filter.filterWrite(this, message);
				this.sock.flush();
			}
		}
		
		/** 发送数据 */
		public function sendData(data:ByteArray):void
		{
			if(this.sock.connected)
			{
				this.sock.writeBytes(data);
				this.sock.flush();
			}
		}
		
	}
}