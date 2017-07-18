package builder.view.prop.item.parts
{
	import builder.Builder;
	import builder.view.AssetsPop;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsBrowser;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	public class PicChooser extends Sprite
	{
		private var descLabel:CrystalLabel;
		private var browseBtn:CrystalBtn;
		private var deleteBtn:CrystalBtn;
		private var valueLabel:JLabel;
		
		private var file:File;
		
		private var value:String = "";
		public function setValue(value:String):void
		{
			this.value = value;
			valueLabel.text = value;
		}
		public function getValue():String { return this.value; }
		
		public function PicChooser(desc:String)
		{
			super();
			
			descLabel = new CrystalLabel(desc, 80, 30, 14);
			descLabel.move(0, 0);
			this.addChild(descLabel);
			
			browseBtn = new CrystalBtn("浏览", __browse, 60, 26);
			browseBtn.move(80, 2);
			this.addChild(browseBtn);
			
			deleteBtn = new CrystalBtn("删除", __delete, 60, 26);
			deleteBtn.move(140, 2);
			this.addChild(deleteBtn);
			
			valueLabel = new JLabel("");
			valueLabel.autoWrap = false;
			valueLabel.useStroke = true;
			valueLabel.usePack = true;
			valueLabel.textFormat.color = Builder.LAKE_BLUE;
			valueLabel.setSize(160, 30);
			valueLabel.move(210, 5);
			valueLabel.useFrame = true;
			valueLabel.frameFillColor = Builder.MILK_WHITE;
			valueLabel.frameFillAlpha = 0.2;
			valueLabel.frameLineColor = Builder.LAKE_BLUE;
			valueLabel.frameLineThick = 1;
			this.addChild(valueLabel);
			
			file = new File(Builder.assetsDirFull());
			
			paint();
		}
		
		private function paint():void
		{
			this.graphics.clear();
			this.graphics.beginFill(Builder.DARK_GREY, 0.3);
			this.graphics.drawRect(0, 0, 460, 30);
			this.graphics.endFill();
		}
		
		private function __browse(e:MouseEvent):void
		{
			AssetsPop.instance.assetReqs = __picSeleted;
			AssetsPop.instance.show();
		}
		
		private function __delete(e:MouseEvent):void
		{
			setValue(null);
		}
		
		private function __picSeleted(node:AssetsNode):void
		{
			setValue(node.itemCls);
		}
		
	}
}