package com.anstu.jui.build.doc
{
	import com.anstu.jui.components.JRadioGroup;

	public class DocRadioGroups
	{
		private static var _instance:DocRadioGroups;
		public static function get instance():DocRadioGroups
		{
			if(_instance == null) { _instance = new DocRadioGroups(); }
			return _instance;
		}
		
		private var groups:Vector.<JRadioGroup> = new Vector.<JRadioGroup>();
		
		public function getGroups():Vector.<JRadioGroup> { return groups; }
		
		public function DocRadioGroups()
		{
		}
		
		/** 获取组 */
		public function getGroup(name:String):JRadioGroup
		{
			for(var i:int = 0; i < groups.length; i++)
			{
				if(name == groups[i].name)
				{
					return groups[i];
				}
			}
			return null;
		}
		
		/** 添加组 */
		public function addGroup(group:JRadioGroup):void
		{
			groups.push(group);
		}
		
		/** 移除组 */
		public function removeGroup(name:String):JRadioGroup
		{
			for(var i:int = groups.length-1; i >= 0; i--)
			{
				if(name == groups[i].name)
				{
					var g:JRadioGroup = groups[i];
					groups.splice(i, 1);
					return g;
				}
			}
			return null;
		}
		
		/** 该名称的组的index */
		public function checkGroupIndex(name:String):int
		{
			for(var i:int = groups.length-1; i >= 0; i--)
			{
				if(name == groups[i].name) { return i; }
			}
			return -1;
		}
		
		/** 清空组 */
		public function clearGroups():void
		{
			groups.length = 0;
		}
		
	}
}