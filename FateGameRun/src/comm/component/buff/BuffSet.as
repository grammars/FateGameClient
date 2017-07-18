package comm.component.buff
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.buff.StBuffSet;
	
	import flash.utils.ByteArray;

	public class BuffSet
	{
		private var list:Vector.<Buff> = new Vector.<Buff>();
		public function getBuffs():Vector.<Buff> { return list; }
		
		public function BuffSet()
		{
		}
		
		/** 获取Buff */
		public function getBuff(id:int):Buff
		{
			for(var i:int = 0; i < list.length; i++)
			{
				if(id == list[i].id)
				{
					return list[i];
				}
			}
			return null;
		}
		
		/** 添加Buff */
		public function addBuff(buff:Buff):Buff
		{
			list.push(buff);
			return buff;
		}
		
		/** 移除Buff */
		public function remove(id:int):Buff
		{
			for(var i:int = 0; i < list.length; i++)
			{
				var item:Buff = list[i];
				if(id == item.id)
				{
					list.splice(i,1);
					return item;
				}
			}
			return null;
		}
		
		private function build():void
		{
		}
		
		/** 导入结构数据 */
		public function importData(data:StBuffSet):void
		{
			list.length = 0;
			for(var i:int = 0; i < data.items.length; i++)
			{
				var buff:Buff = new Buff();
				buff.importData(data.items[i]);
				list.push(buff);
			}
			build();
		}
	}
}