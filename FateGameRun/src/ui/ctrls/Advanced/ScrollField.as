package ui.ctrls.Advanced{
		
	import ui.ctrls.Ape;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.UIInfo;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class ScrollField extends Ape{
		
		/** 往上按钮（画布向下） */
		public var upBtn:ButtonBase = new ButtonBase(22,24);
		/** 往下按钮（画布向上） */
		public var downBtn:ButtonBase = new ButtonBase(22,24);
		/** 滑动块按钮 */
		public var barBtn:ScaleButton = new ScaleButton(22,25);
		/** 滑动块背景 */
		public var barBg:Ape = new Ape(22,24);
		
		/** 内容画布 */
		public var canvas:Sprite = new Sprite();
		/** 内容画布的遮罩 */
		protected var masker:Sprite = new Sprite();
		
		/** 移动区域 */
		protected var bounds:Rectangle;
		
		/** 是否按下barBtn */
		protected var barDown:Boolean = false;
		/** canvas是否向上移动 */
		protected var canvasUp:Boolean = false;
		/** canvas是否向下移动 */
		protected var canvasDown:Boolean = false;
		
		/** （高度上的）溢出 */
		protected var overflow:int = 0;
		
		
		public function ScrollField(width:Number = 300, height:Number = 200){
			super(width, height);
			this.uiType = UIInfo.TYPE_CONTROL;
			initScrollField();
		}
		
		
		/** 初始化 */
		protected function initScrollField():void{
			changeDefault();
			//初始化画布和遮罩
			this.addChild(canvas);
			this.addChild(masker);
			masker.graphics.beginFill(0x00FF00);
			masker.graphics.drawRect(0, 0, this.uiWidth + 4, this.uiHeight + 4);
			masker.graphics.endFill();
			this.mask = masker;
			test();
			//初始化按钮们及滑动块背景
			this.addChild(barBg);
			this.addChild(upBtn);
			this.addChild(downBtn);
			this.addChild(barBtn);
			
			barBg.uiHeight = this.uiHeight;
			barBg.uiBgSrc = "res/ui/fixed/scrollField/scrollField_boundsBg.png";
			
			upBtn.uiLabel = "";
			upBtn.uiBgSrc = "res/ui/fixed/scrollField/scrollField_up01.png";
			upBtn.stateOverSrc = "res/ui/fixed/scrollField/scrollField_up02.png";
			upBtn.stateDownSrc = "res/ui/fixed/scrollField/scrollField_up03.png";
			
			downBtn.uiLabel = "";
			downBtn.uiBgSrc = "res/ui/fixed/scrollField/scrollField_down01.png";
			downBtn.stateOverSrc = "res/ui/fixed/scrollField/scrollField_down02.png";
			downBtn.stateDownSrc = "res/ui/fixed/scrollField/scrollField_down03.png";
			
			barBtn.uiLabel = "";
			barBtn.uiBgSrc = "res/ui/fixed/scrollField/scrollField_bar01.png";
			barBtn.stateOverSrc = "res/ui/fixed/scrollField/scrollField_bar02.png";
			barBtn.stateDownSrc = "res/ui/fixed/scrollField/scrollField_bar03.png";
			
			//初始化事件监听
			barBg.addEventListener(MouseEvent.CLICK , barBg_click);
			barBtn.addEventListener(MouseEvent.MOUSE_DOWN , barBtn_startDrag);
			barBtn.addEventListener(MouseEvent.MOUSE_UP , barBtn_stopDrag);
			barBtn.addEventListener(MouseEvent.MOUSE_OUT , barBtn_stopDrag);
			upBtn.addEventListener(MouseEvent.MOUSE_DOWN , canvasDown_play);
			upBtn.addEventListener(MouseEvent.MOUSE_UP , canvasDown_stop);
			downBtn.addEventListener(MouseEvent.MOUSE_DOWN , canvasUp_play);
			downBtn.addEventListener(MouseEvent.MOUSE_UP , canvasUp_stop);
			//
			this.addEventListener(Event.ENTER_FRAME , frameAdjust);
		}
		
		
		/** 改变默认参数，【建议在派生类中覆盖此方法】 */
		protected function changeDefault():void{
			barBg.uiX = 0;
			barBg.uiY = 0;
			upBtn.uiX = 0;
			upBtn.uiY = 0;
			downBtn.uiX = 0;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = 0;
			barBtn.uiY = upBtn.uiHeight;
		}
		
		
		/** 测试方法 */
		protected function test():void{
//			var sp:Sprite = new Sprite();
//			var mtx:Matrix = new Matrix();
//			mtx.createGradientBox(120, 2000, 90, 0, 0);
//			sp.graphics.beginGradientFill(GradientType.LINEAR, [0xff0000, 0x00ff00], [0.5, 1], [0, 255], mtx);
//			sp.graphics.drawRect(0, 0, 120, 2000);
//			sp.graphics.endFill();
//			canvas.addChild(sp);
			
			var rec:Sprite = new Sprite();
			rec.graphics.lineStyle(1, 0xff0000);
			rec.graphics.beginFill(0xffff00, 0.8);
			rec.graphics.drawRect(0, 0, 50, 750);
			rec.graphics.endFill();
			canvas.addChild(rec);
		}
		
		
		/** 点击了滑动块背景 */
		protected function barBg_click(event:MouseEvent):void{
			var ty:int = event.localY;
			if(ty > barBtn.y + barBtn.uiHeight){
				ty -= barBtn.uiHeight;
			}
			barBtn.y = ty;
			//
			barDown = true;
			frameAdjust(null);
			barDown = false;
			//
			event.stopPropagation();
		}
		
		
		/** 滑动块按钮按下的处理事件(开始拖拽) */
		protected function barBtn_startDrag(event:MouseEvent):void{
			barDown = true;
			barBtn.startDrag(false,bounds);
			event.stopPropagation();
		}
		
		/** 滑动块按钮松开的处理事件(停止拖拽) */
		private function barBtn_stopDrag(event:MouseEvent):void{
			barDown = false;
			barBtn.stopDrag();
			event.stopPropagation();
		}
		
		/** 往上按钮按下时候的处理事件（画布向下进行播放） */
		protected function canvasDown_play(event:MouseEvent):void{
			canvasDown = true;
			event.stopPropagation();
		}
		
		/** 往上按钮松开或者移出时候的处理事件（画布向下停止播放） */
		protected function canvasDown_stop(event:MouseEvent):void{
			canvasDown = false;
			event.stopPropagation();
		}
		
		/** 往下按钮按下时候的处理事件（画布向上进行播放） */
		protected function canvasUp_play(event:MouseEvent):void{
			canvasUp = true;
			event.stopPropagation();
		}
		
		/** 往下按钮松开或者移出时候的处理事件（画布向上停止播放） */
		protected function canvasUp_stop(event:MouseEvent):void{
			canvasUp = false;
			event.stopPropagation();
		}
		
		
		/** 每帧事件 */
		protected function frameAdjust(event:Event):void{
			preRender();
			//调整遮罩
			masker.width = this.uiWidth;
			masker.height = this.uiHeight;
			//调整滑动块背景
			barBg.uiHeight = this.uiHeight;
			//计算（高度上的）溢出
			overflow = canvas.height - this.uiHeight;
			//调整barBtn的height
			if(overflow > 0){
				barBtn.visible = true;
				barBtn.uiHeight = (this.uiHeight - upBtn.uiHeight - downBtn.uiHeight) * (this.uiHeight / canvas.height);
			}else{
				barBtn.visible = false;
			}
			//barBtn按下
			if(barDown == true){
				if(overflow >= 0){
					var rate:Number = (barBtn.y - upBtn.uiHeight) / (this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight);
					canvas.y = -1 * overflow * rate;
				}
			}
			//配合downBtn 和 upBtn
			if(canvasDown == true){
				if(canvas.y < 0){
					canvas.y += 2;
					barBtn.y = ((-1 * canvas.y * (this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight)) / overflow) + upBtn.uiHeight;
				}
			}
			if(canvasUp == true){
				if(canvas.y >= (-1 * overflow)){
					canvas.y -= 2;
					barBtn.y = ((-1 * canvas.y * (this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight)) / overflow) + upBtn.uiHeight;
				}
			}
		}
		
		
		/** 处理upBtn downBtn barBtn 的位置 以及 barBtn 的 大小 【建议派生类中覆盖此方法】 */
		override protected function preRender():void{
			if(bounds == null){
				bounds = new Rectangle(0,24,0,119);
			}
			//
			barBg.uiX = 0;
			barBg.uiY = 0;
			upBtn.uiX = 0;
			upBtn.uiY = 0;
			downBtn.uiX = 0;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = 0;
			//
			bounds.x = 0;
			bounds.height = this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight;
		}
		
		
		/** 将画布移至最底部 */
		public function canvasToBottom():void{
			overflow = canvas.height - this.uiHeight;
			if(overflow > 0){
				canvas.y = -1 * overflow;
				barBtn.y = this.uiHeight - barBtn.height - downBtn.height;
			}else{
				canvas.y = 0;
			}
		}
		
		
		/** 将画布移至最顶部 */
		public function canvasToTop():void{
			overflow = canvas.height - this.uiHeight;
			if(overflow > 0){
				barBtn.y = upBtn.height;
			}
		}
		
		
		/** 清空画布 */
		public function clearCanvas():void{
			for(var i:int = canvas.numChildren - 1 ; i >= 0 ; i--){
				canvas.removeChild(canvas.getChildAt(i));
			}
			fresh();
		}
		
		
	}
}