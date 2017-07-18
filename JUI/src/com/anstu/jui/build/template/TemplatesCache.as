package com.anstu.jui.build.template
{
	import com.anstu.jui.build.template.info.*;
	import com.anstu.jui.define.JuiType;

	public class TemplatesCache
	{
		private static var infos:Vector.<TemplateInfo> = new Vector.<TemplateInfo>();
		
		public function TemplatesCache()
		{
		}
		
		/** 清空模版信息 */
		public static function clearInfos():void
		{
			infos.length = 0;
		}
		
		/** 置入模版信息 */
		public static function putInfo(info:TemplateInfo):void
		{
			if(info != null)
			{
				infos.push(info);
			}
		}
		
		/** 根据名字获取模版信息 */
		public static function getInfo(name:String):TemplateInfo
		{
			for(var i:int = 0; i < infos.length; i++)
			{
				if(infos[i].name == name)
				{
					return infos[i];
				}
			}
			return null;
		}
		
		/** 获取某一类型的全部模版信息 */
		public static function getInfos(type:String):Vector.<TemplateInfo>
		{
			var result:Vector.<TemplateInfo> = new Vector.<TemplateInfo>();
			for(var i:int = 0; i < infos.length; i++)
			{
				if(infos[i].type == type)
				{
					result.push(infos[i]);
				}
			}
			return result;
		}
		
		/** 解析 */
		public static function parse(name:String, content:String, assetsNS:String=null):TemplateInfo
		{
			var xml:XML = XML(content);
			var type:String = xml.name();
			var ti:TemplateInfo;
			switch(type)
			{
			case JuiType.JLabel:
				ti = new TiLabel();
				break;
			case JuiType.JTitle:
				ti = new TiTile();
				break;
			case JuiType.JPushButton:
				ti = new TiPushButton();
				break;
			case JuiType.JScrollBarH:
				ti = new TiScrollBarH();
				break;
			case JuiType.JScrollBarV:
				ti = new TiScrollBarV();
				break;
			}
			if(ti)
			{
				ti.parse(name, xml);
				ti.assetsNS = assetsNS;
			}
			return ti;
		}
		
	}
}