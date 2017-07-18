package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.filter.ProtocolCodecFactory;
	import com.anstu.jsock.filter.ProtocolDecoder;
	import com.anstu.jsock.filter.ProtocolEncoder;
	
	public class FreeByteCodecFactory implements ProtocolCodecFactory
	{
		private var encoder:FreeByteCodecEncoder;
		private var decoder:FreeByteCodecDecoder;
		
		public function FreeByteCodecFactory()
		{
			encoder = new FreeByteCodecEncoder();
			decoder = new FreeByteCodecDecoder();
		}
		
		public function getEncoder():ProtocolEncoder
		{
			return encoder;
		}
		
		public function getDecoder():ProtocolDecoder
		{
			return decoder;
		}
	}
}