package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.filter.ProtocolCodecFactory;
	import com.anstu.jsock.filter.ProtocolDecoder;
	import com.anstu.jsock.filter.ProtocolEncoder;
	
	public class DlgCodecFactory implements ProtocolCodecFactory
	{
		private var encoder:DlgCodecEncoder;
		private var decoder:DlgCodecDecoder;
		
		public function DlgCodecFactory()
		{
			encoder = new DlgCodecEncoder();
			decoder = new DlgCodecDecoder();
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