package com.anstu.jui.build.template
{
	import com.anstu.jui.components.JComponent;

	public class TemplateInfo
	{
		/** 资源命名空间[编辑器中不被使用] */
		public var assetsNS:String;
		
		public var type:String;
		
		public var name:String
		
		protected var xml:XML;
		
		public function TemplateInfo()
		{
		}
		
		public function parse(name:String, xml:XML):void
		{
			this.name = name;
			this.xml = xml;
		}
		
		protected function AttriVal(key:String):String
		{
			if(xml["@"+key] != undefined)
			{
				return xml["@"+key];
			}
			return null;
		}
		
		public function apply(ui:JComponent):void
		{
			//TODO
		}
		
	}
}