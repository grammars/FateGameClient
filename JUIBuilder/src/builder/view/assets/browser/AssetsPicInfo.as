package builder.view.assets.browser
{
	import builder.Builder;
	import builder.view.assets.AssetsNode;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.define.JuiConst;
	import com.codeazur.as3swf.utils.ObjCUtils;
	
	import flash.display.DisplayObject;
	
	public class AssetsPicInfo extends JPanel
	{
		private var node:AssetsNode;
		
		private var nameLabel:JLabel;
		
		public function AssetsPicInfo(node:AssetsNode)
		{
			super();
			this.node = node;
			handleNode();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			nameLabel = new JLabel("unknow");
			nameLabel.align = JuiConst.CENTER;
			nameLabel.textFormat.color = Builder.MILK_WHITE;
			nameLabel.textFormat.size = 18;
			nameLabel.useStroke = true;
			nameLabel.setSize(600, 25);
			this.addChild(nameLabel);
			
			CCG(ColorGrid.WHITE);
			CCG(ColorGrid.GREY);
			CCG(ColorGrid.BLACK);
			for(var i:int = 0; i < 50; i++)
			{
				CCG();
			}
		}
		
		/** 添加一个ColorGrid */
		private function CCG(pColor:Object=null):void
		{
			var color:uint = pColor == null ? RColor : uint(pColor);
			var cg:ColorGrid = new ColorGrid(color, this);
			cg.addTo(this, CGPX, cgY);
		}
		
		private const CGPX:int = 10;
		private const CGPY:int = 10;
		private const CGGY:int = 30;
		private var cgI:int = 0;
		
		private function get cgY():int
		{
			var py:int = CGPY+CGGY*cgI;
			cgI++;
			return py;
		}
		
		private function get RColor():uint
		{
			return Math.random() * 0xffffff;
		}
		
		override protected function init():void
		{
			super.init();
			this.bgColor = ColorGrid.GREY;
			this.setSize(2000, 1600);
		}
		
		private function handleNode():void
		{
			nameLabel.text = node.name;
			var pic:DisplayObject = node.createPic();
			pic.x = 50;
			pic.y = 30;
			this.addChild(pic);
		}
		
		public function changeBgColor(color:uint):void
		{
			this.bgColor = color;
		}
		
	}
}

import builder.view.assets.browser.AssetsPicInfo;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;

class ColorGrid extends Sprite
{
	public static const WHITE:uint = 0xffffff;
	public static const BLACK:uint = 0x000000;
	public static const RED:uint = 0xff0000;
	public static const GREEN:uint = 0x00ff00;
	public static const BLUE:uint = 0x0000ff;
	public static const YELLOW:uint = 0xffff00;
	public static const GREY:uint = 0x888888;
	
	private var color:uint;
	private var pane:AssetsPicInfo;
	
	public function ColorGrid(color:uint, pane:AssetsPicInfo)
	{
		this.color = color;
		this.pane = pane;
		
		this.graphics.lineStyle(2, 0x2b2b2b);
		this.graphics.beginFill(color, 1);
		this.graphics.drawRoundRect(0, 0, 25, 25, 5, 5);
		this.graphics.endFill();
		
		this.buttonMode = true;
		this.addEventListener(MouseEvent.CLICK, __mouseClick);
	}
	
	private function __mouseClick(e:MouseEvent):void
	{
		this.pane.changeBgColor(color);
	}
	
	public function addTo(pa:DisplayObjectContainer, px:int, py:int):void
	{
		this.x = px;
		this.y = py;
		pa.addChild(this);
	}
	
}
