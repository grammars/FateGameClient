package com.anstu.jload.past
{
	import flash.display.Loader;
	
	public class RichLoader extends Loader
	{
		public var quest:LoaderQuest;
		
		public function RichLoader(quest:LoaderQuest=null)
		{
			super();
			this.quest = quest;
		}
	}
}