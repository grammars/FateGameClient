package builder.view.template
{	
	import builder.Builder;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class TempBase extends JScrollPanel
	{
		private var applyBtn:CrystalBtn;
		private var fileNameLabel:CrystalLabel;
		private var fileNameInput:CrystalInput;
		
		public function TempBase()
		{
			super();
			
			applyBtn = new CrystalBtn("应用", __applyBtn, 160, 30);
			applyBtn.move(20, 20);
			this.addChild(applyBtn);
			
			fileNameLabel = new CrystalLabel("文件名：", 60, 30);
			fileNameLabel.move(190, 20);
			this.addChild(fileNameLabel);
			
			fileNameInput = new CrystalInput("template", 160, 30);
			fileNameInput.move(250, 20);
			this.addChild(fileNameInput);
			
			paint();
		}
		
		protected function paint():void
		{
			new JScrollPanelSkin().apply(this);
			this.setSize(720, 450);
//			this.graphics.clear();
//			this.graphics.beginFill(0xff0000, 0.2);
//			this.graphics.drawRect(0, 0, 500, 450);
//			this.graphics.endFill();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			apply();
		}
		
		public function apply():void
		{
			//TODO
		}
		
		public function setFileName(fileName:String):void
		{
			fileNameInput.text = fileName;
		}
		
		public function save():void
		{
			var fileName:String = fileNameInput.text;
			trace("保存模版：" + fileName);
			var file:File = new File(Builder.templatesDirFull() + fileName +"."+ Builder.EXT);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(encode(), "UTF-8");
			fs.close();
		}
		
		protected function encode():String
		{
			return "";
		}
		
		protected function ATTRI(name:String, value:String):String
		{
			return ' ' + name + '="' + value + '"';
		}
		
	}
}