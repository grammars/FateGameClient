package builder.view.assets.browser
{
	import builder.Builder;
	import builder.view.AssetsPop;
	import builder.view.assets.AssetsNode;
	import builder.view.base.BImage;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.define.JuiConst;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class AssetsNCard extends JPanel
	{
		public var node:AssetsNode;
		
		private var nameLabel:CrystalLabel;
		
		private var selected:Boolean = false;
		public function setSelected(value:Boolean):void
		{
			if(value == selected) { return; }
			selected = value;
			if(selected)
			{
				this.frameLineThick = 3;
				this.frameLineColor = Builder.LAKE_BLUE;
				this.frameFillColor = Builder.DARK_GREY;
				this.useFrame = true;
			}
			else
			{
				this.useFrame = false;
			}
		}
		
		public function AssetsNCard(node:AssetsNode)
		{
			super();
			this.bgAlpha = 0;
			this.node = node;
			handleNode();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			nameLabel = new CrystalLabel("unknow", 140, 25, 14);
			nameLabel.align = JuiConst.CENTER;
			nameLabel.move(0, 120);
			this.addChild(nameLabel);
		}
		
		override protected function init():void
		{
			super.init();
			this.setSize(140, 160);
			this.mouseChildren = false;
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, __doubleClick);
			this.addEventListener(MouseEvent.CLICK, __click);
		}
		
		private function handleNode():void
		{
			var bgImg:BImage;
			if(this.node.isPack)
			{
				bgImg = new BImage("packIcon.png", 130, 130);
				bgImg.x = bgImg.y = 5;
				this.addChildAt(bgImg, 0);
			}
			else
			{
				bgImg = new BImage("fileIcon.png", 130, 130);
				bgImg.x = bgImg.y = 5;
				this.addChildAt(bgImg, 0);
				
				var snap:DisplayObject = this.node.createPic();
				snap.x = 15;
				snap.y = 40;
				const MaxW:int = 110;
				const MaxH:int = 80;
				var sc:Number = Math.min(MaxW/snap.width, MaxH/snap.height);
				if(sc > 1) { sc = 1; }
				snap.scaleX = snap.scaleY = sc;
				var ofsX:int = (MaxW - snap.width)/2;
				var ofsY:int = (MaxH - snap.height)/2;
				snap.x += ofsX;
				snap.y += ofsY;
				this.addChild(snap);
			}
			
			if(this.node.itemSlice)
			{
				var g9tag:BImage = new BImage("g9tag.png", 16, 16);
				g9tag.x = 25;
				g9tag.y = 15;
				this.addChild(g9tag);
			}
			
			var nameStr:String = this.node.name;
			nameLabel.text = nameStr;
		}
		
		private function __doubleClick(e:MouseEvent):void
		{
			AssetsPop.instance.nodeCardDClick(this);
		}
		
		private function __click(e:MouseEvent):void
		{
			AssetsBrowser.instance.selectCard(this);
		}
		
	}
}