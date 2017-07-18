package builder.view.radio
{
	import builder.view.base.BFrame;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.components.JRadioGroup;
	
	import flash.events.MouseEvent;
	
	public class RadioGroupItem extends BFrame
	{
		override public function get W():int { return 340; }
		
		override public function get H():int { return 30; }
		
		private var group:JRadioGroup;
		
		private var label:CrystalLabel;
		private var deleteBtn:CrystalBtn;
		
		public function RadioGroupItem(group:JRadioGroup)
		{
			this.group = group;
			super();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			label = new CrystalLabel("" + group.name, 230, 25);
			label.move(5, 2);
			this.addChild(label);
			
			deleteBtn = new CrystalBtn("删除", __deleteBtn, 80, 25);
			deleteBtn.move(250, 2);
			this.addChild(deleteBtn);
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			RadioGroupEditor.instance.deleteGroup(group.name);
		}
		
	}
}