package com.anstu.jui.controls
{
	import com.anstu.jui.components.ICaption;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.components.StListItemData;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class JList extends JComponent
	{
		/** JList */
		public function JList(items:Array=null)
		{
			if(items != null)
			{
				_items = items;
			}
			else
			{
				_items = new Array();
			}
			super();
			this._type = JuiType.JList;
		}
		
		protected var _items:Array;
		/** 成员项 */
		public function set items(value:Array):void
		{
			_items = value;
			makeListItems();
			fillItems();
			invalidate();
		}
		public function get items():Array { return _items; }
		
		/** 选中的数据成员项 */
		public function set selectedItem(item:Object):void
		{
			changeSelectedItem(item);
		}
		public function get selectedItem():Object
		{
			if(_selectedIndex >= 0 && _selectedIndex < _items.length)
			{
				return _items[_selectedIndex];
			}
			return null;
		}
		/** 改变选中的数据成员项
		 * @param item:Object 成员项
		 * @param needDispatchEvent:Boolean=false 是否触发Event.SELECT事件 */
		public function changeSelectedItem(item:Object, needDispatchEvent:Boolean=false):void
		{
			var index:int = _items.indexOf(item);
			changeSelectedIndex(index, needDispatchEvent);
		}
		
		protected var _itemHolder:Sprite;
		protected var _panel:JPanel;
		public function get panel():JPanel { return _panel; }
		
		protected var _listItemHeight:Number = 20;
		/** 选项高度 */
		public function set listItemHeight(value:Number):void
		{
			_listItemHeight = value;
			makeListItems();
			invalidate();
		}
		public function get listItemHeight():Number { return _listItemHeight; }
		
		/** 选项宽度[当存在滚动条时候的] */
		protected function get listItemWidth():int
		{
			var w:int = _width - _scrollbar.width;
			if(w <= 0) { return 10; }
			return w;
		}
		
		protected var _listItemClass:Class = JListItem;
		/** 列表选项所使用的类 */
		public function set listItemClass(value:Class):void
		{
			_listItemClass = value;
			makeListItems();
			invalidate();
		}
		public function get listItemClass():Class { return _listItemClass; }
		
		protected var _scrollbar:JScrollBar;
		public function get scrollBar():JScrollBar { return _scrollbar; }
		
		protected var _selectedIndex:int = -1;
		/** 选择的序列 */
		public function set selectedIndex(value:int):void
		{
			changeSelectedIndex(value, true);
		}
		public function get selectedIndex():int { return _selectedIndex; }
		/** 改变选择的序列
		 * @param value:int 序号值
		 * @param needDispatchEvent:Boolean=false 是否触发Event.SELECT事件 */
		public function changeSelectedIndex(value:int, needDispatchEvent:Boolean=false):void
		{
			if(value >= 0 && value < _items.length)
			{
				_selectedIndex = value;
				_scrollbar.value = _selectedIndex;
			}
			else
			{
				_selectedIndex = -1;
			}
			invalidate();
			if(needDispatchEvent)
			{
				dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		protected var _itemBgAlpha:Number = 0.8;
		/** 选项背景颜色的alpha */
		public function set itemBgAlpha(value:Number):void
		{
			_itemBgAlpha = value;
			invalidate();
		}
		public function get itemBgAlpha():Number { return _itemBgAlpha; }
		
		protected var _defaultColor:uint = JStyle.LIST_DEFAULT;
		/** 默认选项背景颜色 */
		public function set defaultColor(value:uint):void
		{
			_defaultColor = value;
			invalidate();
		}
		public function get defaultColor():uint { return _defaultColor; }
		
		protected var _selectedColor:uint = JStyle.LIST_SELECTED;
		/** 选中时选项背景颜色 */
		public function set selectedColor(value:uint):void
		{
			_selectedColor = value;
			invalidate();
		}
		public function get selectedColor():uint { return _selectedColor; }
		
		protected var _rolloverColor:uint = JStyle.LIST_ROLLOVER;
		/** 鼠标经过时选项背景颜色 */
		public function set rolloverColor(value:uint):void
		{
			_rolloverColor = value;
			invalidate();
		}
		public function get rolloverColor():uint
		{
			return _rolloverColor;
		}
		
		protected var _alternateColor:uint = JStyle.LIST_ALTERNATE;
		/** 隔行选项背景颜色 */
		public function set alternateColor(value:uint):void
		{
			_alternateColor = value;
			invalidate();
		}
		public function get alternateColor():uint { return _alternateColor; }
		
		protected var _alternateRows:Boolean = true;
		/** 是否使用隔行背景颜色 */
		public function set alternateRows(value:Boolean):void
		{
			_alternateRows = value;
			invalidate();
		}
		public function get alternateRows():Boolean { return _alternateRows; }
		
		/** 是否自动隐藏滚动条 */
		public function set autoHideScrollBar(value:Boolean):void
		{
			_scrollbar.autoHide = value;
		}
		public function get autoHideScrollBar():Boolean { return _scrollbar.autoHide; }
		
		protected var _format:JTextFormat = new JTextFormat();
		/** textField的文本样式 */
		public function set textFormat(f:JTextFormat):void
		{
			_format = f;
			invalidate();
		}
		public function get textFormat():JTextFormat { return _format; }
		
		//----------label---beg-----------
		protected var _useStroke:Boolean = false;
		/** 是否使用描边 */
		public function set useStroke(b:Boolean):void
		{
			if(_useStroke != b)
			{
				_useStroke = b;
				invalidate();
			}
		}
		public function get useStroke():Boolean { return _useStroke; }
		
		protected var _strokeColor:int = 0x0e0600;
		/** 描边颜色 */
		public function set strokeColor(c:int):void
		{
			_strokeColor = c;
			invalidate();
		}
		public function get strokeColor():int { return _strokeColor; }
		
		protected var _strokeBlur:int = 4;
		/** 描边扩散 */
		public function set strokeBlur(b:int):void
		{
			_strokeBlur = b;
			invalidate();
		}
		public function get strokeBlur():int { return _strokeBlur; }
		
		protected var _strokeStrength:int = 4;
		/** 描边强度 */
		public function set strokeStrength(s:int):void
		{
			_strokeStrength = s;
			invalidate();
		}
		public function get strokeStrength():int { return _strokeStrength; }
		
		protected var _useHtml:Boolean = false;
		/** 是否使用Html */
		public function set useHtml(b:Boolean):void
		{
			if(_useHtml != b)
			{
				_useHtml = b;
				invalidate();
			}
		}
		public function get useHtml():Boolean { return _useHtml; }
		//----------label---end-----------
		
		/** init */
		protected override function init() : void
		{
			super.init();
			setSize(100, 100);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            addEventListener(Event.RESIZE, onResize);
            makeListItems();
            fillItems();
		}
		
		/** addChildren */
		protected override function addChildren() : void
		{
			super.addChildren();
			_format.color = 0xfefe00;
			_panel = new JPanel();
			_itemHolder = new Sprite();
			_panel.content.addChild(_itemHolder);
			this.addChild(_panel);
			_scrollbar = new JScrollBar(JuiConst.VERTICAL, onScroll);
            _scrollbar.setSliderParams(0, 0, 0);
			this.addChild(_scrollbar);
		}
		
		/**
		 * Creates all the list items based on data.
		 */
		protected function makeListItems():void
		{
			var item:JListItem;
			while(_itemHolder.numChildren > 0)
			{
				item = JListItem(_itemHolder.getChildAt(0));
				item.removeEventListener(MouseEvent.CLICK, onSelect);
				_itemHolder.removeChildAt(0);
			}

            var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
            numItems = Math.max(numItems, 1);
			for(var i:int = 0; i < numItems; i++)
			{
				item = new _listItemClass();
				item.x = 0;
				item.y = i * _listItemHeight;
				item.setSize(listItemWidth, _listItemHeight);
				item.label.textFormat = _format;
				item.label.align = JuiConst.CENTER;
				item.label.useStroke = _useStroke;
				item.label.strokeColor = _strokeColor;
				item.label.strokeBlur = _strokeBlur;
				item.label.strokeStrength = _strokeStrength;
				item.label.useHtml = _useHtml;
				item.defaultColor = _defaultColor;
				item.selectedColor = _selectedColor;
				item.rolloverColor = _rolloverColor;
				item.bgAlpha = _itemBgAlpha;
				item.addEventListener(MouseEvent.CLICK, onSelect);
				_itemHolder.addChild(item);
			}
		}

		/** 变成所需的结构 */
		protected function makeItemStruct(item:Object):ICaption
		{
			if(item == null) { return null; }
			if(item is ICaption) { return item as ICaption; }
			if(item.hasOwnProperty("text") && item.text is String)
			{
				return new StListItemData(item.text as String, item);
			}
			if(item.hasOwnProperty("label") && item.label is String)
			{
				return new StListItemData(item.label as String, item);
			}
			if(item.hasOwnProperty("caption") && item.caption is String)
			{
				return new StListItemData(item.caption as String, item);
			}
			return new StListItemData(item.toString(), item);
		}
		
        protected function fillItems():void
        {
            var offset:int = _scrollbar.value;
            var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length, _itemHolder.numChildren);
            for(var i:int = 0; i < numItems; i++)
            {
                var item:JListItem = _itemHolder.getChildAt(i) as JListItem;
				if(offset + i < _items.length)
				{
	                item.data = makeItemStruct(_items[offset + i]);
				}
				else
				{
					item.data = null;
				}
				if(_alternateRows)
				{
					item.defaultColor = ((offset + i) % 2 == 0) ? _defaultColor : _alternateColor;
				}
				else
				{
					item.defaultColor = _defaultColor;
				}
                if(offset + i == _selectedIndex)
                {
                    item.selected = true;
                }
                else
                {
                    item.selected = false;
                }
            }
        }
		
		/**
		 * If the selected item is not in view, scrolls the list to make the selected item appear in the view.
		 */
		protected function scrollToSelection():void
		{
            var numItems:int = Math.ceil(_height / _listItemHeight);
			if(_selectedIndex != -1)
			{
				if(_scrollbar.value > _selectedIndex)
				{
					//_scrollbar.value = _selectedIndex;
				}
				else if(_scrollbar.value + numItems < _selectedIndex)
				{
                    _scrollbar.value = _selectedIndex - numItems + 1;
				}
			}
			else
			{
				_scrollbar.value = 0;
			}
            fillItems();
		}
		
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw() : void
		{
			super.draw();
			makeListItems();//新增
			_selectedIndex = Math.min(_selectedIndex, _items.length - 1);
			// scrollbar
			_scrollbar.x = listItemWidth;
			var contentHeight:Number = _items.length * _listItemHeight;
			var thumbPercent:Number = _height / contentHeight;
			_scrollbar.thumbPercent = thumbPercent;
			var pageSize:Number = Math.floor(_height / _listItemHeight);
            _scrollbar.maximum = Math.max(0, _items.length - pageSize);
			_scrollbar.step = 1;
			_scrollbar.height = _height;
			_scrollbar.draw();
            scrollToSelection();
			//
			if(thumbPercent < 1.0)
			{
				_panel.height = _height;
				ajustItemWidth(true);
			}
			else
			{
				_panel.height = contentHeight;
				ajustItemWidth(false);
			}
		}
		
		private function ajustItemWidth(overflow:Boolean):void
		{
			_panel.width = overflow ? listItemWidth : _width;
			//
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				var item:DisplayObject = _itemHolder.getChildAt(i) as DisplayObject;
				item.width = overflow ? listItemWidth : _width;
			}
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_items.push(item);
			invalidate();
			makeListItems();
      		fillItems();
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			index = Math.max(0, index);
			index = Math.min(_items.length, index);
			_items.splice(index, 0, item);
			invalidate();
      		makeListItems();
      		fillItems();
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
			removeItemAt(index);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			if(index < 0 || index >= _items.length) return;
			_items.splice(index, 1);
			invalidate();
     		makeListItems();
     		fillItems();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_items.length = 0;
			invalidate();
      		makeListItems();
      		fillItems();
		}
		
		/**
		 * Called when a user selects an item in the list.
		 */
		protected function onSelect(event:Event):void
		{
			if(! (event.target is JListItem)) return;
			
			var offset:int = _scrollbar.value;
			
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) _selectedIndex = i + offset;
				JListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			JListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		/**
		 * Called when the user scrolls the scroll bar.
		 */
		protected function onScroll(event:Event):void
		{
            fillItems();
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
            fillItems();
		}

        protected function onResize(event:Event):void
        {
            makeListItems();
            fillItems();
        }

	}
}