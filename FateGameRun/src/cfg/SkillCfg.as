package cfg
{
	import com.anstu.jcommon.log.Log;
	
	import comm.define.SkillDef;
	
	import flash.utils.Dictionary;
	
	public class SkillCfg
	{
		public static const TYPE:String = "skill";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillCfg
		{
			return cfgs[id];
		}
		
		private static var array:Array = new Array();
		
		/** id */
		public var id:int = 0;
		/** 技能名 */
		public var name:String = "";
		/** CD时间 */
		public var cdTime:int = 0;
		/** 施放距离 */
		public var useDistance:Number = 0;
		/** 类型 */
		public var type:int = 0;
		/** 效果类型 */
		public var effType:int = 0;
		/** 扩展id */
		public var extId:int = 0;
		/** 作用效果组 */
		public var effsStr:String = "";
		/** buffId */
		public var buffId:int = 0;
		/** 消耗计算方式 */
		public var costType:String = "";
		/** 消耗计算参数 */
		public var costParamsStr:String = "";
		/** icon */
		public var icon:String = "";
		/** 描述 */
		public var desc:String = "";
		
		
		public var extAim:SkillExtAimCfg;
		public var extAoe:SkillExtAoeCfg;
		public var extPath:SkillExtPathCfg;
		
		public var costParams:Vector.<Number>;
		public var effs:Vector.<SkillEffCfg>;
		public var buffCfg:BuffCfg;
		
		public function SkillCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillCfg = new SkillCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["技能名"][i]);
				c.cdTime = parseInt(dataDic["CD时间"][i]);
				c.useDistance = parseFloat(dataDic["施放距离"][i]);
				c.type = parseInt(dataDic["类型"][i]);
				c.effType = parseInt(dataDic["效果类型"][i]);
				c.buffId = parseInt(dataDic["buffId"][i]);
				c.extId = parseInt(dataDic["扩展id"][i]);
				c.costType = (dataDic["消耗计算方式"][i]);
				c.costParamsStr = (dataDic["消耗计算参数"][i]);
				c.icon = (dataDic["icon"][i]);
				c.desc = (dataDic["描述"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
				array.push(c);
			}
		}
		
		/** 加工模版配置 */
		public static function process():void
		{
			for( var i:int = 0; i < array.length; i++ )
			{
				var c:SkillCfg = array[i];
				c.setup();
			}
		}
		
		/** setup */
		private function setup():void
		{
			handleExt();
			handleCost();
			handleEffs();
			handleBuff();
		}
		
		/** 链接扩展配置 */
		private function handleExt():void
		{
			switch(this.type)
			{
			case SkillDef.TYPE_AIM:
				extAim = SkillExtAimCfg.get(extId);
				if(extAim==null) { Log.fatal("找不到id="+extId+"的Aim技能扩展"); }
				break;
			case SkillDef.TYPE_AOE:
				extAoe = SkillExtAoeCfg.get(extId);
				if(extAoe==null) { Log.fatal("找不到id="+extId+"的Aoe技能扩展"); }
				break;
			case SkillDef.TYPE_PATH:
				extPath = SkillExtPathCfg.get(extId);
				if(extPath==null) { Log.fatal("找不到id="+extId+"的Path技能扩展"); }
				break;
			}
		}
		
		/** 解析消耗 */
		private function handleCost():void
		{
			var szParams:Array = costParamsStr.split(";");
			const PARAMS_SIZE:int = szParams.length;
			costParams = new Vector.<Number>();
			for(var i:int = 0; i < PARAMS_SIZE; i++)
			{
				costParams.push( parseFloat(szParams[i]) );
			}
		}
		
		/** 处理技能效用 */
		private function handleEffs():void
		{
			var szEffs:Array = effsStr.split(",");
			const EFFS_SIZE:int = szEffs.length;
			effs = new Vector.<SkillEffCfg>();
			for(var i:int = 0; i < EFFS_SIZE; i++)
			{
				var effId:int = parseInt(szEffs[i]);
				effs.push( SkillEffCfg.get(effId) );
			}
			
		}
		
		/** 链接buff配置 */
		private function handleBuff():void
		{
			buffCfg = BuffCfg.get(this.buffId);
		}
		
		public function toString():String
		{
			return "[SkillCfg] id:" + id + " name:" + name + " cdTime=" + cdTime + " useDistance=" + useDistance
				+ " type=" + type + " effType=" + effType + " extId=" + extId + " buffId=" + buffId + " costType=" + costType
				+ " costParamsStr=" + costParamsStr + " icon=" + icon + " desc=" + desc;
		}
		
	}
}