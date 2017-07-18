package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JCalendar;

	public class JCalendarSkin
	{
		public var dayBtn_label_font:String = "微软雅黑";
		public var dayBtn_label_size:int = 14;
		public var dayBtn_label_color:uint = 0xdede12;
		public var dayBtn_label_bold:Boolean = true;
		
		public var dateLabel_font:String = "微软雅黑";
		public var dateLabel_size:int = 16;
		public var dateLabel_color:uint = 0x2efe10;
		public var dateLabel_bold:Boolean = true;
		public var dateLabel_stroke:Boolean = true;
		public var dateLabel_offsetY:int = 10;
		
		public var base_ns:String = "base";
		
		public var dayBtn_defaultBg_cls:String = "calendarDay0.png";
		public var dayBtn_downBg_cls:String = "calendarDay1.png";
		public var dayBtn_overBg_cls:String = "calendarDay2.png";
		public var dayBtn_face_cls:String = null;
		
		public var prevYearBtn_defaultBg_cls:String = "calendarYP0.png";
		public var prevYearBtn_downBg_cls:String = "calendarYP1.png";
		public var prevYearBtn_overBg_cls:String = "calendarYP2.png";
		public var prevYearBtn_face_cls:String = null;
		
		public var prevMonthBtn_defaultBg_cls:String = "calendarMP0.png";
		public var prevMonthBtn_downBg_cls:String = "calendarMP1.png";
		public var prevMonthBtn_overBg_cls:String = "calendarMP2.png";
		public var prevMonthBtn_face_cls:String = null;
		
		public var nextYearBtn_defaultBg_cls:String = "calendarYN0.png";
		public var nextYearBtn_downBg_cls:String = "calendarYN1.png";
		public var nextYearBtn_overBg_cls:String = "calendarYN2.png";
		public var nextYearBtn_face_cls:String = null;
		
		public var nextMonthBtn_defaultBg_cls:String = "calendarMN0.png";
		public var nextMonthBtn_downBg_cls:String = "calendarMN1.png";
		public var nextMonthBtn_overBg_cls:String = "calendarMN2.png";
		public var nextMonthBtn_face_cls:String = null;
		
		public var chosen_cls:String = "calendar_chosen.png";
		
		public var background_ns:String = "base";
		public var background_cls:String = "miniRndBrdGreyFrame.png";
		
		public var ctrlBtnW:int = 19;
		public var ctrlBtnH:int = 19;
		public var partGap:int = 15;
		public var dayBtnW:int = 42;
		public var dayBtnH:int = 22;
		public var dayBtnGap:int = 5;
		public var margin:int = 10;
		
		public function JCalendarSkin()
		{
		}
		
		public function apply(cb:JCalendar):void
		{
			cb.ctrlBtnW = ctrlBtnW;
			cb.ctrlBtnH = ctrlBtnH;
			cb.partGap = partGap;
			cb.dayBtnW = dayBtnW;
			cb.dayBtnH = dayBtnH;
			cb.dayBtnGap = dayBtnGap;
			cb.margin = margin;
			
			cb.fillSelection( JResource.getBmp(chosen_cls, base_ns) );
			cb.fillBackground( JResource.getBmp(background_cls, background_ns) );
			
			cb.dateLabel.textFormat.font = dateLabel_font;
			cb.dateLabel.textFormat.size = dateLabel_size;
			cb.dateLabel.textFormat.color = dateLabel_color;
			cb.dateLabel.textFormat.bold = dateLabel_bold;
			cb.dateLabel.useStroke = dateLabel_stroke;
			cb.dateLabel.y = dateLabel_offsetY;
			
			var dbSkin:JPushButtonSkin = new JPushButtonSkin();
			dbSkin.base_ns = base_ns;
			dbSkin.labelFormat = new JTextFormat(dayBtn_label_font, dayBtn_label_size, dayBtn_label_color, dayBtn_label_bold);
			dbSkin.defaultBg_cls = dayBtn_defaultBg_cls;
			dbSkin.downBg_cls = dayBtn_downBg_cls;
			dbSkin.overBg_cls = dayBtn_overBg_cls;
			dbSkin.face_cls = dayBtn_face_cls;
			cb.dayBtnSkin = dbSkin;
			
			var prevYearBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			prevYearBtnSkin.base_ns = base_ns;
			prevYearBtnSkin.defaultBg_cls = prevYearBtn_defaultBg_cls;
			prevYearBtnSkin.downBg_cls = prevYearBtn_downBg_cls;
			prevYearBtnSkin.overBg_cls = prevYearBtn_overBg_cls;
			prevYearBtnSkin.face_cls = prevYearBtn_face_cls;
			prevYearBtnSkin.apply(cb.prevYearBtn);
			
			var prevMonthBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			prevMonthBtnSkin.base_ns = base_ns;
			prevMonthBtnSkin.defaultBg_cls = prevMonthBtn_defaultBg_cls;
			prevMonthBtnSkin.downBg_cls = prevMonthBtn_downBg_cls;
			prevMonthBtnSkin.overBg_cls = prevMonthBtn_overBg_cls;
			prevMonthBtnSkin.face_cls = prevMonthBtn_face_cls;
			prevMonthBtnSkin.apply(cb.prevMonthBtn);
			
			var nextYearBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			nextYearBtnSkin.base_ns = base_ns;
			nextYearBtnSkin.defaultBg_cls = nextYearBtn_defaultBg_cls;
			nextYearBtnSkin.downBg_cls = nextYearBtn_downBg_cls;
			nextYearBtnSkin.overBg_cls = nextYearBtn_overBg_cls;
			nextYearBtnSkin.face_cls = nextYearBtn_face_cls;
			nextYearBtnSkin.apply(cb.nextYearBtn);
			
			var nextMonthBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			nextMonthBtnSkin.base_ns = base_ns;
			nextMonthBtnSkin.defaultBg_cls = nextMonthBtn_defaultBg_cls;
			nextMonthBtnSkin.downBg_cls = nextMonthBtn_downBg_cls;
			nextMonthBtnSkin.overBg_cls = nextMonthBtn_overBg_cls;
			nextMonthBtnSkin.face_cls = nextMonthBtn_face_cls;
			nextMonthBtnSkin.apply(cb.nextMonthBtn);
		}
		
	}
}