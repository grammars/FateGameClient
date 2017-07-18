package ui.view.icon
{
	import comm.component.skill.SkillItem;
	
	import flash.display.Sprite;
	
	public class Icon extends Sprite
	{
		/** 类型::无数据 */
		public static const TYPE_NULL:int = 0;
		/** 类型::道具 */
		public static const TYPE_GOODS:int = 1;
		/** 类型::装备 */
		public static const TYPE_WEAPON:int = 2;
		/** 类型::技能 */
		public static const TYPE_SKILL:int = 3;
		/** 类型::未定义 */
		public static const TYPE_UNDEFINED:int = 99;
		
		/** 数据类型 */
		protected var type:int = 0;
		
		/** 被填充的数据 */
		protected var data:Object;
		
		protected function skillData():SkillItem { return data as SkillItem; }
		
		public function Icon()
		{
			super();
		}
		
		/** 填充数据 */
		public function fill(data:Object):void
		{
			this.data = data;
			if(data == null)
			{
				this.type = TYPE_NULL;
			}
			else if(data is SkillItem)
			{
				this.type = TYPE_SKILL;
			}
			else
			{
				this.type = TYPE_UNDEFINED;
			}
			
			paint();
		}
		
		/** 绘制
		 * @Override */
		protected function paint():void
		{
			//ToDo
		}
		
	}
}