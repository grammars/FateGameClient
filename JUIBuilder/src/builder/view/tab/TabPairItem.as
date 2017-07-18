package builder.view.tab
{
	import builder.Builder;
	import builder.view.base.BFrame;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.build.ctrls.CsCheckBox;
	import com.anstu.jui.build.ctrls.CsRadioButton;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JRadioButton;
	
	import flash.events.MouseEvent;
	
	public class TabPairItem extends BFrame
	{
		override public function get W():int { return 340; }
		
		override public function get H():int { return 30; }
		
		
		private var label:CrystalLabel;
		private var deleteBtn:CrystalBtn;
		
		public var STag:String;
		public var MTag:String;
		
		private var Mll:CShell;
		
		public function TabPairItem(STag:String, MTag:String)
		{
			this.STag = STag;
			this.MTag = MTag;
			super();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			label = new CrystalLabel(STag+"==>"+MTag, 230, 25);
			label.move(5, 2);
			this.addChild(label);
			
			deleteBtn = new CrystalBtn("删除", __deleteBtn, 80, 25);
			deleteBtn.move(250, 2);
			this.addChild(deleteBtn);
		}
		
		public function bind():Boolean
		{
			Mll = Builder.getShell(MTag);
			if(Mll == null) { return false; }
			var Sll:CShell = Builder.getShell(STag);
			if(Sll == null) { return false; }
			if(Sll is CsCheckBox)
			{
				Mll.setVisualController(Sll.getUI() as JCheckBox);
			}
			else if(Sll is CsRadioButton)
			{
				Mll.setVisualController(Sll.getUI() as JRadioButton);
			}
			else
			{
				return false;
			}
			return true;
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			if(Mll) { Mll.setVisualController(null); }
			TabPairEditor.instance.removePair(this);
		}
	}
}