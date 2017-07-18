package builder.view.prop.item
{
	import builder.view.prop.item.parts.PicChooser;

	public class PIButton extends PropItemBase
	{
		/** 是否需要xy坐标属性 */
		private var needXY:Boolean = false;
		/** 是否需要widht height尺寸属性 */
		private var needWH:Boolean = false;
		/** 是否需要调整标签属性 */
		private var needLabel:Boolean = false;
		
		public function setX(value:String):void { xPI.setValue(value); }
		public function getX():String { return xPI.getValue(); }
		
		public function setY(value:String):void { yPI.setValue(value); }
		public function getY():String { return yPI.getValue(); }
		
		public function setWidth(value:String):void { widthPI.setValue(value); }
		public function getWidth():String { return widthPI.getValue(); }
		
		public function setHeight(value:String):void { heightPI.setValue(value); }
		public function getHeight():String { return heightPI.getValue(); }
		
		public function setDefaultFill(value:String):void { defaultFill.setFill(value); }
		public function getDefaultFill():String { return defaultFill.getFill(); }
		
		public function setOverFill(value:String):void { overFill.setFill(value); }
		public function getOverFill():String { return overFill.getFill(); }
		
		public function setDownFill(value:String):void { downFill.setFill(value); }
		public function getDownFill():String { return downFill.getFill(); }
		
		public function setDisabledFill(value:String):void { disabledFill.setFill(value); }
		public function getDisabledFill():String { return disabledFill.getFill(); }
		
		public function setFaceFill(value:String):void { faceFill.setFill(value); }
		public function getFaceFill():String { return faceFill.getFill(); }
		
		private var xPI:PIPairShort;
		private var yPI:PIPairShort;
		
		private var widthPI:PIPairShort;
		private var heightPI:PIPairShort;
		
		private var defaultFill:PIFill;
		private var overFill:PIFill;
		private var downFill:PIFill;
		private var disabledFill:PIFill;
		private var faceFill:PIFill;
		
		public var labelPI:PIBaseText;
		
		public function PIButton(needWH:Boolean=false, needXY:Boolean=false, needLabel:Boolean=false, noteContent:String=null, hasMargin:Boolean=false)
		{
			this.needWH = needWH;
			this.needXY = needXY;
			this.needLabel = needLabel;
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 460;
			mainH = 200;
			noteH = 30;
			if(this.needWH) { mainH += 30; }
			if(this.needXY) { mainH += 30; }
			if(this.needLabel) { mainH += 320; }
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			if(this.needXY)
			{
				xPI = new PIPairShort("x:", "0");
				addAndPut(xPI, false);
				
				yPI = new PIPairShort("y:", "0")
				addAndPut(yPI, true);
			}
			
			if(this.needWH)
			{
				widthPI = new PIPairShort("width:", "10");
				addAndPut(widthPI, false);
				
				heightPI = new PIPairShort("height:", "10");
				addAndPut(heightPI, true);
			}
			
			defaultFill = new PIFill("defaultFiller:");
			addAndPut(defaultFill, true);
			
			overFill = new PIFill("overFill:");
			addAndPut(overFill, true);
			
			downFill = new PIFill("downFill:");
			addAndPut(downFill, true);
			
			disabledFill = new PIFill("disabledFill:");
			addAndPut(disabledFill, true);
			
			faceFill = new PIFill("faceFill:");
			addAndPut(faceFill, true);
			
			if(needLabel)
			{
				labelPI = new PIBaseText("button.label");
				labelPI.hide("align", "valign", "autoWrap", "restrict", "maxChars", "password");
				labelPI.move(0, posY);
				addToMain(labelPI);
				posY += labelPI.paneH();
			}
		}
		
		public function hide(...args):void
		{
			if(args == null) { return; }
			for(var i:int = 0; i < args.length; i++)
			{
				var key:String = args[i];
				switch(key)
				{
					case "x": xPI.lock(); break;
					case "y": yPI.lock(); break;
					case "width": widthPI.lock(); break;
					case "height": heightPI.lock(); break;
				}
			}
		}
		
	}
}