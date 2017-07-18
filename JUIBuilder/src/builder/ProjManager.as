package builder
{
	import builder.view.ProjPop;
	import builder.view.StatusBar;
	import builder.view.proj.ProjCfg;
	import builder.view.template.TemplateEditor;
	
	import flash.filesystem.File;

	public class ProjManager
	{
		public static var cfgs:Vector.<ProjCfg> = new Vector.<ProjCfg>();
		
		public function ProjManager()
		{
		}
		
		/** 扫描更新proj配置 */
		public static function updateProjCfg():void
		{
			cfgs.length = 0;
			
			var file:File = new File(Builder.appDir());
			var arr:Array = file.getDirectoryListing();
			for(var i:int = 0; i < arr.length; i++)
			{
				var f:File = arr[i];
				if(f.extension == Builder.PROJ_EXT)
				{
					trace("扫描proj配置=" + f.nativePath);
					var c:ProjCfg = new ProjCfg();
					c.readFromFile(f);
					cfgs.push(c);
				}
			}
			
			ProjPop.instance.updateProjItems();
		}
		
		/** 新建项目 */
		public static function create(projName:String):void
		{
			var cfg:ProjCfg = new ProjCfg(projName);
			cfg.create();
			cfgs.push(cfg);
			Builder.projName = projName;
			BuilderCfg.defaultProj = Builder.projName;
			open(projName);
		}
		
		/** 打开一个项目 */
		public static function open(projName:String):void
		{
			trace("打开项目" + projName);
			var find:Boolean = false;
			for(var i:int = 0; i < cfgs.length; i++)
			{
				if(cfgs[i].projName == projName)
				{
					loadProj(cfgs[i]);
					find = true;
					break;
				}
			}
			if(!find)
			{
				StatusBar.instance.show("未找到项目" + projName + ", 新建项目" + projName);
				create(projName);
			}
		}
		
		private static function loadProj(cfg:ProjCfg):void
		{
			BuilderCfg.defaultProj = cfg.projName;
			BuilderCfg.save();
			Builder.closeDoc();
			Builder.projName = cfg.projName;
			Builder.assetsDoc.clear();
			Builder.assetsDoc.importCfgFile();
			TemplateEditor.instance.loadTemplates();
		}
	}
}