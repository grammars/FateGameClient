package com.anstu.jsock.filter
{
	import com.anstu.jsock.service.SocketService;

	public class ProtocolCodecFilter extends IoFilterAdapter
	{
		private var factory:ProtocolCodecFactory;
		
		public function ProtocolCodecFilter(factory:ProtocolCodecFactory)
		{
			if(factory == null)
			{
				throw new ArgumentError("factory不能为空", 0);
			}
			this.factory = factory;
		}
		
		override public function messageReceived(service:SocketService):void
		{
			var decoder:ProtocolDecoder = factory.getDecoder();
			decoder.decode(service);
			decoder.dispose(service);
		}
		
		override public function filterWrite(service:SocketService, message:Object):void
		{
			var encoder:ProtocolEncoder = factory.getEncoder();
			encoder.encode(service, message);
			encoder.dispose(service);
		}
		
		override public function sessionClosed(service:SocketService):void
		{
			//
		}
		
	}
}