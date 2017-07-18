package comm.component.cd
{
	import comm.struct.cd.StCDInfo;
	import comm.struct.cd.StCDUint;
	
	import gamekit.utils.Utils;
	
	public class CDUnit extends StCDUint
	{
		/** CD类型{物品} */
		public static const T_GOODS:int = 0;//byte
		/** CD类型{技能} */
		public static const T_SKILL:int = 1;//byte
		
		public function CDUnit()
		{
			super();
		}
		
		/** 设置CD时间 */
		public function setCD(cdi:StCDInfo):void
		{
			if(cdi.type == T_GOODS)
			{
				goods.put(cdi.id, cdi);
			}
			else if(cdi.type == T_SKILL)
			{
				skill.put(cdi.id, cdi);
			}
		}
		
		/** 获取CD剩余时间
		 * 如果已完成CD，则顺便充CD池中移除 */
		public function getCD(type:int, id:int):int
		{
			var cdi:StCDInfo = getCDInfo(type, id);
			if(cdi == null) { return 0; }
			var now:Number = Utils.now();
			if(now > cdi.finishTime)
			{
				removeCD(type, id);
			}
			var leftCDTime:int = (cdi.finishTime-now);
			return leftCDTime;
		}
		
		/** 获取CD信息 */
		public function getCDInfo(type:int, id:int):StCDInfo
		{
			var cdi:StCDInfo = null;
			if(type == T_GOODS)
			{
				cdi = goods.get(id) as StCDInfo;
			}
			else if(type == T_SKILL)
			{
				cdi = skill.get(id) as StCDInfo;
			}
			return cdi;
		}
		
		/** 是否可用，即cd时间已经完成 */
		public function available(type:int, id:int):Boolean
		{
			var cdt:int = getCD(type, id);
			return cdt <= 0;
		}
		
		/** 移除指定CD */
		public function removeCD(type:int, id:int):void
		{
			if(type == T_GOODS)
			{
				goods.remove(id);
			}
			else if(type == T_SKILL)
			{
				skill.remove(id);
			}
		}
		
		/** build */
		protected function build():void
		{
			//
		}
		
		/** 导入结构数据 */
		public function importData(data:StCDUint):void
		{
			this.goods = data.goods;
			this.skill = data.skill;
			build();
		}
	}
}