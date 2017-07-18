package cfg
{
	import com.anstu.jcommon.def.Macro;
	
	import flash.utils.Dictionary;
	
	import gamekit.ds.pair.PairIntInt;
	import gamekit.utils.StrParser;

	public class TaskCfg
	{
		public static const TYPE:String = "task";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):TaskCfg
		{
			return cfgs[id];
		}
		
		/** 无意义的任务事务 */
		public static const ACT_NULL:int = 0;
		/** 跟NPC对话的任务事务 */
		public static const ACT_TALK_NPC:int = 1;
		/** 杀怪物的任务事务 */
		public static const ACT_KILL_MONSTER:int = 2;
		/** 收集物品的任务事务 */
		public static const ACT_COLLECT:int = 3;
		/** 通过副本的任务事务 */
		public static const ACT_PASS_ZONE:int = 4;
		
		/** id */
		public var id:int = 0;
		/** 事务类型 */
		public var actType:int = 0;
		/** 任务名称 */
		public var name:String = "";
		/** 任务描述 */
		public var desc:String = "";
		/** 等级要求下限 */
		public var levMinReq:int = 0;
		/** 等级要求上限 */
		public var levMaxReq:int = 0;
		/** 前置任务 */
		public var prevTaskId:int = -1;
		/** 下一个任务 */
		public var nextTaskId:int = -1;
		/** 接任务npc */
		public var begNpc:int = 0;
		/** 交任务npc */
		public var endNpc:int = 0;
		/** 目标npcId */
		public var tarNpcId:int = 0;
		/** 目标怪物id */
		public var tarMonsterId:int = 0;
		/** 目标怪物数量 */
		public var tarMonsterNum:int = 0;
		/** 目标物品id */
		public var tarGoodsId:int = 0;
		/** 目标物品数量 */
		public var tarGoodsNum:int = 0;
		/** 目标副本id */
		public var tarZoneId:int = 0;
		/** 奖励经验 */
		public var rwdExp:int = 0;
		/** 奖励铜钱 */
		public var rwdCoins:int = 0;
		/** 奖励绑定铜钱 */
		public var rwdBindCoins:int = 0;
		/** 奖励元宝 */
		public var rwdIngot:int = 0;
		/** 奖励绑定元宝 */
		public var rwdBindIngot:int = 0;
		/** 奖励物品 */
		public var rwdGoodsStr:String = "";//形如9100341:2#9100342:13
		/** 接任务对话 */
		public var taskAcceptTalk:String = "";
		/** 任务中对话 */
		public var taskDoingTalk:String = "";
		/** 任务完成对话 */
		public var taskDoneTalk:String = "";
		
		/** 奖励物品 */
		public var rwdGoodsList:Vector.<PairIntInt>;
		
		public function TaskCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:TaskCfg = new TaskCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.actType = parseInt(dataDic["事务类型"][i]);
				c.name = (dataDic["任务名称"][i]);
				c.desc = (dataDic["任务描述"][i]);
				c.levMinReq =  parseInt(dataDic["等级要求下限"][i]);
				c.levMaxReq =  parseInt(dataDic["等级要求上限"][i]);
				c.prevTaskId =  parseInt(dataDic["前置任务"][i]);
				c.nextTaskId =  parseInt(dataDic["下一个任务"][i]);
				c.begNpc = parseInt(dataDic["接任务npc"][i]);
				c.endNpc = parseInt(dataDic["交任务npc"][i]);
				
				c.tarNpcId = parseInt(dataDic["目标npcId"][i]);
				c.tarMonsterId = parseInt(dataDic["目标怪物id"][i]);
				c.tarMonsterNum = parseInt(dataDic["目标怪物数量"][i]);
				c.tarGoodsId = parseInt(dataDic["目标物品id"][i]);
				c.tarGoodsNum = parseInt(dataDic["目标物品数量"][i]);
				c.tarZoneId = parseInt(dataDic["目标副本id"][i]);
				
				c.rwdExp = parseInt(dataDic["奖励经验"][i]);
				c.rwdCoins = parseInt(dataDic["奖励铜钱"][i]);
				c.rwdBindCoins = parseInt(dataDic["奖励绑定铜钱"][i]);
				c.rwdIngot = parseInt(dataDic["奖励元宝"][i]);
				c.rwdBindIngot = parseInt(dataDic["奖励绑定元宝"][i]);
				c.rwdGoodsStr = dataDic["奖励物品"][i];
				
				c.taskAcceptTalk = dataDic["接任务对话"][i];
				c.taskDoingTalk = dataDic["任务中对话"][i];
				c.taskDoneTalk = dataDic["任务完成对话"][i];
				
				c.digest();
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		private function digest():void
		{
			if(rwdGoodsStr)
			{
				rwdGoodsList = StrParser.toIntIntPair(rwdGoodsStr);
			}
		}
		
		public function typeStr():String
		{
			return "主线任务";
		}
		
		public function toString():String
		{
			return "[TaskCfg] id:" + id + " name:" + name + " desc:" + desc
				+ " nextTaskId:" + nextTaskId + " tarNpcId:" + tarNpcId
				+ " tarMonsterId:" + tarMonsterId + " tarMonsterNum:" + tarMonsterNum
				+ " tarGoodsId:" + tarGoodsId + " tarGoodsNum:" + tarGoodsNum
				+ " tarZoneId:" + tarZoneId + " rwdExp:" + rwdExp
				+ " rwdCoins:" + rwdCoins + " rwdBindCoins:" + rwdBindCoins
				+ " rwdIngot:" + rwdIngot + " rwdBindIngot:" + rwdBindIngot
				+ " rwdGoodsStr:" + rwdGoodsStr;
		}
	}
}