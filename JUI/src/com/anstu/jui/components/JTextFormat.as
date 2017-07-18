package com.anstu.jui.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class JTextFormat extends TextFormat
	{
		/** 关联的TextField */
		public var relateTf:TextField = null;
		
		public function JTextFormat(font:String=null, size:Object=null, color:Object=null, bold:Object=null, italic:Object=null, underline:Object=null, url:String=null, target:String=null, align:String=null, leftMargin:Object=null, rightMargin:Object=null, indent:Object=null, leading:Object=null)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
		
		private function relateTfHandler():void
		{
			if(relateTf != null)
			{ 
				relateTf.defaultTextFormat = this;
				relateTf.setTextFormat(this); 
			}
		}
		
		override public function set align(value:String):void
		{
			super.align = value;
			relateTfHandler();
		}
		
		override public function set blockIndent(value:Object):void
		{
			super.blockIndent = value;
			relateTfHandler();
		}
		
		override public function set bold(value:Object):void
		{
			super.bold = value;
			relateTfHandler();
		}
		
		override public function set bullet(value:Object):void
		{
			super.bullet = value;
			relateTfHandler();
		}
		
		override public function set color(value:Object):void
		{
			super.color = value;
			relateTfHandler();
		}
		
		override public function set display(value:String):void
		{
			super.display = value;
			relateTfHandler();
		}
		
		override public function set font(value:String):void
		{
			super.font = value;
			relateTfHandler();
		}
		
		override public function set indent(value:Object):void
		{
			super.indent = value;
			relateTfHandler();
		}
		
		override public function set italic(value:Object):void
		{
			super.italic = value;
			relateTfHandler();
		}
		
		override public function set kerning(value:Object):void
		{
			super.kerning = value;
			relateTfHandler();
		}
		
		override public function set leading(value:Object):void
		{
			super.leading = value;
			relateTfHandler();
		}
		
		override public function set leftMargin(value:Object):void
		{
			super.leftMargin = value;
			relateTfHandler();
		}
		
		override public function set letterSpacing(value:Object):void
		{
			super.letterSpacing = value;
			relateTfHandler();
		}
		
		override public function set rightMargin(value:Object):void
		{
			super.rightMargin = value;
			relateTfHandler();
		}
		
		override public function set size(value:Object):void
		{
			super.size = value;
			relateTfHandler();
		}
		
		override public function set tabStops(value:Array):void
		{
			super.tabStops = value;
			relateTfHandler();
		}
		
		override public function set target(value:String):void
		{
			super.target = value;
			relateTfHandler();
		}
		
		override public function set underline(value:Object):void
		{
			super.underline = value;
			relateTfHandler();
		}
		
		override public function set url(value:String):void
		{
			super.url = value;
			relateTfHandler();
		}
		
	}
}