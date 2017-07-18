package builder.view.assets.browser
{
	import builder.Builder;
	import builder.BuilderCfg;
	import builder.view.StatusBar;
	import builder.view.assets.AssetsNode;
	
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.events.MouseEvent;
	
	public class AssetsBrowser extends JPanel
	{
		private static var _instance:AssetsBrowser;
		public static function get instance():AssetsBrowser
		{
			if(_instance == null) { _instance = new AssetsBrowser(); }
			return _instance;
		}
		
		/** 地址栏 */
		private var addrBar:AssetsAddrBar;
		/** 内容框 */
		private var main:JScrollPanel;
		
		/** 当前节点 */
		private var curNode:AssetsNode;
		public function getCurNode():AssetsNode { return curNode; }
		/** 当前选中的节点卡片 */
		private var curCard:AssetsNCard;
		public function getSelectNode():AssetsNode
		{
			if(curCard && curCard.node) { return curCard.node; }
			return null;
		}
		
		private var cards:Vector.<AssetsNCard> = new Vector.<AssetsNCard>();
		
		public function AssetsBrowser()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.bgAlpha = 0.2;
			this.bgColor = Builder.DARK_GREY;
			
			addrBar = new AssetsAddrBar(prevHandler, rootHandler, nextHandler);
			addrBar.move(0, 0);
			this.addChild(addrBar);
			
			main = new JScrollPanel();
			new JScrollPanelSkin().apply(main);
			main.setSize(855, 460);
			main.move(0, 25);
			this.addChild(main);
		}
		
		/** 浏览该节点下的东西，如果该节点非包，那么将呈现这张图的数据 */
		public function browse(node:AssetsNode):void
		{
			addrBar.freshAddr(node);
			if(node == null) { return; }
			
			main.clearContent();
			cards.length = 0;
			curCard = null;
			
			this.curNode = node;
			
			const RowCount:int = 5;
			
			if(node.isPack)
			{
				for(var i:int = 0; i < node.children.length; i++)
				{
					var child:AssetsNode = node.children[i];
					var card:AssetsNCard = new AssetsNCard(child);
					var px:int = (card.width+5) * Math.floor(i % RowCount);
					var py:int = (card.height+5) * int(i/RowCount)
					card.move(px+5, py+5);
					main.addChild(card);
					cards.push(card);
				}
			}
			else
			{
				var info:AssetsPicInfo = new AssetsPicInfo(node);
				main.addChild(info);
			}
		}
		
		public function selectCard(card:AssetsNCard):void
		{
			this.curCard = card;
			for(var i:int = 0; i < cards.length; i++)
			{
				var c:AssetsNCard = cards[i];
				c.setSelected( c == card );
			}
		}
		
		private function prevHandler(e:MouseEvent):void
		{
			if(curNode.parent)
			{
				browse(curNode.parent);
			}
		}
		
		private function rootHandler(e:MouseEvent):void
		{
			browseRoot();
		}
		
		private function nextHandler(e:MouseEvent):void
		{
			if(this.curCard)
			{
				browse(this.curCard.node);
			}
		}
		
		public function addNode(node:AssetsNode):void
		{
			this.curNode.addChild(node);
			browse(curNode);
			if(BuilderCfg.assetsAutoSave)
			{
				Builder.assetsDoc.exportCfgFile();
			}
		}
		
		public function removeSelect():void
		{
			if(this.curCard)
			{
				var delNode:AssetsNode = this.curCard.node.removeFromParent();
				refresh();
				if(BuilderCfg.assetsAutoSave)
				{
					Builder.assetsDoc.exportCfgFile();
				}
				StatusBar.instance.show("成功删除节点" + delNode);
			}
			else
			{
				StatusBar.instance.show("未选中需要删除的项");
			}
		}
		
		public function refresh():void
		{
			browse(this.curNode);
		}
		
		public function browseRoot():void
		{
			trace("browseRoot:", Builder.assetsDoc.rootNode.children.length);
			browse(Builder.assetsDoc.rootNode);
		}
		
	}
}