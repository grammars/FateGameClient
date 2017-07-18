package builder.view.assets
{
	import builder.Builder;
	import builder.view.assets.browser.AssetsBrowser;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.setTimeout;

	public class AssetsDoc
	{
		public var rootNode:AssetsNode = new AssetsNode(true);
		
		public function AssetsDoc()
		{
		}
		
		/** 清理 */
		public function clear():void
		{
			rootNode.removeChildren();
		}
		
		/** 导入资源配置文件 */
		public function importCfgFile():void
		{
			var file:File = new File(Builder.assetsDirFull() + "assets.xml");
			if(!file.exists)
			{
				exportCfgFile();
			}
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var fileStr:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			//trace("导入资源配置文件" + fileStr);
			convertCfgToNodes(fileStr);
			fs.close();
			setTimeout( AssetsBrowser.instance.browseRoot, 1000 );
		}
		
		/** 将配置文件转化为节点 */
		private function convertCfgToNodes(cfgStr:String):void
		{
			var xml:XML = XML(cfgStr);
			var headXml:XML = xml.head[0];
			var assetsXml:XML = xml.assets[0];
			//trace("headXml=" + headXml.@version);
			//trace("assetsXml=" + assetsXml);
			var nodesXmlList:XMLList = assetsXml.children();
			for each(var nodeXml:XML in nodesXmlList)
			{
				var node:AssetsNode = createNode(nodeXml);
				if(node)
				{
					rootNode.addChild(node);
				}
			}
		}
		
		private function createNode(nodeXml:XML):AssetsNode
		{
			var nodeType:String = nodeXml.name();
			//trace("nodeType:" + nodeType);
			var node:AssetsNode = null;
			
			if(nodeType == "pack")
			{
				node = new AssetsNode(true);
				node.digestXml(nodeXml);
			}
			else if(nodeType == "item")
			{
				node = new AssetsNode(false);
				node.digestXml(nodeXml);
			}
			
			//trace(node);
			
			if(node)
			{
				var subNodesXmlList:XMLList = nodeXml.children();
				for each(var subNodeXml:XML in subNodesXmlList)
				{
					var subNode:AssetsNode = createNode(subNodeXml);
					if(subNode)
					{
						node.addChild(subNode);
					}
				}
			}
			
			return node;
		}
		
		/** 导出资源配置文件 */
		public function exportCfgFile():void
		{
			var file:File = new File(Builder.assetsCfgFileFull());
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			var cfgStr:String = convertNodesToCfg();
			//trace("导出资源配置文件" + cfgStr);
			fs.writeMultiByte(cfgStr, "UTF-8");
			fs.close();
		}
		
		private var nodeXmlStr:String = "";
		/** 将节点转化为配置文件 */
		private function convertNodesToCfg():String
		{
			nodeXmlStr = '<?xml version="1.0" encoding="UTF-8"?>\r<config>\r\r<head version="1.0.0"></head>';
			nodeXmlStr += '\r\r<assets>\r';
			parseNode(rootNode);
			nodeXmlStr += '</assets>\r\r</config>';
			return nodeXmlStr;
		}
		
		private function parseNode(parent:AssetsNode):void
		{
			for(var i:int = 0; i < parent.children.length; i++)
			{
				var node:AssetsNode = parent.children[i];
				if(node.isPack)
				{
					createTab(node.hierarchyIndex()-1);
					nodeXmlStr += '<pack name="'+node.name+'">\r';
					parseNode(node);
					createTab(node.hierarchyIndex()-1);
					nodeXmlStr += '</pack>\r';
				}
				else
				{
					createTab(node.hierarchyIndex()-1);
					if(node.itemSlice == true)
					{
						nodeXmlStr += '<item name="'+node.name+'" cls="'+node.itemCls+'" src="'+node.itemSrc+'" slice="true" left="'+node.itemLeft+'" right="'+node.itemRight+'" top="'+node.itemTop+'" bottom="'+node.itemBottom+'"/>';
					}
					else
					{
						nodeXmlStr += '<item name="'+node.name+'" cls="'+node.itemCls+'" src="'+node.itemSrc+'"/>\r';
					}
				}
			}
		}
		
		private function createTab(tabCount:int):void
		{
			for(var i:int = 0; i < tabCount; i++)
			{
				nodeXmlStr += "\t";
			}
		}
		
		public function getAllNodeUrls():Vector.<String>
		{
			var urls:Vector.<String> = new Vector.<String>();
			retrieveNodesUrl(rootNode, urls);
			
			for(var i:int = 0; i < urls.length; i++)
			{
				trace("节点数据：", urls[i]);
			}
//			return new Vector.<String>();
			return urls;
		}
		
		private function retrieveNodesUrl(parent:AssetsNode, collector:Vector.<String>):void
		{
			for(var i:int = 0; i < parent.children.length; i++)
			{
				var node:AssetsNode = parent.children[i];
				if(node.isPack)
				{
					retrieveNodesUrl(node, collector);
				}
				else
				{
					collector.push(node.itemSrc);
				}
			}
		}
		
	}
}