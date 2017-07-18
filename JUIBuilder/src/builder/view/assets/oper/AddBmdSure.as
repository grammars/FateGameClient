package builder.view.assets.oper
{
	import builder.Builder;
	import builder.view.Alert;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsBrowser;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class AddBmdSure extends Popup
	{
		private static var _instance:AddBmdSure;
		public static function get instance():AddBmdSure
		{
			if(_instance == null) { _instance = new AddBmdSure(); }
			return _instance;
		}
		
		private var browseBtn:CrystalBtn;
		private var nodeLabel:CrystalLabel;
		private var addBtn:CrystalBtn;
		
		private var pic:DisplayObject;
		
		private var node:AssetsNode = new AssetsNode(false);
		
		public function AddBmdSure()
		{
			super();
			
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			this.setSize(600, 400);
			this.setTitle("添加普通图");
			
			browseBtn = new CrystalBtn("选 择 图 片 . . .", __browseBtn, 500, 30);
			browseBtn.move(50, 50);
			this.addChild(browseBtn);
			
			nodeLabel = new CrystalLabel("详情", 250, 160);
			nodeLabel.move(320, 130);
			this.addChild(nodeLabel);
			
			addBtn = new CrystalBtn("添 加", __addBtn, 500, 30);
			addBtn.move(50, 350);
			this.addChild(addBtn);
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
			if(pic && pic.parent) { pic.parent.removeChild(pic); }
			pic = null;
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
			clearPic();
			
			var file:File = e.target as File;
			var url:String = file.nativePath;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __picLoadErr);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __picLoaded);
			loader.load(new URLRequest(url));
			
			var name:String = file.name;
			var itemCls:String = Builder.makeAssetsClassName(url);
			var itemSrc:String = Builder.makeAssetsRePath(url);
			var itemSlice:Boolean = false;
			
			node.setup(name, itemCls, itemSrc, itemSlice);
			
			printNode();
		}
		
		private function printNode():void
		{
			var words:String = "详情：\r<font color='#ecec11'>cls(类名):</font>\r" + node.itemCls + "\r<font color='#ecec11'>src(相对路径):</font>\r" + node.itemSrc;
			nodeLabel.useHtml = true;
			nodeLabel.text = words;
		}
		
		private function __picLoadErr(e:IOErrorEvent):void
		{
			
		}
		
		private function __picLoaded(e:Event):void
		{
			var loader:Loader = e.target.loader;
			pic = loader.content;
			pic.x = 50;
			pic.y = 90;
			const PIC_MAX_W:int = 260;
			const PIC_MAX_H:int = 260;
			var sc:Number = Math.min(PIC_MAX_W/pic.width, PIC_MAX_H/pic.height);
			if(sc > 1) { sc = 1; }
			pic.scaleX = pic.scaleY = sc;
			this.addChild(pic);
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