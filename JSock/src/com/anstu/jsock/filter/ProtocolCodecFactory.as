package com.anstu.jsock.filter
{

	public interface ProtocolCodecFactory
	{
		function getEncoder():ProtocolEncoder;
		
		function getDecoder():ProtocolDecoder;
	}
}