package com.anstu.jload.past
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class DataLoader extends URLLoader
	{
		public var quest:LoaderQuest;
		
		public function DataLoader(request:URLRequest=null, quest:LoaderQuest=null)
		{
			super(request);
			this.quest = quest;
		}
		
	}
}