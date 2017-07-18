package builder.view.assets.browser
{
	import builder.Builder;
	import builder.view.assets.AssetsNode;
	import builder.view.base.CrystalBtn;
	
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.MouseEvent;
	
	public class AssetsAddrBar extends JPanel
	{
		private var prevBtn:CrystalBtn;
		private var rootBtn:CrystalBtn;
		private var nextBtn:CrystalBtn;
		
		private var prevHandler:Function;
		private var rootHandler:Function;
		private var nextHandler:Function;
		
		private var hierarchy:AssetsHierarchy;
		
		public function AssetsAddrBar(prevHandler:Function, rootHandler:Function, nextHandler:Function)
		{
			this.prevHandler = prevHandler;
			this.rootHandler = rootHandler;
			this.nextHandler = nextHandler;
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.bgAlpha = 0.6;
			this.bgColor = Builder.MILK_WHITE;
			
			prevBtn = new CrystalBtn("←", prevHandler, 60, 25);
			prevBtn.move(0, 0);
			this.addChild(prevBtn);
			rootBtn = new CrystalBtn("◎", rootHandler, 60, 25);
			rootBtn.move(60, 0);
			this.addChild(rootBtn);
			nextBtn = new CrystalBtn("→", nextHandler, 60, 25);
			nextBtn.move(120, 0);
			this.addChild(nextBtn);
			
			hierarchy = new AssetsHierarchy();
			hierarchy.x = 200;
			hierarchy.y = 0;
			this.addChild(hierarchy);
		}
		
		override protected function init():void
		{
			super.init();
			
			this.setSize(870, 25);
		}
		
		public function freshAddr(node:AssetsNode):void
		{
			hierarchy.freshAddr(node);
		}
		
	}
}