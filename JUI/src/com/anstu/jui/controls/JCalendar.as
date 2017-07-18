package com.anstu.jui.controls
{
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class JCalendar extends JPanel
	{
		public static const MONTH_CH:Array = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"];
		public static const MONTH_EN:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		public static const MONTH_JP:Array = ["いちがつ", "にがつ", "さんがつ", "しがつ", "ごがつ", "ろくがつ", "しちがつ", "はちがつ", "くがつ", "じゅうがつ", "じゅういちがつ", "じゅうにがつ"];
		
		public var monthNames:Array = MONTH_CH;
		
		protected var _dateLabelPattern:String = "{yy}年 {mm}{dd}日";
		/** 日期标签的格式 */
		public function set dateLabelPattern(value:String):void
		{
			_dateLabelPattern = value;
			invalidate();
		}
		public function get dateLabelPattern():String { return _dateLabelPattern; }
		
		protected var _day:int;
		public function get day():int { return _day; }
		
		protected var _month:int;
		public function get month():int { return _month; }
		
		protected var _year:int;
		public function get year():int { return _year; }
		
		/** Gets the currently selected Date. */
		public function get selectedDate():Date
		{
			return new Date(_year, _month, _day);
		}
		
		protected var _dateLabel:JLabel;
		public function get dateLabel():JLabel { return _dateLabel; }
		
		protected var _selection:DisplayObject;
		public function fillSelection(filler:DisplayObject):void
		{
			if(_selection && _selection.parent) { _selection.parent.removeChild(_selection); }
			_selection = filler;
			if(_selection) { this.content.addChild(_selection); }
			invalidate();
		}
		
		protected var _dayButtons:Array = new Array();
		
		public var prevYearBtn:JPushButton;
		public var prevMonthBtn:JPushButton;
		public var nextMonthBtn:JPushButton;
		public var nextYearBtn:JPushButton;
		
		protected var _ctrlBtnW:int = 24;
		public function set ctrlBtnW(value:int):void
		{
			_ctrlBtnW = value;
			invalidate();
		}
		public function get ctrlBtnW():int { return _ctrlBtnW; }
		
		protected var _ctrlBtnH:int = 40;
		public function set ctrlBtnH(value:int):void
		{
			_ctrlBtnH = value;
			invalidate();
		}
		public function get ctrlBtnH():int { return _ctrlBtnH; }
		
		protected var _dayBtnW:int = 35;
		public function set dayBtnW(value:int):void
		{
			_dayBtnW = value;
			invalidate();
		}
		public function get dayBtnW():int { return _dayBtnW; }
		
		protected var _dayBtnH:int = 30;
		public function set dayBtnH(value:int):void
		{
			_dayBtnH = value;
			invalidate();
		}
		public function get dayBtnH():int { return _dayBtnH; }
		
		protected var _dayBtnGap:int = 3;
		public function set dayBtnGap(value:int):void
		{
			_dayBtnGap = value;
			invalidate();
		}
		public function get dayBtnGap():int { return _dayBtnGap; }
		
		protected var _margin:int = 5;
		public function set margin(value:int):void
		{
			_margin = value;
			invalidate();
		}
		public function get margin():int { return _margin; }
		
		protected var _partGap:int = 10;
		/** 控制按钮区域 和 日期按钮区域 之间的间隔 */
		public function set partGap(value:int):void
		{
			_partGap = value;
			invalidate();
		}
		public function get partGap():int { return _partGap; }
		
		protected var _dayBtnSkinChanged:Boolean = false;
		protected var _dayBtnSkin:JPushButtonSkin;
		public function set dayBtnSkin(value:JPushButtonSkin):void
		{
			if(_dayBtnSkin != value)
			{
				_dayBtnSkin = value;
				_dayBtnSkinChanged = true;
				invalidate();
			}
		}
		public function get dayBtnSkin():JPushButtonSkin { return _dayBtnSkin; }
		
		public function JCalendar()
		{
			super();
			this._type = JuiType.JCalendar;
		}
		
		/**
		 * Initializes the component.
		 */
		protected override function init() : void
		{
			super.init();
			var today:Date = new Date();
			setDate(today);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren() : void
		{
			super.addChildren();
			for(var i:int = 0; i < 6; i++)
			{
				for(var j:int = 0; j < 7; j++)
				{
					var btn:JPushButton = new JPushButton();
					this.content.addChild(btn);
					btn.move(_margin + j * (_dayBtnW + _dayBtnGap), _margin + i * (_dayBtnH + _dayBtnGap) + _ctrlBtnH + _partGap);
					btn.setSize(_dayBtnW, _dayBtnH);
					btn.addEventListener(MouseEvent.CLICK, onDayClick);
					_dayButtons.push(btn);
				}
			}
			
			_dateLabel = new JLabel();
			this.content.addChild(_dateLabel);
			_dateLabel.align = JuiConst.CENTER;
			
			prevYearBtn = new JPushButton("", onPrevYear);
			//prevYearBtn.label = "«";
			this.content.addChild(prevYearBtn);
			
			prevMonthBtn = new JPushButton("", onPrevMonth);
			//prevMonthBtn.label = "<";
			this.content.addChild(prevMonthBtn);
			
			nextMonthBtn = new JPushButton("", onNextMonth);
			//nextMonthBtn.label = ">";
			this.content.addChild(nextMonthBtn);
			
			nextYearBtn = new JPushButton("", onNextYear);
			//nextYearBtn.label = "»";
			this.content.addChild(nextYearBtn);
		}
		
		override public function draw():void
		{
			_width = _dayBtnW * 7 + _dayBtnGap * 6 + _margin * 2;
			_height = _dayBtnH * 6 + _dayBtnGap * 5 + _margin * 2 + _ctrlBtnH + _partGap;
			
			_dateLabel.width = _width;
			
			prevYearBtn.move(_margin, _margin);
			prevYearBtn.setSize(_ctrlBtnW, _ctrlBtnH);
			prevMonthBtn.move(_margin+_ctrlBtnW+_dayBtnGap, _margin);
			prevMonthBtn.setSize(_ctrlBtnW, _ctrlBtnH);
			nextMonthBtn.move(_width-_margin-_ctrlBtnW*2-_dayBtnGap, _margin);
			nextMonthBtn.setSize(_ctrlBtnW, _ctrlBtnH);
			nextYearBtn.move(_width-_ctrlBtnW-_margin, _margin);
			nextYearBtn.setSize(_ctrlBtnW, _ctrlBtnH);
			
			if(_dayBtnSkinChanged)
			{
				for(var i:int = 0; i < _dayButtons.length; i++)
				{
					var dbtn:JPushButton = _dayButtons[i];
					if(_dayBtnSkin)
					{
						_dayBtnSkin.apply(dbtn);
					}
					else
					{
						dbtn.fillDefaultBg(null);
						dbtn.fillOverBg(null);
						dbtn.fillDownBg(null);
					}
					dbtn.move(_margin + (i%7) * (_dayBtnW + _dayBtnGap), _margin + Math.floor(i/7) * (_dayBtnH + _dayBtnGap) + _ctrlBtnH + _partGap);
					dbtn.setSize(_dayBtnW, _dayBtnH);
				}
				_dayBtnSkinChanged = false;
			}
			
			if(_selection)
			{
				_selection.width = _dayBtnW;
				_selection.height = _dayBtnH;
			}
			//setSelectionPos();
			setDate(selectedDate);
			
			super.draw();
		}
		
		/**
		 * Gets the last day of the specfied month and year. Needed by layout.
		 * @param month The month to get the last day of.
		 * @param year The year in which the month is in (needed for leap years).
		 * @return The last day of the month.
		 */
		protected function getEndDay(month:int, year:int):int
		{
			switch(month)
			{
				case 0:		// jan
				case 2:		// mar
				case 4:		// may
				case 6:		// july
				case 7:		// aug
				case 9:		// oct
				case 11:	// dec
					return 31;
					break;
				
				case 1:		// feb
					if((year % 400 == 0) ||  ((year % 100 != 0) && (year % 4 == 0))) return 29;
					return 28;
					break;
				
				default:	
					break;
			}
			// april, june, sept, nov.
			return 30;
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		private var _selectionX:int = 0;
		private var _selectionY:int = 0;
		private function setSelectionPos():void
		{
			if(_selection)
			{
				_selection.x = _selectionX;
				_selection.y = _selectionY;
			}
		}
		
		/**
		 * Displays specified date in calendar by drawing that month and year and highlighting the day.
		 * @param date The date to display.
		 */
		public function setDate(date:Date):void
		{
			_year = date.fullYear;
			_month = date.month;
			_day = date.date;
			var startDay:int = new Date(_year, _month, 1).day;
			var endDay:int = getEndDay(_month, _year);
			for(var i:int = 0; i < 42; i++)
			{
				_dayButtons[i].visible = false;
			}
			for(i = 0; i < endDay; i++)
			{
				var btn:JPushButton = _dayButtons[i + startDay];
				btn.visible = true;
				btn.caption = (i + 1).toString();
				btn.tag = (i + 1).toString();
				if(i + 1 == _day)
				{
					_selectionX = btn.x;
					_selectionY = btn.y;
					setSelectionPos();
				}
			}
			
			_dateLabel.text = createYMDWords(_year, _month, _day);
			_dateLabel.draw();
		}
		
		protected function createYMDWords(year:int, month:int, day:int):String
		{
			var words:String = _dateLabelPattern;
			words = words.replace("{yy}", year);
			words = words.replace("{mm}", monthNames[month]);
			words = words.replace("{dd}", day);
			return  words;
		}
		
		/**
		 * Displays specified date in calendar by drawing that month and year and highlighting the day.
		 * @param year The year to display.
		 * @param month The month to display.
		 * @param day The day to display.
		 */
		public function setYearMonthDay(year:int, month:int, day:int):void
		{
			setDate(new Date(year, month, day));
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Advances the month forward by one.
		 */
		protected function onNextMonth(event:MouseEvent):void
		{
			_month++;
			if(_month > 11)
			{
				_month = 0;
				_year++;
			}
			_day = Math.min(_day,getEndDay(_month,_year));
			setYearMonthDay(_year, _month, _day);
		}
		
		/**
		 * Moves the month back by one.
		 */
		protected function onPrevMonth(event:MouseEvent):void
		{
			_month--;
			if(_month < 0)
			{
				_month = 11;
				_year--;
			}
			_day = Math.min(_day,getEndDay(_month,_year));
			setYearMonthDay(_year, _month, _day);
		}
		
		/**
		 * Advances the year forward by one.
		 */
		protected function onNextYear(event:MouseEvent):void
		{
			_year++;
			_day = Math.min(_day,getEndDay(_month,_year));
			setYearMonthDay(_year, _month, _day);
		}
		
		/**
		 * Moves the year back by one.
		 */
		protected function onPrevYear(event:MouseEvent):void
		{
			_year--;
			_day = Math.min(_day,getEndDay(_month,_year));
			setYearMonthDay(_year, _month, _day);
		}
		
		/**
		 * Called when a date button is clicked. Selects that date.
		 */
		protected function onDayClick(event:MouseEvent):void
		{
			_day = parseInt(event.target.tag);
			setYearMonthDay(_year, _month, _day);
			dispatchEvent(new Event(Event.SELECT));
		}
		
	}
}