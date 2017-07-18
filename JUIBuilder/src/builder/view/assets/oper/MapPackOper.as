package builder.view.assets.oper
{
	import builder.Builder;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsBrowser;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;

	public class MapPackOper
	{
		public function MapPackOper()
		{
		}
		
		private static var _firstBrowse:Boolean = true;
		public static function select():void
		{
			var file:File;
			if(_firstBrowse)
			{
				file = new File(Builder.assetsDirFull());
				_firstBrowse = false;
			}
			else
			{
				file = new File();
			}
			file.addEventListener(Event.SELECT, __packSelected);
			file.browseForDirectory("请选择一个目录");
		}
		
		private static function __packSelected(e:Event):void
		{
			var file:File = e.target as File;
			trace("选择了目录：" + file.nativePath);
			var pNode:AssetsNode = AssetsBrowser.instance.getCurNode();
			if(pNode == null)
			{
				pNode = new AssetsNode(true);
				pNode.name = file.name;
			}
			mappingFileToNode(file, pNode);
			Builder.assetsDoc.exportCfgFile();
			AssetsBrowser.instance.refresh();
		}
		
		private static function mappingFileToNode(dir:File, packNode:AssetsNode):void
		{
			var files:Array = dir.getDirectoryListing();
			for(var i:int = 0; i < files.length; i++)
			{
				var file:File = files[i];
				if(file.isDirectory)
				{
					var pn:AssetsNode = new AssetsNode(true);
					pn.name = file.name;
					packNode.addChild(pn);
					mappingFileToNode(file, pn);
				}
				else
				{
					var cn:AssetsNode = new AssetsNode(false);
					cn.name = file.name.replace("."+file.extension, "");
					cn.setup(cn.name, Builder.makeAssetsClassName(file.nativePath), Builder.makeAssetsRePath(file.nativePath), false);
					packNode.addChild(cn);
				}
			}
		}
		
	}
}