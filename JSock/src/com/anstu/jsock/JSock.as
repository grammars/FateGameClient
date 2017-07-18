package com.anstu.jsock
{
	import com.anstu.jsock.filter.ProtocolCodecFactory;
	import com.anstu.jsock.filter.ProtocolCodecFilter;
	import com.anstu.jsock.handler.IoHandler;
	import com.anstu.jsock.handler.IoHandlerAdapter;
	import com.anstu.jsock.service.SocketService;

	public class JSock
	{
		public static const VERSION:String = "1.0.0";
		
		public function JSock()
		{
		}
		
		/** 创建socket服务 */
		public static function createService(factory:ProtocolCodecFactory, handler:IoHandler):SocketService
		{
			var filter:ProtocolCodecFilter = new ProtocolCodecFilter(factory);
			var service:SocketService = new SocketService(filter, handler);
			return service;
		}
		
	}
}