package ui.view.goods
{
	import central.View;
	
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.define.JuiConst;
	
	import comm.component.goods.GoodsInfo;
	import comm.define.GoodsType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import res.PreRes;
	import res.Res;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.TipClassicPaneSkin;
	import ui.view.utils.ViewUtils;
	
	public class GoodsTip extends JPanel
	{
		private static var instance:GoodsTip;
		public static function getInstance():GoodsTip
		{
			if(instance == null) { instance = new GoodsTip(); }
			return instance;
		}
		
		private static const MARGIN:int = 24;
		private static const CTT_W:int = 240;
		
		protected var info:GoodsInfo;
		
		protected var icon:Bitmap = new Bitmap();
		
		public function GoodsTip()
		{
			super();
			initialize();
		}
		
		private function initialize():void
		{
			this.mouseEnabled = this.mouseChildren = false;
			this.width = CTT_W + MARGIN*2;
			TipClassicPaneSkin.instance.apply(this);
		}
		
		public function update(info:GoodsInfo):void
		{
			this.info = info;
			this.clearContent();
			
			var parts:Array = getParts();
			var contentH:int = 0;
			var posY:int = MARGIN;
			for(var i:int = 0; i < parts.length; i++)
			{
				var bmd:BitmapData = parts[i];
				var bmp:Bitmap = new Bitmap(bmd);
				bmp.x = MARGIN;
				bmp.y = posY;
				this.addChild(bmp);
				
				contentH += bmd.height;
				posY += bmd.height;
			}
			this.height = contentH+2*MARGIN;
			
			putIcon();
		}
		
		protected function getParts():Array
		{
			var parts:Array = new Array();
			parts.push( makeBase() );
			parts.push( makeSplit() );
			parts.push( makeDesc() );
			return parts;
		}
		
		protected function makeBase():BitmapData
		{
			var nameStr:String = "<font color='#ffe747' size='16'>"+info.baseCfg.name+"</font>";
			var nameLabel:JLabel = ViewUtils.htmlLabel(nameStr, false, CTT_W, null, JuiConst.LEFT, 8);
			
			var typeStr:String = "<font color='#a435b1' size='13'>类型："+GoodsType.Str(info.baseCfg.type)+"</font>";
			var typeLabel:JLabel = ViewUtils.htmlLabel(typeStr, false, CTT_W);
			
			var mat:Matrix = new Matrix();
			var bmd:BitmapData = new BitmapData(CTT_W, 55, true, 0x0);
			
			mat.tx = 52;
			mat.ty = 0;
			bmd.draw(nameLabel, mat);
			
			mat.tx = 52;
			mat.ty = 25;
			bmd.draw(typeLabel, mat);
			
			return bmd;
		}
		
		protected function makeSplit():BitmapData
		{
			return PreRes.split;
		}
		
		protected function makeDesc():BitmapData
		{
			var descStr:String = "<font color='#d1c692' size='12'>说明："+info.baseCfg.desc+"</font>";
			var descLabel:JLabel = ViewUtils.htmlLabel(descStr, false, CTT_W);
			
			var mat:Matrix = new Matrix();
			var bmd:BitmapData = new BitmapData(CTT_W, descLabel.height + 10, true, 0x0);
			
			mat.tx = 0;
			mat.ty = 5;
			bmd.draw(descLabel, mat);
			
			return bmd;
		}
		
		protected function putIcon():void
		{
			Res.fillIcon(icon, info.getIcon());
			icon.x = MARGIN;
			icon.y = MARGIN + 5;
			this.addChild(icon);
		}
		
	}
}