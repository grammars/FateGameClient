package ui.ctrls.Advanced{
	
	import ui.ctrls.Advanced.ListButton.ListButtonItem;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.Label;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.UIInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ListButton extends ButtonBase{
		
		/** 收缩状态标记 */
		private var show:Boolean = false;
		
		/** 选择的序列 */
		private var _selectIndex:int = 0;
		
		/** 选择序列所对应的标签内容 */
		public var selectContent:String = "";
		
		/** 所有选项存储数组 */
		private var itemArr:Array = new Array();
		
		/** 选择结果标签 */
		private var result:Label = new Label();
		
		//-------------------------------------------------------------------
		/** 显示标签集合 */
		private var _labelCollection:String = "标识01:标识02";
		//显示标签数组
		private var labelArr:Array = new Array();
		
		public function set labelCollection(value:String):void{
			if(_labelCollection != value){
				this._labelCollection = value;
				labelArr = value.split(":");
				selectContent = labelArr[0];
				result.uiLabel = labelArr[0];
				result.forceFresh();
				_selectIndex = 0;
			}
		}
		
		public function get labelCollection():String{
			return _labelCollection;
		}
		
		public function get selectIndex():int{
			return _selectIndex;
		}
		
		public function set selectIndex(value:int):void{
			if (_selectIndex != value){
				_selectIndex = value;
				result.uiLabel = labelArr[_selectIndex];
				selectContent = labelArr[_selectIndex];
			}
		}
		
		//-------------------------------------------------------------------
		/** 选项条的宽度 */
		private var _itemWidth:int = 100;
		
		public function set itemWidth(value:int):void{
			this._itemWidth = value;
			result.x = this.uiWidth - _itemWidth;
			result.uiWidth = _itemWidth - this.uiWidth;
		}
		
		public function get itemWidth():int{
			return this._itemWidth;
		}
		
		//-------------------------------------------------------------------
		/** 选项条的高度 */
		private var _itemHeight:int = 16;
		
		public function set itemHeight(value:int):void{
			this._itemHeight = value;
		}
		
		public function get itemHeight():int{
			return this._itemHeight;
		}
		
		//-------------------------------------------------------------------
		
		override public function set uiHeight(value:uint):void
		{
			super.uiHeight = value;
			result.y = (value-16)/2;
		}
		
		//-------------------------------------------------------------------
		
		public function ListButton(width:Number=16, height:Number=16){
			super(width, height);
		}
		
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.LIST_BUTTON;
			this.addEventListener(FocusEvent.FOCUS_IN , focusIn);
			this.addEventListener(FocusEvent.FOCUS_OUT , focusOut);
			this.addEventListener(MouseEvent.CLICK , click);
			result.uiAlign = LayoutStyle.CENTER;
			result.mouseEnabled = false;
			result.uiTxtColor = "0xffffff"; 
			this.addChild(result);
		}
		
		private var focusHold:Timer = new Timer(200 , 1);
		
		private function focusOut(event:FocusEvent):void{
			trace("focusOut");
			focusHold.addEventListener(TimerEvent.TIMER_COMPLETE , focusOutExe);
			focusHold.start();
		}
		
		private function focusOutExe(event:TimerEvent):void{
			if(this.show == true){
				this.show = false;
				removeAllItems();
			}
			focusHold.reset();
			focusHold.stop();
		}
		
		
		private function focusIn(event:FocusEvent):void{
			trace("focusIn   进来啦");
		}
		
		private var _frameBg:Sprite = new Sprite();
		private var _frameBgInited:Boolean = false;
		/** 绘制线框背景 */
		private function showFrameBg(show:Boolean, w:int = 1, h:int = 1):void{
			if(!_frameBgInited){
				_frameBg.mouseChildren = false;
				_frameBg.mouseEnabled = false;
				_frameBg.x = this.uiWidth - this._itemWidth;;
				_frameBg.y = this.uiHeight;
				addChild(_frameBg);
				_frameBgInited = true;
			}
			_frameBg.graphics.clear();
			if(show){
				_frameBg.graphics.lineStyle(1, 0x889a8a);
				_frameBg.graphics.drawRect(-1, 0, w + 1, h + 1);
			}
		}
		
		
		/** 点击按钮本身触发的事件 */
		private function click(event:MouseEvent):void{
			if(this.show == false){trace("click   this.show == false");
				this.show = true;
				showFrameBg(true, _itemWidth, _itemHeight * labelArr.length);
				for(var i:int = 0 ; i < labelArr.length ; i++){
					trace("点击按钮本身 true情况");
					var item:ListButtonItem = new ListButtonItem(labelArr[i] , _itemWidth , _itemHeight);
					item.index = i;
					item.addEventListener(MouseEvent.CLICK , item_click);
					itemArr.push(item);
					this.addChild(item);
					item.x = this.uiWidth - this._itemWidth;
					item.y = this.uiHeight + i * _itemHeight;
				}
			}else{trace("click   this.show == true");
				this.show = false;
				removeAllItems();
			}
			event.stopImmediatePropagation();
			event.stopPropagation();
		}
		
		
		
		/** 移除所有选项 */
		private function removeAllItems():void{
			showFrameBg(false);
			for(var i:int = 0 ; i <  itemArr.length ; i++){
				this.removeChild(itemArr[i]);
				itemArr[i] = null;
			}
			itemArr = [];
		}
		
		
		/** 选项被点击 */
		private function item_click(event:MouseEvent):void{
			var value:int = ListButtonItem(event.target).index;
			trace("XXXXXXXXXXXX  选项被点击", value, selectIndex);
			if (selectIndex != value){
				selectIndex = ListButtonItem(event.target).index;
				result.uiLabel = labelArr[selectIndex];
				selectContent = labelArr[selectIndex];
			}
		}
		
		
		
		
		
	}
}