package builder
{
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsNCard;
	
	import com.anstu.jui.build.pack.PackItem;
	import com.anstu.jui.build.pack.PackTool;
	import com.codeazur.as3swf.utils.ObjCUtils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class Packer
	{
		public function Packer()
		{
		}
		
		/** 存档(包括docs,templates,assets) */
		public static function zip():void
		{
			bakAssetsAndExport();
			
			export(Builder.docDirFull(), Builder.projName+"_docs.zlib");
			export(Builder.templatesDirFull(), Builder.projName+"_templates.zlib");
			exportAssetsCfg(Builder.projName+"_assets.zlib");
		}
		
		/** 备份原有的assets.xml并导出新的assets.xml */
		private static function bakAssetsAndExport():void
		{
			var assetsXmlFile:File = new File(Builder.assetsCfgFileFull());
			var fs:FileStream = new FileStream();
			fs.open(assetsXmlFile, FileMode.READ);
			var assetsXmlContent:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			fs.close();
			
			var date:Date = new Date();
			var timeStr:String = "" + date.fullYear + "_" + (date.month+1) + "_" + date.date + "_" + date.hours + "_" + date.minutes + "_" + date.seconds;
			var assetsBakFileName:String = assetsXmlFile.name + "." + timeStr + ".xml";
			var assetsBakFile:File = new File(Builder.assetsCfgBakFull() + assetsBakFileName);
			fs.open(assetsBakFile, FileMode.WRITE);
			fs.writeMultiByte(assetsXmlContent, "UTF-8");
			fs.close();
			
			Builder.assetsDoc.exportCfgFile();
		}
		
		private static function export(dir:String, packName:String):void
		{
			var i:int = 0;
			var fs:FileStream;
			var fileName:String;
			var fileNameBytes:ByteArray;
			var fileContent:String;
			var fileContentBytes:ByteArray;
			
			var docDir:File = new File(dir);
			var docList:Array = docDir.getDirectoryListing();
			
			var packItems:Vector.<PackItem> = new Vector.<PackItem>();
			
			for(i = 0; i < docList.length; i++)
			{
				var docFile:File = docList[i];
				if(docFile.isDirectory==false && docFile.extension==Builder.EXT)
				{
					var item:PackItem = new PackItem();
					fs = new FileStream();
					fs.open(docFile, FileMode.READ);
					item.name = docFile.name.replace("."+Builder.EXT, "");
					item.content = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
					packItems.push(item);
				}
			}
			
			var docBytes:ByteArray = PackTool.encode(packItems);
			
			var docOut:File = new File(Builder.outputDirFull() + packName);
			fs = new FileStream();
			fs.open(docOut, FileMode.WRITE);
			fs.writeBytes(docBytes);
			fs.close();
		}
		
		private static function exportAssetsCfg(fileName:String):void
		{
			var store:String = '<?xml version="1.0" encoding="UTF-8"?>\r\n';
			store += '<config>\r\n';
			store += '<property ns="'+Builder.projName+'" url="'+Builder.assetsSwfName+'"/>\r\n';
			store += '<list>\r\n';
			store += writeNode(Builder.assetsDoc.rootNode);
			store += '</list>\r\n';
			store += '</config>';
			trace("store=", store);
			
			var sb:ByteArray = new ByteArray();
			sb.writeMultiByte(store, "UTF-8");
			sb.compress();
			
			var docOut:File = new File(Builder.outputDirFull() + fileName);
			var fs:FileStream = new FileStream();
			fs.open(docOut, FileMode.WRITE);
			fs.writeBytes(sb);
			fs.close();
		}
		
		private static function writeNode(parent:AssetsNode):String
		{
			var content:String = "";
			for(var i:int = 0; i < parent.children.length; i++)
			{
				var node:AssetsNode = parent.children[i];
				if(node.isPack)
				{
					content += writeNode(node);
				}
				else
				{
					content += node.toPackStr() + "\r\n";
				}
			}
			return content;
		}
		
	}
}