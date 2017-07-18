package builder.view.template
{
	import builder.Builder;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class TemplateOpenWnd extends Popup
	{
		private static var _instance:TemplateOpenWnd;
		public static function get instance():TemplateOpenWnd
		{
			if(_instance == null) { _instance = new TemplateOpenWnd(); }
			return _instance;
		}
		
		private var scr:JScrollPanel;
		
		public function TemplateOpenWnd()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			scr = new JScrollPanel();
			new JScrollPanelSkin().apply(scr);
			scr.setSize(350, 500);
			scr.move(20, 50);
			this.addChild(scr);
			
			setSize(400, 600);
			setTitle("打开模版");
		}
		
		override public function show():void
		{
			fresh();
			super.show();
		}
		
		private function fresh():void
		{
			scr.clearContent();
			var tplDir:File = new File(Builder.templatesDirFull());
			var files:Array = tplDir.getDirectoryListing();
			for(var i:int = 0; i < files.length; i++)
			{
				var f:File = files[i];
				var item:FileItem = new FileItem(f);
				item.x = 10;
				item.y = 10 + 27 * i;
				scr.addChild(item);
			}
		}
		
		public function readFile(file:File):void
		{
			trace("读取", file.nativePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var content:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			fs.close();
			var fileNamePure:String = file.name.replace("."+Builder.EXT, "");
			TemplateEditor.instance.parseTemplate(content, fileNamePure);
			this.hide();
		}
		
	}
}


import builder.view.base.CrystalBtn;
import builder.view.template.TemplateOpenWnd;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filesystem.File;


class FileItem extends Sprite
{
	private var btn:CrystalBtn;
	private var file:File;
	
	public function FileItem(f:File)
	{
		this.file = f;
		btn = new CrystalBtn(f.name, __click, 330, 25);
		this.addChild(btn);
	}
	
	private function __click(e:MouseEvent):void
	{
		TemplateOpenWnd.instance.readFile(file);
	}
}