package builder.view
{
	import builder.Builder;
	import builder.view.assets.AssetsCompiler;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.PicEncoder;
	import builder.view.assets.browser.AssetsBrowser;
	import builder.view.assets.browser.AssetsNCard;
	import builder.view.assets.browser.BrowserEvent;
	import builder.view.assets.oper.AddBmdSure;
	import builder.view.assets.oper.AddG9BmdSure;
	import builder.view.assets.oper.AddPackSure;
	import builder.view.assets.oper.MapPackOper;
	import builder.view.base.CrystalBtn;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JCheckBoxSkin;
	import com.anstu.jui.skin.JPushButtonSkin;
	import com.anstu.jui.skin.JSliderSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/** ui资源操作面板 */
	public class AssetsPop extends Popup
	{
		private static var _instance:AssetsPop;
		public static function get instance():AssetsPop
		{
			if(_instance == null) { _instance = new AssetsPop(); }
			return _instance;
		}
		
		/** 添加普通图 */
		private var addBmdBtn:CrystalBtn;
		/** 添加九宫图 */
		private var addG9BmdBtn:CrystalBtn;
		/** 添加包 */
		private var addPackBtn:CrystalBtn;
		/** 映射包 */
		private var mapPackBtn:CrystalBtn;
		/** 移除 */
		private var removeBtn:CrystalBtn;
		/** 保存资源档案 */
		private var saveDocBtn:CrystalBtn;
		/** 选作资源图 */
		private var selectPicBtn:CrystalBtn;
		/** 编译按钮 */
		private var compileBtn:CrystalBtn;
		
		/** 资源获取请求 assetReqs(node:AssetsNode) */
		public var assetReqs:Function = null;
		
		public function AssetsPop()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			addBmdBtn = createOperBtn("添加普通图", __addBmdBtn, 15, 35);
			addG9BmdBtn = createOperBtn("添加九宫图", __addG9BmdBtn, 120, 35);
			addPackBtn = createOperBtn("添加包", __addPackBtn, 225, 35);
			mapPackBtn = createOperBtn("映射包", __mapPackBtn, 330, 35);
			removeBtn = createOperBtn("删除", __removeBtn, 435, 35);
			selectPicBtn = createOperBtn("选作资源图", __selectPicBtn, 540, 35);
			saveDocBtn = createOperBtn("保存资源档案", __saveDocBtn, 645, 35);
			compileBtn = createOperBtn("编译资源", __complieBtn, 750, 35);
			
			AssetsBrowser.instance.setSize(870, 500);
			AssetsBrowser.instance.move(15, 65);
			this.addChild(AssetsBrowser.instance);
			AssetsBrowser.instance.browse(Builder.assetsDoc.rootNode);
			
			setSize(900, 600);
			setTitle("UI资源");
		}
		
		private function createOperBtn(label:String, handler:Function, px:int, py:int):CrystalBtn
		{
			var btn:CrystalBtn = new CrystalBtn(label, handler, 100, 25);
			btn.move(px, py);
			this.addChild(btn);
			return btn;
		}
		
		override public function hide():void
		{
			assetReqs = null;
			super.hide();
		}
		
		private function __addBmdBtn(e:MouseEvent):void
		{
			AddBmdSure.instance.show();
		}
		
		private function __addG9BmdBtn(e:MouseEvent):void
		{
			AddG9BmdSure.instance.show();
		}
		
		private function __addPackBtn(e:MouseEvent):void
		{
			AddPackSure.instance.show();
		}
		
		private function __mapPackBtn(e:MouseEvent):void
		{
			MapPackOper.select();
		}
		
		private function __removeBtn(e:MouseEvent):void
		{
			var sel:AssetsNode = AssetsBrowser.instance.getSelectNode();
			if(sel)
			{
				Alert.instance.sure(doRemoveNode, "确认要删除<font color='#de3333'>" + sel.name + "</font>？", "删除");
			}
			else
			{
				StatusBar.instance.show("请选择一个要删除的节点");
			}
		}
		
		private function doRemoveNode():void
		{
			AssetsBrowser.instance.removeSelect();
		}
		
		private function __selectPicBtn(e:MouseEvent):void
		{
			var tarNode:AssetsNode = AssetsBrowser.instance.getSelectNode();
			handleAssetReq(tarNode);
		}
		
		/** 节点卡牌被双击 */
		public function nodeCardDClick(card:AssetsNCard):void
		{
			if(assetReqs != null && card.node.isPack==false)
			{
				handleAssetReq(card.node);
			}
			else
			{
				AssetsBrowser.instance.browse(card.node);
			}
		}
		
		/** 处理资源请求 */
		private function handleAssetReq(tarNode:AssetsNode):void
		{
			if( tarNode && tarNode.isPack==false )
			{
				if(assetReqs != null)
				{
					assetReqs(tarNode);
					this.hide();
					StatusBar.instance.show("已选择" + tarNode.itemCls);
				}
				else
				{
					StatusBar.instance.show("不需要选择图片节点");
				}
			}
			else
			{
				StatusBar.instance.show("尚未选择图片节点");
			}
		}
		
		private function __saveDocBtn(e:MouseEvent):void
		{
			Builder.assetsDoc.exportCfgFile();
		}
		
		private function __complieBtn(e:MouseEvent):void
		{
			var content:String = "是否立刻编译UI资源？\r编译资源将需要等待较长时间，时间根据资源数目线性增长。";
			Alert.instance.sure(compileHandler, content, "确定");
		}
		
		private function compileHandler():void
		{
			AssetsCompiler.comp();
		}
		
	}
}