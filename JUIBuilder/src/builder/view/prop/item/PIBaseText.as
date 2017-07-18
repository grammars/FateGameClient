package builder.view.prop.item
{
	import com.anstu.jui.build.BU;
	import builder.Builder;
	
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JComboBoxSkin;

	public class PIBaseText extends PropItemBase
	{
		public function setText(value:String):void { textPI.setValue(value); }
		public function getText():String { return textPI.getValue(); }
		
		public function setAlign(value:String):void { alignPI.setValue(value); }
		public function getAlign():String { return alignPI.getValue(); }
		
		public function setValign(value:String):void { valignPI.setValue(value); }
		public function getValign():String { return valignPI.getValue(); }
		
		public function setAutoWrap(value:String):void { autoWrapPI.setValue(value); }
		public function getAutoWrap():String { return autoWrapPI.getValue(); }
		
		public function setRestrict(value:String):void { restrictPI.setValue(value); }
		public function getRestrict():String { return restrictPI.getValue(); }
		
		public function setMaxChars(value:String):void { maxCharsPI.setValue(value); }
		public function getMaxChars():String { return maxCharsPI.getValue(); }
		
		public function setPassword(value:String):void { passwordPI.setValue(value); }
		public function getPassword():String { return passwordPI.getValue(); }
		
		public function setUseStroke(value:String):void { useStrokePI.setValue(value); }
		public function getUseStroke():String { return useStrokePI.getValue(); }
		
		public function setStrokeColor(value:String):void { strokeColorPI.setValue(value); }
		public function getStrokeColor():String { return strokeColorPI.getValue(); }
		
		public function setStrokeBlur(value:String):void { strokeBlurPI.setValue(value); }
		public function getStrokeBlur():String { return strokeBlurPI.getValue(); }
		
		public function setStrokeStrength(value:String):void { strokeStrengthPI.setValue(value); }
		public function getStrokeStrength():String { return strokeStrengthPI.getValue(); }
		
		public function setUseHtml(value:String):void { useHtmlPI.setValue(value); }
		public function getUseHtml():String { return useHtmlPI.getValue(); }
		
		public function setFont(value:String):void { fontPI.setValue(value); }
		public function getFont():String { return fontPI.getValue(); }
		
		public function setSize(value:String):void { sizePI.setValue(value); }
		public function getSize():String { return sizePI.getValue(); }
		
		public function setColor(value:String):void { colorPI.setValue(value); }
		public function getColor():String { return colorPI.getValue(); }
		
		public function setBold(value:String):void { boldPI.setValue(value); }
		public function getBold():String { return boldPI.getValue(); }
		
		public function setItalic(value:String):void { italicPI.setValue(value); }
		public function getItalic():String { return italicPI.getValue(); }
		
		public function setUnderline(value:String):void { underlinePI.setValue(value); }
		public function getUnderline():String { return underlinePI.getValue(); }
		
		
		private var textPI:PIPair;
		private var alignPI:PIDrop;
		private var valignPI:PIDrop;
		private var autoWrapPI:PIBoolean;
		private var restrictPI:PIPair;
		private var maxCharsPI:PIPair;
		private var passwordPI:PIBoolean;
		private var useStrokePI:PIBoolean;
		private var strokeColorPI:PIPair;
		private var strokeBlurPI:PIPair;
		private var strokeStrengthPI:PIPair;
		private var useHtmlPI:PIBoolean;
		
		private var fontPI:PIFont;
		private var sizePI:PIPair;
		private var colorPI:PIPair;
		private var boldPI:PIBoolean;
		private var italicPI:PIBoolean;
		private var underlinePI:PIBoolean;
		
		public function PIBaseText(noteContent:String=null, hasMargin:Boolean=false)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = 445;
			mainH = 250;
			noteW = 445;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			textPI = new PIPair(350, "text:");
			addAndPut(textPI, true);
			
			alignPI = new PIDrop(110, "align", [JuiConst.LEFT, JuiConst.CENTER, JuiConst.RIGHT]);
			addAndPut(alignPI, false);
			
			valignPI = new PIDrop(120, "valign", [JuiConst.UP, JuiConst.MIDDLE, JuiConst.DOWN]);
			addAndPut(valignPI, false);
			
			autoWrapPI = new PIBoolean("autoWrap", false);
			addAndPut(autoWrapPI, true);
			
			restrictPI = new PIPair(160, "restrict", "null");
			addAndPut(restrictPI, false);
			
			maxCharsPI = new PIPair(100, "maxChars", "0");
			addAndPut(maxCharsPI, false);
			
			passwordPI = new PIBoolean("password", false);
			addAndPut(passwordPI, true);
			
			useStrokePI = new PIBoolean("useStroke", false);
			addAndPut(useStrokePI, false);
			
			strokeColorPI = new PIPair(140, "strokeColor");
			addAndPut(strokeColorPI, false);
			
			strokeBlurPI = new PIPair(95, "strokeBlur");
			addAndPut(strokeBlurPI, false);
			
			strokeStrengthPI = new PIPair(110, "strokeStrength");
			addAndPut(strokeStrengthPI, true);
			
			useHtmlPI = new PIBoolean("useHtml", false);
			addAndPut(useHtmlPI, false);
			
			fontPI = new PIFont();
			addAndPut(fontPI, false);
			
			sizePI = new PIPair(80, "size");
			addAndPut(sizePI, true);
			
			colorPI = new PIPair(130, "color");
			addAndPut(colorPI, false);
			
			boldPI = new PIBoolean("bold", false);
			addAndPut(boldPI, false);
			
			italicPI = new PIBoolean("italic", false);
			addAndPut(italicPI, false);
			
			underlinePI = new PIBoolean("underline", false);
			addAndPut(underlinePI, true);
		}
		
		public function hide(...args):void
		{
			if(args == null) { return; }
			for(var i:int = 0; i < args.length; i++)
			{
				var key:String = args[i];
				switch(key)
				{
				case "text": textPI.lock(); break;
				case "align": alignPI.lock(); break;
				case "valign": valignPI.lock(); break;
				case "autoWrap": autoWrapPI.lock(); break;
				case "restrict": restrictPI.lock(); break;
				case "maxChars": maxCharsPI.lock(); break;
				case "password": passwordPI.lock(); break;
				case "useStroke": useStrokePI.lock(); break;
				case "strokeColor": strokeColorPI.lock(); break;
				case "strokeBlur": strokeBlurPI.lock(); break;
				case "strokeStrength": strokeStrengthPI.lock(); break;
				case "useHtml": useHtmlPI.lock(); break;
				case "font": fontPI.lock(); break;
				case "size": sizePI.lock(); break;
				case "color": colorPI.lock(); break;
				case "bold": boldPI.lock(); break;
				case "underline": italicPI.lock(); break;
				}
			}
		}
		
	}
}