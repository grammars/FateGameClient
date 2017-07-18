package comm.component.data
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.cd.CDUnit;
	import comm.component.goods.bag.BagContainer;
	import comm.component.goods.equip.EquipContainer;
	import comm.component.goods.warehouse.WarehouseContainer;
	import comm.component.practice.PracticeData;
	import comm.component.task.TaskList;
	
	import flash.utils.ByteArray;

	public class HeroData extends PlayerData
	{
		/** 背包 */
		public var bag:BagContainer = new BagContainer();
		/** 装备 */
		public var equip:EquipContainer = new EquipContainer();
		/** 仓库 */
		public var warehouse:WarehouseContainer = new WarehouseContainer();
		/** 修炼 */
		public var practice:PracticeData = new PracticeData();
		/** 任务 */
		public var task:TaskList = new TaskList();
		/** cd */
		public var cd:CDUnit = new CDUnit();
		
		public function HeroData()
		{
			super();
		}
		
	}
}