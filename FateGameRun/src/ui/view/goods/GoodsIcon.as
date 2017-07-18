package ui.view.goods
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	
	import comm.component.cd.CDUnit;
	import comm.component.goods.GoodsInfo;
	import comm.struct.cd.StCDInfo;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gamekit.layer.Layer;
	
	import res.PreRes;
	import res.Res;
	
	import run.cd.CDEvent;
	
	import ui.drag.Drag;
	import ui.parts.CDRender;
	import ui.skin.font.DefaultFont;
	
	public class GoodsIcon extends Sprite
	{
		public static const W:int = 36;
		public static const H:int = 36;
		
		public var info:GoodsInfo;
		
		/** icon图片 */
		private var pic:Bitmap = new Bitmap();
		/** 数量标签 */
		private var numLabel:JLabel = new JLabel();
		
		/** cdRender[null表示不需要进行CD渲染处理] */
		private var CDR:CDRender = null;
		
		override public function get width():Number { return W; }
		override public function get height():Number { return H; }
		
		public function GoodsIcon()
		{
			super();
			paintDefault();
			prepare();
		}
		
		protected function prepare():void
		{
			this.addChild(pic);
			
			numLabel.textFormat = DefaultFont.create();
			numLabel.useStroke = true;
			numLabel.align = JuiConst.RIGHT;
			numLabel.setSize(W, 0.3*H);
			numLabel.move(0, 0.6*H);
			this.addChild(numLabel);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
		}
		
		protected function __mouseOver(e:MouseEvent):void
		{
			GoodsTip.getInstance().update( info );
			Layer.ui.addChild( GoodsTip.getInstance() );
		}
		
		protected function __mouseMove(e:MouseEvent):void
		{
			GoodsTip.getInstance().move( Centre.stage.mouseX + 10, Centre.stage.mouseY + 10 );
		}
		
		protected function __mouseOut(e:MouseEvent):void
		{
			GoodsTip.getInstance().removeFromParent();
		}
		
		/** 是否支持拖拽 */
		public function canDrag(value:Boolean):void
		{
			if(value==true)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, __preDrag);
				this.addEventListener(MouseEvent.MOUSE_UP, __stopDrag);
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, __preDrag);
				this.removeEventListener(MouseEvent.MOUSE_MOVE, __startDrag);
				this.removeEventListener(MouseEvent.MOUSE_UP, __stopDrag);
			}
		}
		
		private function __preDrag(e:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_MOVE, __startDrag);
			e.stopImmediatePropagation();
		}
		
		private function __startDrag(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, __startDrag);
			doDrag();
		}
		
		private function __stopDrag(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, __startDrag);
			cancelDrag();
		}
		
		protected function doDrag():void
		{
			//TODO
		}
		
		protected function cancelDrag():void
		{
			Drag.getInstance().finish();
		}
		
		/** 是否要显示CD */
		protected function showCD(value:Boolean):void
		{
			if(value==true)
			{
				if(CDR == null)
				{
					CDR = new CDRender();
					this.addChild(CDR);
					paintCD();
				}
				Game.cd.addEventListener(CDEvent.UPDATE, __cdUpdate);
			}
			else
			{
				if(CDR && CDR.parent) { CDR.parent.removeChild(CDR); }
				CDR = null;
				Game.cd.removeEventListener(CDEvent.UPDATE, __cdUpdate);
			}
		}
		
		private function __cdUpdate(e:CDEvent):void
		{
			if(e.info.type != CDUnit.T_GOODS) { return; }
			paintCD();
		}
		
		private function paintCD():void
		{
			if(!CDR) { return; }
			if(!info) { return; }
			var cdi:StCDInfo = Game.hero.cd.getCDInfo(CDUnit.T_GOODS, info.baseCfgId);
			CDR.update(cdi);
		}
		
		public function setup(info:GoodsInfo):void
		{
			this.info = info;
			paintMain();
			paintNum();
			paintCD();
		}
		
		protected function paintDefault():void
		{
			pic.bitmapData = PreRes.icon;
		}
		
		protected function paintMain():void
		{
			Res.fillIcon(pic, this.info.getIcon());
		}
		
		protected function paintNum():void
		{
			numLabel.text = this.info.num.toString();
		}
		
	}
}