package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[Event(name="select", type="flash.events.Event")]
	public class JComboBox extends JComponent
	{
		/** JComboBox */
		public function JComboBox(defaultLabel:String="", items:Array = null)
		{
			_defaultLabel = defaultLabel;
			_items = items;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			super();
			this._type = JuiType.JComboBox;
		}
		
		protected var _dropDownButton:JPushButton;
		public function get dropDownButton():JPushButton { return _dropDownButton; }
		
		protected var _labelButton:JPushButton;
		public function get labelButton():JPushButton { return _labelButton; }
		
		protected var _list:JList;
		public function get list():JList { return _list; }
		
		protected var _open:Boolean = false;
		/** whether or not the combo box is currently open.*/
		public function get isOpen():Boolean { return _open; }
		
		protected var _stage:Stage;
		
		protected var _defaultLabel:String = "";
		/** 默认说明 */
		public function set defaultLabel(value:String):void
		{
			_defaultLabel = value;
			setLabelButtonLabel();
		}
		public function get defaultLabel():String { return _defaultLabel; }
		
		protected var _items:Array;
		/** 数据成员项 */
		public function set items(value:Array):void
		{
			_list.items = value;
		}
		public function get items():Array { return _list.items; }
		
		protected var _openPosition:String = JuiConst.DOWN;
		/** 列表打开位置， 上方就是UP，下方就是DOWN，默认DOWN */
		public function set openPosition(value:String):void
		{
			if(value == JuiConst.UP) { _openPosition = JuiConst.UP; }
			else { _openPosition = JuiConst.DOWN; }
		}
		public function get openPosition():String { return _openPosition; }
		
		protected var _numVisibleItems:int = 6;
		/** 可视条数 */
		public function set numVisibleItems(value:int):void
		{
			_numVisibleItems = Math.max(1, value);
			invalidate();
		}
		public function get numVisibleItems():int { return _numVisibleItems; }
		
		/** the index of the selected list item. */
		public function set selectedIndex(value:int):void
		{
			_list.selectedIndex = value;
			setLabelButtonLabel();
		}
		public function get selectedIndex():int { return _list.selectedIndex; }
		public function changeSelectedIndex(value:int, needDispatchEvent:Boolean=false):void
		{
			_list.changeSelectedIndex(value, needDispatchEvent);
			setLabelButtonLabel();
		}
		
		/** the item in the list, if it exists.*/
		public function set selectedItem(item:Object):void
		{
			_list.selectedItem = item;
			setLabelButtonLabel();
		}
		public function get selectedItem():Object { return _list.selectedItem; }
		public function changeSelectedItem(item:Object, needDispatchEvent:Boolean=false):void
		{
			_list.changeSelectedItem(item, needDispatchEvent);
			setLabelButtonLabel();
		}
		
		
		/** Initilizes the component */
		protected override function init():void
		{
			super.init();
			setSize(100, 25);
			setLabelButtonLabel();
		}
		
		/** Creates and adds the child display objects of this component.*/
		protected override function addChildren():void
		{
			super.addChildren();
			_list = new JList(_items);
			_list.autoHideScrollBar = true;
			_list.addEventListener(Event.SELECT, onSelect);
			
			_labelButton = new JPushButton("", onDropDown);
			_labelButton.height = 25;
			_dropDownButton = new JPushButton("", onDropDown);//new JPushButton("+", onDropDown);
			_dropDownButton.setSize(17, 25);
			
			this.addChild(_labelButton);
			this.addChild(_dropDownButton);
		}
		
		/** Determines what to use for the main button label and sets it. */
		protected function setLabelButtonLabel():void
		{
			if(selectedItem == null)
			{
				_labelButton.caption = _defaultLabel;
			}
			else if(selectedItem is String)
			{
				_labelButton.caption = selectedItem as String;
			}
			else if(selectedItem.hasOwnProperty("label") && selectedItem.label is String)
			{
				_labelButton.caption = selectedItem.label;
			}
			else
			{
				_labelButton.caption = selectedItem.toString();
			}
		}
		
		/**
		 * Removes the list from the stage.
		 */
		protected function removeList():void
		{
			if(_stage.contains(_list)) _stage.removeChild(_list);
			_stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			//_dropDownButton.caption = "+";		
		}
		
		/** draw */
		public override function draw():void
		{
			super.draw();
			
			_labelButton.setSize(_width - _dropDownButton.width, _height);
			
			_dropDownButton.x = _width - _dropDownButton.width;
			
			_list.setSize(_width, _numVisibleItems * _list.listItemHeight);
		}
		
		/**
		 * Called when the component is added to the stage.
		 */
		protected function onAddedToStage(event:Event):void
		{
			_stage = stage;
		}
		
		/**
		 * Called when the component is removed from the stage.
		 */
		protected function onRemovedFromStage(event:Event):void
		{
			removeList();
		}
		
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_list.addItem(item);
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_list.addItemAt(item, index);
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			_list.removeItem(item);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			_list.removeItemAt(index);
		}
		
		/** Removes all items from the list. */
		public function removeAll():void
		{
			_list.removeAll();
		}
		
		/**  Called when one of the top buttons is pressed. Either opens or closes the list. */
		protected function onDropDown(event:MouseEvent):void
		{
			_open = !_open;
			if(_open)
			{
				var point:Point = new Point();
				if(_openPosition == JuiConst.DOWN)
				{
					point.y = _height;
				}
				else
				{
					point.y = -_numVisibleItems * _list.listItemHeight;
				}
				point = this.localToGlobal(point);
				_list.move(point.x, point.y);
				_stage.addChild(_list);
				_stage.addEventListener(MouseEvent.CLICK, onStageClick);
				//_dropDownButton.caption = "-";
			}
			else
			{
				removeList();
			}
		}
		
		/**
		 * Called when the mouse is clicked somewhere outside of the combo box when the list is open. Closes the list.
		 */
		protected function onStageClick(event:MouseEvent):void
		{
			// ignore clicks within buttons or list
			if(event.target == _dropDownButton || event.target == _labelButton) return;
			if(new Rectangle(_list.x, _list.y, _list.width, _list.height).contains(event.stageX, event.stageY)) return;
			
			_open = false;
			removeList();
		}
		
		/**
		 * Called when an item in the list is selected. Displays that item in the label button.
		 */
		protected function onSelect(event:Event):void
		{
			_open = false;
			//_dropDownButton.caption = "+";
			if(stage != null && stage.contains(_list))
			{
				stage.removeChild(_list);
			}
			setLabelButtonLabel();
			dispatchEvent(event);
		}
		
	}
}