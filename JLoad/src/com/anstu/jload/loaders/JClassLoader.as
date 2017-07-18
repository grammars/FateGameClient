package com.anstu.jload.loaders
{
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Loader;
	import flash.events.Event;
	
	public class JClassLoader extends JDisplayLoader
	{
		
		public function JClassLoader(task:JLoadTask, leader:JLoader)
		{
			super(task, leader);
		}
		
		override protected function handleResult():void
		{
			super.handleResult();
			task.result.value = loader.contentLoaderInfo.applicationDomain;
		}
		
	}
}