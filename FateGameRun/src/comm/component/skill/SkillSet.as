package comm.component.skill
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.skill.StSkillItem;
	import comm.struct.skill.StSkillSet;
	
	import flash.utils.ByteArray;

	public class SkillSet
	{
		/** 技能项 */
		public var items:Vector.<SkillItem> = new Vector.<SkillItem>();
		
		public function SkillSet()
		{
		}
		
		/** 获得默认技能 */
		public function defaultSkill():SkillItem
		{
			if(items.length > 0) { return items[0]; }
			return null;
		}
		
		/** 导入结构数据 */
		public function importData(data:StSkillSet):void
		{
			items.length = 0;
			var num:int = data.items.length;
			for(var i:int = 0; i < num; i++)
			{
				var st:StSkillItem = data.items[i];
				var item:SkillItem = new SkillItem();
				item.importData(st);
				items.push(item);
			}
		}
		
	}
}