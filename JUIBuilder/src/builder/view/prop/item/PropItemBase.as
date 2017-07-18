package builder.view.prop.item
{
	import builder.Builder;
	import builder.view.prop.item.parts.PicChooser;
	import builder.view.prop.item.parts.SliderValue;
	
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JComboBoxSkin;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flashx.textLayout.formats.TextAlign;
	
	public class PropItemBase extends Sprite
	{
		/** 边距 */
		protected static const MARGIN:int = 5;
		
		/** 根容器 */
		protected var pane:JPanel = new JPanel();
	
		/** 注释 */
		protected var note:JLabel = new JLabel();
		/** 注释宽 */
		protected var noteW:int = 0;
		/** 注释高 */
		protected var noteH:int = 0;
		/** 主内容区(后续内容均添加到main中去) */
		protected var main:Sprite = new Sprite();
		/** 主内容区宽 */
		protected var mainW:int = 0;
		/** 主内容区高 */
		protected var mainH:int = 0;
		
		protected var posX:int = 0;
		protected var posY:int = 0;
		
		public function paneW():int { return pane.width; }
		public function paneH():int { return pane.height; }
		
		/** 是否使用注释 */
		private var _useNote:Boolean = false;
		/** 设置注释内容 */
		public function setNote(content:String):void
		{
			if(content == null || content.length<=0)
			{
				_useNote = false;
				if(note.parent) { note.parent.removeChild(note); }
			}
			else
			{
				_useNote = true;
				note.text = content;
				
				pane.addChild(note);
			}
			build();
		}
		
		/** 短标签width */
		protected static const SHORT_LABEL_W:int = 80;
		/** 短标签height */
		protected static const SHORT_LABEL_H:int = 26;
		/** 短输入框width */
		protected static const SHORT_INPUT_W:int = 80;
		/** 短输入框height */
		protected static const SHORT_INPUT_H:int = 26;
		
		/** 长标签width */
		protected static const LONG_LABEL_W:int = 160;
		/** 长标签height */
		protected static const LONG_LABEL_H:int = 26;
		/** 长输入框width */
		protected static const LONG_INPUT_W:int = 160;
		/** 长输入框height */
		protected static const LONG_INPUT_H:int = 26;
		
		protected var hasMargin:Boolean = true;
		
		public function PropItemBase(noteContent:String=null, hasMargin:Boolean=true)
		{
			super();
			this.hasMargin = hasMargin;
			setParam();
			addChildren();
			setNote(noteContent);
			build();
		}
		
		protected function addChildren():void
		{
			pane.bgAlpha = 0.2;
			pane.bgColor = Builder.DARK_GREY;
			this.addChild(pane);
			pane.addChild(main);
		}
		
		/** 适用于被override，子类重新设置参数  */
		protected function setParam():void
		{
			mainW = 160;
			mainH = 100;
			noteW = 160;
			noteH = 30;
		}
		
		protected function build():void
		{
			var marg:int = 0;
			if(hasMargin)
			{
				marg = MARGIN;
			}
			if(_useNote)
			{
				pane.setSize(Math.max(mainW+MARGIN*2,noteW+MARGIN*2), mainH+noteH+MARGIN*2);
				note.useStroke = true;
				note.textFormat.color = 0xca8553;
				note.textFormat.size = 14;
				note.textFormat.bold = true;
				note.setSize(noteW, noteH);
				note.x = note.y = marg;
				main.x = marg;
				main.y = marg + noteH + marg;
			}
			else
			{
				pane.setSize(mainW+marg*2, mainH+marg*2);
				main.x = main.y = marg;
			}
		}
		
		public function move(px:int, py:int):void
		{
			this.x = px;
			this.y = py;
		}
		
		protected function addAndPut(pi:PropItemBase, nextBr:Boolean):void
		{
			pi.x = posX;
			pi.y = posY;
			addToMain(pi);
			if(nextBr)
			{
				posX = 0;
				posY += pi.paneH();
			}
			else
			{
				posX += pi.paneW();
			}
		}
		
		protected function addToMain(dis:DisplayObject):void
		{
			main.addChild(dis);
		}
		
		protected function createEasyBtn(text:String, handler:Function, w:int, h:int, px:int, py:int):JPushButton
		{
			var btn:JPushButton = new JPushButton(text, handler);
			new JPushButtonSkin().apply(btn);
			btn.label.textFormat.color = Builder.LAKE_BLUE;
			btn.setSize(w,h);
			btn.move(px, py);
			addToMain(btn);
			return btn;
		}
		
		protected function createEasyLabel(text:String, w:int, h:int, px:int, py:int, align:String=JuiConst.CENTER):JLabel
		{
			var label:JLabel = new JLabel(text);
			label.textFormat.color = Builder.LAKE_BLUE;
			label.useStroke = true;
			label.frameLineThick = 2;
			label.frameLineColor = Builder.DARK_GREY;
			label.frameFillColor = Builder.LAKE_BLUE;
			label.frameLineAlpha = 0.3;
			label.useFrame = true;
			label.align = align;
			label.valign = JuiConst.MIDDLE;
			label.setSize(w, h);
			label.move(px, py);
			addToMain(label);
			return label;
		}
		
		protected function createEasyInput(text:String, w:int, h:int, px:int, py:int):JInputText
		{
			var input:JInputText = new JInputText(text);
			input.textFormat.color = Builder.LAKE_BLUE;
			input.textFormat.align = TextAlign.CENTER;
			input.useStroke = true;
			input.frameLineThick = 2;
			input.frameLineColor = Builder.DARK_GREY;
			input.frameFillColor = Builder.LAKE_BLUE;
			input.frameLineAlpha = 0.3;
			input.useFrame = true;
			input.align = JuiConst.CENTER;
			input.valign = JuiConst.MIDDLE;
			input.setSize(w, h);
			input.move(px, py);
			addToMain(input);
			return input;
		}
		
		protected function createSlider(totalWidth:int, desc:String, minimum:Number, maximum:Number, px:int, py:int):SliderValue
		{
			var slider:SliderValue = new SliderValue(totalWidth, desc, minimum, maximum);
			slider.x = px;
			slider.y = py;
			addToMain(slider);
			return slider;
		}
		
		protected function createDrop(w:int, px:int, py:int, data:Array=null):JComboBox
		{
			var drop:JComboBox = new JComboBox("", data);
			new JComboBoxSkin().apply(drop);
			drop.labelButton.label.textFormat.color = Builder.MILK_WHITE;
			drop.width = w;
			drop.move(px, py);
			addToMain(drop);
			return drop;
		}
		
		protected function createPicChooser(desc:String, px:int, py:int):PicChooser
		{
			var pc:PicChooser = new PicChooser(desc);
			pc.x = px;
			pc.y = py;
			addToMain(pc);
			return pc;
		}
		
		private var lockShape:Sprite;
		public function lock(isLock:Boolean=true):void
		{
			if(lockShape && lockShape.parent)
			{
				lockShape.parent.removeChild(lockShape);
			}
			if(isLock)
			{
				lockShape = new Sprite();
				lockShape.graphics.beginFill(0x0, 0.8);
				lockShape.graphics.drawRect(0, 0, paneW(), paneH());
				lockShape.graphics.endFill();
				this.addChild(lockShape);
			}
			this.mouseChildren = this.mouseEnabled = !isLock;
		}
		
	}
}