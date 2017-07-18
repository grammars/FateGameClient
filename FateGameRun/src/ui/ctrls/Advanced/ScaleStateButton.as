package ui.ctrls.Advanced{
	
	import ui.ctrls.BitmapScale9Grid;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.StrokeLabel;
	import ui.ctrls.UIInfo;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	
	/** 状态按钮方案：
	 * 对ButtonBase的四种状态图进行了重新分配】
	 * 普通状态的背景NORMAL 对应用作 没有选中（chosen == “false”）
	 * 鼠标经过状态MOUSE_OVER的图 对应用作 没有选中状态时候的鼠标经过（chosen == “false” 且 鼠标经过）
	 * 鼠标按下状态MOUSE_DOWN的图 对应用作 选中（chosen == “true”）
	 * 鼠标禁用状态DISABLED的图 对应用作 选中的时候鼠标经过（chosen == “true” 且 鼠标经过） */
	public class ScaleStateButton extends ScaleButton{
		
		//------------------------------------------------------------------------
		
		protected var _chosen:Boolean = false;
		
		public function set chosen(value:String):void{
			if(value == "true"){
				_chosen = true;
			}else if(value == "false"){
				_chosen = false;
			}
			fresh();
		}
		
		public function get chosen():String{
			return _chosen.toString();
		}
		
		//------------------------------------------------------------------------
		
		public function ScaleStateButton(width:Number=75, height:Number=23){
			super(width, height);
			this.textField.wordWrap = false;
		}
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.SCALE_STATEBUTTON;
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		//------------------------------------------------------------------------------------------
		
		protected function onClick(event:MouseEvent):void{
			if(this.chosen == "false"){
				this.chosen = "true";
			}else{
				this.chosen = "false";
			}
			fresh();
		}
		
		//------------------------------------------------------------------------------------------
		
		override protected function render():void{
			stateRender();
		}
		
		
		/** 以状态按钮的方式进行渲染 */
		protected function stateRender():void{
			this.bgSprite.graphics.lineStyle(1, 0xff0000);
			if(state == ButtonBase.MOUSE_OVER){
				if(chosen == "false"){
					if (this.stateOverBmd != null){
						scale.assign(stateOverBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(0x000010);
					}
				}else{
					if (this.stateDisabledBmd != null){
						scale.assign(stateDisabledBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(0xfffff0);
					}
				}
				
				this.bgSprite.graphics.drawRect(0, 0, this.uiWidth, this.uiHeight);
				this.bgSprite.graphics.endFill();
				return;
			}
			switch (chosen){
				case "false":
					if (this.uiBgBitmap != null){
						scale.assign(uiBgBitmap);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(0xffff0000 , 0.8);
					}
					break;
				case "true":
					if (this.stateDownBmd != null){
						scale.assign(stateDownBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(0xff00ff00 , 0.8);
					}
					break;
			}
			this.bgSprite.graphics.drawRect(0, 0, this.uiWidth, this.uiHeight);
			this.bgSprite.graphics.endFill();
		}
		
		
	}
}