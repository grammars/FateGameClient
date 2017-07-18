package ui.view.topTar
{
	import central.Centre;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.define.JuiConst;
	
	import comm.component.buff.Buff;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import gamekit.layer.Layer;
	
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.SpriteAvt;
	
	import ui.skin.font.DefaultFont;
	import ui.view.IBasePane;
	import ui.view.ViewWnd;
	import ui.view.buff.BuffBar;
	
	public class TopTarPane extends ViewWnd
	{
		private var target:CreatureAvt;
		public function getTarget():CreatureAvt { return target; }
		
		private var hpLine:JImage;
		private var mpLine:JImage;
		private var cover:JImage;
		private var nameLabel:JLabel;
		
		/** Buff组信息条 */
		private var buffBar:BuffBar = new BuffBar(6);
		
		public function TopTarPane()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("top_tar");
			pane = uiPack.getCtrl("root");
			hpLine = uiPack.getImage("hpLine");
			mpLine = uiPack.getImage("mpLine");
			cover = uiPack.getImage("cover");
			nameLabel = uiPack.getLabel("nameLabel");
			
			buffBar.move(70, 65);
			pane.addChild(buffBar);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Centre.stage.stageWidth - pane.width)/2;
				pane.y = 0;
			}
		}
		
		public function showTarget(cret:CreatureAvt):void
		{
			this.target = cret;
			if(null == target)
			{
				hide();
				return;
			}
			nameLabel.text = target.creatureVO.name + "("+target.creatureVO.level+"级)";
			initBuff();
			show();
		}
		
		/** 初始化buff */
		public function initBuff():void
		{
			buffBar.clear();
			if(target == null) { return; }
			var list:Vector.<Buff> = target.creatureVO.buffs.getBuffs();
			for(var i:int = 0; i < list.length; i++)
			{
				var buff:Buff = list[i];
				buffBar.addBuff(buff);
			}
		}
		
		/** 添加目标buff */
		public function addBuff(buff:Buff):void
		{
			buffBar.addBuff(buff);
		}
		
		/** 移除目标buff */
		public function removeBuff(buffId:int):void
		{
			buffBar.removeBuff(buffId);
		}
		
	}
}