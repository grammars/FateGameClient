package ui.view.goods.bag
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import com.anstu.jui.controls.JPanel;
	
	import comm.component.goods.GoodsInfo;
	import comm.define.GoodsType;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import gamekit.layer.Layer;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.skin.pane.ModernPaneSkin;
	
	public class BagIconMenu extends JPanel
	{
		private static var instance:BagIconMenu;
		public static function getInstance():BagIconMenu
		{
			if(instance==null) { instance = new BagIconMenu(); }
			return instance;
		}
		
		private static const BTN_USE:String = "使用";
		private static const BTN_PUT_ON:String = "穿上";
		private static const BTN_TAKE_OFF:String = "脱下";
		private static const BTN_SPLIT:String = "拆分";
		private static const BTN_DROP:String = "丢弃";
		private static const BTN_CANCEL:String = "取消";
		
		private var info:GoodsInfo;
		
		public function BagIconMenu()
		{
			super();
			initialize();
		}
		
		private function initialize():void
		{
			ModernPaneSkin.instance.apply(this);
		}
		
		public function showFor(icon:BagIcon):void
		{
			this.info = icon.info;
			var iconGP:Point = icon.localToGlobal(new Point(0,0));
			this.x = iconGP.x + 20;
			this.y = iconGP.y + 20;
			Layer.ui.addChild(this);
			Centre.stage.addEventListener(MouseEvent.MOUSE_DOWN, __stageMouseUp);
			makeBtns();
		}
		
		private function makeBtns():void
		{
			this.clearContent();
			var btnTypes:Array;
			switch(this.info.baseCfg.type)
			{
			case GoodsType.SYSTEM:
				btnTypes = [BTN_USE, BTN_PUT_ON, BTN_TAKE_OFF, BTN_SPLIT, BTN_DROP, BTN_CANCEL];
				break;
			case GoodsType.DRUG:
				btnTypes = [BTN_USE, BTN_SPLIT, BTN_DROP, BTN_CANCEL];
				break;
			case GoodsType.TASK:
				btnTypes = [BTN_USE, BTN_SPLIT, BTN_DROP, BTN_CANCEL];
				break;
			case GoodsType.EQUIP:
				btnTypes = [BTN_PUT_ON, BTN_TAKE_OFF, BTN_DROP, BTN_CANCEL];
				break;
			case GoodsType.GEM:
				btnTypes = [BTN_USE, BTN_SPLIT, BTN_DROP, BTN_CANCEL];
				break;
			case GoodsType.GIFT:
				btnTypes = [BTN_USE, BTN_SPLIT, BTN_DROP, BTN_CANCEL];
				break;
			default:
				btnTypes = [];
				break;
			}
			for(var i:int = 0; i < btnTypes.length; i++)
			{
				var bt:String = btnTypes[i];
				var item:BagIconMenuItem = new BagIconMenuItem(bt);
				item.x = 10;
				item.y = 10 + i * 28;
				this.addChild(item);
			}
			this.setSize(120, btnTypes.length*28+20);
		}
		
		public function hide():void
		{
			this.info = null;
			if(this.parent) { this.parent.removeChild(this); }
			Centre.stage.removeEventListener(MouseEvent.MOUSE_DOWN, __stageMouseUp);
		}
		
		private function __stageMouseUp(e:MouseEvent):void
		{
			hide();
		}
		
		/** 被BagIconMenuItem执行的 */
		public function execute(exeType:String):void
		{
			switch(exeType)
			{
			case BTN_USE:
				Game.goods.useItem(this.info);
				break;
			case BTN_PUT_ON:
				break;
			case BTN_TAKE_OFF:
				break;
			case BTN_SPLIT:
				View.goodsSplitFrame.open(this.info);
				break;
			case BTN_DROP:
				View.goodsDiscardFrame.open(this.info);
				break;
			case BTN_CANCEL:
				break;
			}
		}
		
	}
}