package ui.ctrls.Advanced
{
	import ui.ctrls.Advanced.SelectList.SelectListDefine;
	import ui.ctrls.Advanced.SelectList.SelectListEvent;
	import ui.ctrls.Advanced.SelectList.SelectListItem;
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.Common.CommonDefine;
	import ui.ctrls.Label;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.StrokeLabel;
	import ui.ctrls.UIInfo;
	
	import ui.ctrls.uiEvent.EventController;
	
	import flash.events.MouseEvent;
	
	public class SelectList extends Ape
	{
		/** 收缩状态标记 */
		private var _show:Boolean = false;
		public function set show(value:Boolean):void
		{
			_show = value;
			if(_show == true)
			{
				this.addChild(scroll);
			}
			else
			{
				if(scroll.parent)
					scroll.parent.removeChild(scroll);
			}
		}
		public function get show():Boolean
		{
			return _show;
		}
		
		/** 选择的序列 */
		private var _selectIndex:int = 0;
		
		/** 选择序列所对应的标签内容 */
		public var selectContent:String = "";
		
		/** 所有选项存储数组 */
		private var itemArr:Array = new Array();
		
		/** 选择结果标签 */
		private var result:StrokeLabel = new StrokeLabel();
		
		//-------------------------------------------------------------------
		/** 显示标签集合 */
		private var _labelCollection:String = "标识01:标识02";
		//显示标签数组
		private var labelArr:Array = new Array();
		
		public function set labelCollection(value:String):void
		{
			if(_labelCollection != value)
			{
				this._labelCollection = value;
				labelArr = value.split(":");
				selectContent = labelArr[0];
				result.uiLabel = labelArr[0];
				result.forceFresh();
				_selectIndex = 0;
				adjustScroll();
				scroll.clearCanvas();
				for(var i:int = 0; i < labelArr.length; i++)
				{
					var item:SelectListItem = new SelectListItem(labelArr[i], this.uiWidth, SelectListDefine.ITEM_HEIGHT, this.uiName, i);
					item.x = 0;
					item.y = i * SelectListDefine.ITEM_HEIGHT;
					scroll.canvas.addChild(item);
				}
				scroll.forceFresh();
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
		
		//-----------------------------------------------------------------
		
		public override function set uiWidth(value:uint):void
		{
			if (value >= 0 && this._uiWidth != value)
			{
				this._uiWidth = value;
				fresh();
				adjustHitBtn();
				adjustScroll();
				adjustResult();
			}
		}
		
		//-----------------------------------------------------------------
		
		protected var _hitBtn:Button;
		
		protected var _scroll:ScrollFieldRight;
		public function get scroll():ScrollFieldRight
		{
			if(!_scroll)
			{
				_scroll = new ScrollFieldRight(this.uiWidth, limitHeight);
			}
			return _scroll;
		}
		
		//------------------------------------------------------------------
		
		/** 下拉限制高度 */
		protected var _limitHeight:int = 100;
		public function set limitHeight(value:int):void
		{
			if (value >= 0 && this._limitHeight != value)
			{
				this._limitHeight = value;
				adjustScroll();
			}
		}
		public function get limitHeight():int
		{
			return _limitHeight;
		}
		
		//------------------------------------------------------------------
		
		/** 是否可用(仅在render中使用，非编辑器使用) */
		private var _enabled:Boolean = true;
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if(_enabled == true)
			{
				//this.filters = [];
			}
			else
			{
				//this.filters = [CommonEffect.greyFilter];
			}
		}
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		//------------------------------------------------------------------
		
		public function SelectList(width:Number=100, height:Number=SelectListDefine.RESULT_HEIGHT)
		{
			super(width, height);
			initMe();
		}
		
		
		protected function initMe():void
		{
			this.uiSubType = UIInfo.SELECT_LIST;
			//
			result.uiWidth = this.uiWidth;
			result.uiHeight = SelectListDefine.RESULT_HEIGHT;
			result.uiAlign = LayoutStyle.CENTER;
			result.mouseEnabled = false;
			result.uiTxtColor = "0xffffff"; 
			result.uiTxtStrokeColor = "0x000000";
			addChild(result);
			//
			_hitBtn = new Button(SelectListDefine.HIT_BTN_WIDTH, SelectListDefine.HIT_BTN_HEIGHT);
			_hitBtn.uiLabel = "";
			_hitBtn.uiBgSrc = SelectListDefine.HIT_BTN_NORMAL_SRC;
			_hitBtn.stateOverSrc = SelectListDefine.HIT_BTN_OVER_SRC;
			_hitBtn.stateDownSrc = SelectListDefine.HIT_BTN_DOWN_SRC;
			_hitBtn.stateDisabledSrc = SelectListDefine.HIT_BTN_DISABLED_SRC;
			addChild(_hitBtn);
			adjustHitBtn();
			_hitBtn.addEventListener(MouseEvent.CLICK, hitBtn_click);
			//
			scroll.y = SelectListDefine.RESULT_HEIGHT;
			adjustScroll();
			//
			this.uiBgSrc = CommonDefine.TRANSPARENT_SRC;
			//
			EventController.instance().addEventListener(SelectListEvent.SELECT_LIST_ITEM_CLICK, item_click);
		}
		
		
		/** 调整点击按钮位置 */
		protected function adjustHitBtn():void
		{
			if(_hitBtn)
			{
				_hitBtn.x = this.uiWidth - _hitBtn.width;
				_hitBtn.y = 3;
			}
		}
		
		
		/** 调整scrollField */
		protected function adjustScroll():void
		{
			scroll.uiWidth = this.uiWidth;
			if(labelArr.length * SelectListDefine.ITEM_HEIGHT < limitHeight)
			{
				scroll.uiHeight = labelArr.length * SelectListDefine.ITEM_HEIGHT;
			}
			else
			{
				scroll.uiHeight = limitHeight;
			}
		}
		
		
		/** 调整result */
		protected function adjustResult():void
		{
			result.x = 0;
			result.uiWidth = this.uiWidth;
		}
		
		
		/** 辅助初始化标记 */
		protected var bInitHelp:Boolean = false;
		/** 点击按钮被点击 */
		protected function hitBtn_click(event:MouseEvent):void
		{
			if(bInitHelp == false)
			{
				this.labelCollection = labelCollection;
				bInitHelp = true;
			}
			if(enabled == true)
			{
				show = !show;
			}
		}
		
		
		/** 子项被点击 */
		protected function item_click(event:SelectListEvent):void
		{
			if(event.data.uiName == this.uiName)
			{
				show = false;
				//result.uiLabel = String(event.data.content);
				selectIndex = int(event.data.index);
			}
		}
		
	}
}