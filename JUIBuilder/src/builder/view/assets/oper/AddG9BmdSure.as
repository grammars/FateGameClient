package builder.view.assets.oper
{
	import builder.Builder;
	import builder.view.Alert;
	import builder.view.StatusBar;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsBrowser;
	import builder.view.assets.browser.G9Wrap;
	import builder.view.base.ColorChooser;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	public class AddG9BmdSure extends Popup
	{
		private static var _instance:AddG9BmdSure;
		public static function get instance():AddG9BmdSure
		{
			if(_instance == null) { _instance = new AddG9BmdSure(); }
			return _instance;
		}
		
		private var node:AssetsNode = new AssetsNode(false);
		
		private var scr:JScrollPanel = new JScrollPanel();
		private var browseBtn:CrystalBtn;
		private var applyNodeBtn:CrystalBtn;
		private var addBtn:CrystalBtn;
		
		private var g9wrap:G9Wrap = new G9Wrap();
		private var leftInput:CrystalInput;
		private var rightInput:CrystalInput;
		private var topInput:CrystalInput;
		private var bottomInput:CrystalInput;
		
		public function g9Changed():void
		{
			leftInput.text = g9wrap.getLeft().toString();
			rightInput.text = g9wrap.getRight().toString();
			topInput.text = g9wrap.getTop().toString();
			bottomInput.text = g9wrap.getBottom().toString();
		}
		
		protected var _name:String;
		protected var _itemCls:String;
		protected var _itemSrc:String;
		protected var _itemSlice:Boolean = true;
		protected var _itemLeft:int;
		protected var _itemRight:int;
		protected var _itemTop:int;
		protected var _itemBottom:int;
		
		private var nodeInfoLabel:CrystalLabel;
		
		public function AddG9BmdSure()
		{
			super();
			
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			this.setSize(800, 600);
			this.setTitle("添加九宫图");
			
			new JScrollPanelSkin().apply(scr);
			//scr.useFrame = true;
			scr.fillBackground(null);
			scr.setSize(600, 450);
			scr.move(20, 50);
			this.addChild(scr);
			
			var cc:ColorChooser = new ColorChooser(__bgColorChange);
			cc.move(20, 520);
			this.addChild(cc);
			
			browseBtn = new CrystalBtn("选 择 图 片 . . .", __browseBtn, 120, 30);
			browseBtn.move(650, 50);
			this.addChild(browseBtn);
			
			applyNodeBtn = new CrystalBtn("应用到节点", __applyNodeBtn, 120, 30);
			applyNodeBtn.move(650, 90);
			this.addChild(applyNodeBtn);
			
			//-------left right top bottom params--beg
			var leftLabel:CrystalLabel = new CrystalLabel("left:", 60, 25);
			leftLabel.move(650, 130);
			this.addChild(leftLabel);
			leftInput = new CrystalInput("-", 60, 25);
			leftInput.addEventListener(Event.CHANGE, __sliceParamEntered);
			leftInput.move(710, 130);
			this.addChild(leftInput);
			
			var rightLabel:CrystalLabel = new CrystalLabel("right:", 60, 25);
			rightLabel.move(650, 155);
			this.addChild(rightLabel);
			rightInput = new CrystalInput("-", 60, 25);
			rightInput.addEventListener(Event.CHANGE, __sliceParamEntered);
			rightInput.move(710, 155);
			this.addChild(rightInput);
			
			var topLabel:CrystalLabel = new CrystalLabel("top:", 60, 25);
			topLabel.move(650, 180);
			this.addChild(topLabel);
			topInput = new CrystalInput("-", 60, 25);
			topInput.addEventListener(Event.CHANGE, __sliceParamEntered);
			topInput.move(710, 180);
			this.addChild(topInput);
			
			var bottomLabel:CrystalLabel = new CrystalLabel("bottom:", 60, 25);
			bottomLabel.move(650, 205);
			this.addChild(bottomLabel);
			bottomInput = new CrystalInput("-", 60, 25);
			bottomInput.addEventListener(Event.CHANGE, __sliceParamEntered);
			bottomInput.move(710, 205);
			this.addChild(bottomInput);
			//-------left right top bottom params--end
			
			addBtn = new CrystalBtn("添加节点", __addBtn, 120, 30);
			addBtn.move(650, 240);
			this.addChild(addBtn);
			
			nodeInfoLabel = new CrystalLabel("节点信息：", 520, 75, 14);
			//nodeInfoLabel.useFrame = true;
			nodeInfoLabel.move(250, 515);
			this.addChild(nodeInfoLabel);
		}
		
		override public function show():void
		{
			clearPic();
			printNode();
			super.show();
		}
		
		private function clearPic():void
		{
			node.clear();
			g9wrap.setContent(null);
		}
		
		private function __bgColorChange(color:uint):void
		{
			scr.bgColor = color;
		}
		
		private var _firstBrowse:Boolean = true;
		private function __browseBtn(e:MouseEvent):void
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
			file.addEventListener(Event.SELECT, __picSelected);
			file.browse();
		}
		
		private function __picSelected(e:Event):void
		{
			var file:File = e.target as File;
			var url:String = file.nativePath;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __picLoadErr);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __picLoaded);
			loader.load(new URLRequest(url));
			
			_name = file.name;
			_itemCls = Builder.makeAssetsClassName(url);
			_itemSrc = Builder.makeAssetsRePath(url);
			
			printNode();
		}
		
		private function __picLoadErr(e:IOErrorEvent):void
		{
			
		}
		
		private function __picLoaded(e:Event):void
		{
			var loader:Loader = e.target.loader;
			g9wrap.setContent(loader.content);
			scr.addChild(g9wrap);
		}
		
		private function __applyNodeBtn(e:MouseEvent):void
		{
			node.addEventListener(Event.COMPLETE, __nodeComplete);
			
			_itemLeft = g9wrap.getLeft();
			_itemRight = g9wrap.getRight();
			_itemTop = g9wrap.getTop();
			_itemBottom = g9wrap.getBottom();
			node.setup(_name, _itemCls, _itemSrc, _itemSlice, _itemLeft, _itemRight, _itemTop, _itemBottom);
		}
		
		private function __nodeComplete(e:Event):void
		{
			node.removeEventListener(Event.COMPLETE, __nodeComplete);
			StatusBar.instance.show("节点已被应用");
			printNode();
		}
		
		private function printNode():void
		{
			var info:String = "节点信息：";
			info += "name=" + _name + " cls=" + _itemCls + "\r";
			info += "src=" + _itemSrc + "\r";
			info += "left:" + _itemLeft + " right:" + _itemRight + " top:" + _itemTop + " bottom:" + _itemBottom;
			nodeInfoLabel.text = info;
		}
		
		private function __sliceParamEntered(e:Event):void
		{
			var left:int = parseInt(leftInput.text);
			var right:int = parseInt(rightInput.text);
			var top:int = parseInt(topInput.text);
			var bottom:int = parseInt(bottomInput.text);
			g9wrap.setParams(left, right, top, bottom);
		}
		
		private function __addBtn(e:MouseEvent):void
		{
			if(node.available())
			{
				var cl:AssetsNode = node.clone();
				AssetsBrowser.instance.addNode(cl);
			}
			else
			{
				Alert.instance.warn("该节点不合法");
			}
		}
		
	}
}