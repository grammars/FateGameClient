package cfg
{
	import central.AbstractManage;
	import central.Centre;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import comm.L;
	import comm.events.FrameworkListener;
	import comm.loading.LoadingScreen;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import gamekit.utils.StrUtils;
	import gamekit.utils.Utils;
	
	public class CfgManage extends AbstractManage
	{
		/** 字段分隔(制表符Z) */
		private const WORD_SEP:String = "┼";
		/** 行分隔 */
		private const LINE_SEP:String = "\n";
		
		/** 下载器 */
		private var jl:JLoader;
		
		private var _loaded:Boolean = false;
		/** get 是否已经加载和解析完毕 */
		public function get loaded():Boolean { return _loaded; }
		/** set 是否已经加载和解析完毕 */
		public function set loaded(value:Boolean):void
		{
			_loaded = value;
			if(_loaded) { FrameworkListener.getInstance().cfgLoaded(); }
		}
		
		
		public function CfgManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			jl = new JLoader();
		}
		
		override public function startup():void
		{
			Log.print("CfgManage::startup()");
			super.startup();
			
			const cfgUrl:String = Centre.RES_ROOT + "tables/bin/release.cfgbin";
			var cfgTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, cfgUrl, false);
			cfgTask.onProgress = __cfgbinLoading;
			cfgTask.onComplete = __cfgbinLoaded;
			cfgTask.onFail = __cfgbinLoadFail;
			jl.add(cfgTask);
			jl.start();
			
			LoadingScreen.getInstance().show();
		}
		
		/** 配置文件下载中 */
		private function __cfgbinLoading(t:JLoadTask):void
		{
			LoadingScreen.getInstance().setProgress(t.status.bytesLoaded, t.status.bytesTotal);
			LoadingScreen.getInstance().setInfo("配置文件下载解析中:" + StrUtils.percent(t.status.bytesLoaded, t.status.bytesTotal));
		}
		
		/** 配置文件成功下载 */
		private function __cfgbinLoaded(t:JLoadTask):void
		{
			Log.debug("下载配置表完成  size:" + t.result.getBinary().bytesAvailable + "字节");
			
			digest(t.result.getBinary());
			process();
			
			LoadingScreen.getInstance().hide();
			startupComplete();
		}
		
		/** 配置文件下载失败 */
		private function __cfgbinLoadFail(t:JLoadTask):void
		{
			Log.debug("下载配置表失败  请检查", t.url);
			LoadingScreen.getInstance().setInfo("下载配置表失败  请检查" + t.url);
			startupComplete();
		}
		
		/** 将字节流转换成所需的配置表数据 */
		private function digest(bytes:ByteArray):void
		{
			bytes.uncompress();
			
			var fileNameLen:int = 0;
			var fileName:String = "";
			var fileContentSize:int = 0;
			var fileContent:String = "";
			while(bytes.bytesAvailable > 0)
			{
				fileNameLen = bytes.readInt();
				if(bytes.bytesAvailable >= fileNameLen + 4)
				{
					fileName = bytes.readMultiByte(fileNameLen, "UTF-8");
				}
				else
				{
					Log.error("ConfigDigest::digest 失败 ： 非法的cfgbin");
					break;
				}
				fileContentSize = bytes.readInt();
				if(bytes.bytesAvailable >= fileContentSize)
				{
					fileContent = bytes.readMultiByte(fileContentSize, "UTF-8");
				}
				else
				{
					Log.error("ConfigDigest::digest 失败 ： 非法的cfgbin");
					break;
				}
				
				parse(fileName, fileContent);
				
			}
			
			bytes.clear();
			
			loaded = true;
		}
		
		/** 解析 */
		private function parse(fileName:String, fileContent:String):void
		{
			//trace("【fileName】:" + fileName);
			//trace("【fileContent】:\r" + fileContent + "\r");
			
			var dataDic:Dictionary = new Dictionary();//key:keyname value:valuesArr
			
			var lineArr:Array = fileContent.split(LINE_SEP);
			var itemCount:int = lineArr.length - 1;//-1是因为首行是字段名，并非可用数据
			var keynamesStr:String = lineArr[0];
			var keynamesArr:Array = keynamesStr.split(WORD_SEP);
			var i:int = 0;
			var keyname:String;
			var valuesArr:Array;
			var index2valuesArr:Array = new Array();
			for(i = 0; i < keynamesArr.length; i++)
			{
				keyname = keynamesArr[i];
				//trace("keyname=", keyname);
				valuesArr = new Array();
				dataDic[keyname] = valuesArr;
				index2valuesArr[i] = valuesArr;
			}
			for(i = 1; i <= itemCount; i++)
			{
				var lineStr:String = lineArr[i];
				if(lineStr == ""){ itemCount--; continue; }
				var valuesLine:Array = lineStr.split(WORD_SEP);
				for(var ind:int = 0; ind < valuesLine.length; ind++)
				{
					var value:String = valuesLine[ind];
					valuesArr = index2valuesArr[ind];
					valuesArr.push(value);
				}
			}
			
			const ext:String = ".cfgbuf";
			switch(fileName)
			{
			case SampleCfg.TYPE+ext:
				SampleCfg.parse(dataDic, itemCount);
				break;
			case MapInfoCfg.TYPE+ext:
				MapInfoCfg.parse(dataDic, itemCount);
				break;
			case MapDoorCfg.TYPE+ext:
				MapDoorCfg.parse(dataDic, itemCount);
				break;
			case VocCfg.TYPE+ext:
				VocCfg.parse(dataDic, itemCount);
				break;
			case NpcInfoCfg.TYPE+ext:
				NpcInfoCfg.parse(dataDic, itemCount);
				break;
			case MonsterInfoCfg.TYPE+ext:
				MonsterInfoCfg.parse(dataDic, itemCount);
				break;
			case MonsterPoolCfg.TYPE+ext:
				MonsterPoolCfg.parse(dataDic, itemCount);
				break;
			case BuffCfg.TYPE+ext:
				BuffCfg.parse(dataDic, itemCount);
				break;
			case SkillCfg.TYPE+ext:
				SkillCfg.parse(dataDic, itemCount);
				break;
			case SkillEffCfg.TYPE+ext:
				SkillEffCfg.parse(dataDic, itemCount);
				break;
			case SkillExtAimCfg.TYPE+ext:
				SkillExtAimCfg.parse(dataDic, itemCount);
				break;
			case SkillExtAoeCfg.TYPE+ext:
				SkillExtAoeCfg.parse(dataDic, itemCount);
				break;
			case SkillExtPathCfg.TYPE+ext:
				SkillExtPathCfg.parse(dataDic, itemCount);
				break;
			case SkillTreeCfg.TYPE+ext:
				SkillTreeCfg.parse(dataDic, itemCount);
				break;
			case GoodsBaseCfg.TYPE+ext:
				GoodsBaseCfg.parse(dataDic, itemCount);
				break;
			case GoodsDrugCfg.TYPE+ext:
				GoodsDrugCfg.parse(dataDic, itemCount);
				break;
			case GoodsEquipCfg.TYPE+ext:
				GoodsEquipCfg.parse(dataDic, itemCount);
				break;
			case TaskCfg.TYPE+ext:
				TaskCfg.parse(dataDic, itemCount);
				break;
			}
		}
		
		/** 加工模版表<br>
		 * 部分模版表之间会需要互相引用关联<br>
		 * 比如skill 引用 skill_ext_xxxx表 */
		private function process():void
		{
			SkillCfg.process();
		}
		
	}
}