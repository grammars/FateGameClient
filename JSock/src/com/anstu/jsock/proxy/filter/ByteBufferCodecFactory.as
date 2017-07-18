package com.anstu.jsock.proxy.filter
{
	import com.anstu.jsock.filter.ProtocolCodecFactory;
	import com.anstu.jsock.filter.ProtocolDecoder;
	import com.anstu.jsock.filter.ProtocolEncoder;
	
	public class ByteBufferCodecFactory implements ProtocolCodecFactory
	{
		private var encoder:ByteBufferCodecEncoder;
		private var decoder:ByteBufferCodecDecoder;
		
		public function ByteBufferCodecFactory()
		{
			encoder = new ByteBufferCodecEncoder();
			decoder = new ByteBufferCodecDecoder();
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