package ui.view.buff
{
	import com.anstu.jui.controls.JPanel;
	
	import comm.component.buff.Buff;
	
	import ui.skin.pane.ModernPaneSkin;
	import ui.skin.pane.TipEasyPaneSkin;
	
	public class BuffBar extends JPanel
	{
		private var rowNum:int = 3;
		
		private var icons:Vector.<BuffIcon> = new Vector.<BuffIcon>();
		
		public function BuffBar(rowNum:int)
		{
			super();
			this.rowNum = rowNum;
			setup();
		}
		
		private function setup():void
		{
			this.setSize(30, 30);
			ModernPaneSkin.instance.apply(this);
		}
		
		public function clear():void
		{
			for(var i:int = 0; i < icons.length; i++)
			{
				var icon:BuffIcon = icons[i];
				if(icon.parent) { icon.parent.removeChild(icon); }
			}
			icons.length = 0;
			putPos();
		}
		
		public function addBuff(info:Buff):void
		{
			var icon:BuffIcon = new BuffIcon(info);
			this.addChild(icon);
			icons.push(icon);
			putPos();
		}
		
		public function removeBuff(buffId:int):void
		{
			for(var i:int = icons.length-1; i >= 0; i--)
			{
				var icon:BuffIcon = icons[i];
				if(icon.info.id == buffId)
				{
					if(icon.parent) { icon.parent.removeChild(icon); }
					icons.splice(i,1);
					break;
				}
			}
			putPos();
		}
		
		private function putPos():void
		{
			if(icons.length == 0)
			{
				this.visible = false;
				return;
			}
			else
			{
				this.visible = true;
			}
			for(var i:int = 0; i < icons.length; i++)
			{
				icons[i].x = (i % rowNum) * (BuffIcon.W + 4) + 4;
				icons[i].y = Math.floor( i / rowNum ) * (BuffIcon.H + 4) + 4;
			}
			var rowCount:int = 0;
			if(icons.length >= rowNum)
			{
				rowCount = rowNum;
			}
			else
			{
				rowCount = (icons.length % rowNum);
			}
			const PaneW:int = rowCount * (BuffIcon.W + 4) + 4;
			const PaneH:int = Math.ceil( icons.length / rowNum) * (BuffIcon.H + 4) + 4;
			setSize(PaneW, PaneH);
		}
		
	}
}