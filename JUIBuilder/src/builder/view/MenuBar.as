package builder.view
{
	import builder.Builder;
	import builder.Packer;
	import builder.view.base.BFrame;
	
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MenuBar extends BFrame
	{
		private static var _instance:MenuBar;
		public static function get instance():MenuBar
		{
			if(_instance == null) { _instance = new MenuBar(); }
			return _instance;
		}
		
		private static const BTN_W:int = 76;
		private static const BTN_H:int = 30;
		private static const BTN_GAP:int = 2;
		
		override public function get W():int
		{
			return Builder.stage.stageWidth;
		}
		
		override public function get H():int
		{
			return BTN_H + 2*MARGIN;
		}
		
		public function MenuBar()
		{
			super();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			createItemBtn("项目", __proj);
			createSeparator();
			createItemBtn("新建", __create);
			createItemBtn("打开", __open);
			createItemBtn("保存", __save);
			createItemBtn("关闭", __close);
			createSeparator();
			createItemBtn("上浮", __indexUp);
			createItemBtn("下沉", __indexDown);
			createItemBtn("删除", __delete);
			createItemBtn("编辑", __edit);
			createSeparator();
			createItemBtn("存档", __zip);
			createItemBtn("资源", __assets);
			createSeparator();
			createItemBtn("设置", __config);
			createItemBtn("帮助", __help);
		}
		
		private var btnNum:int = 0;
		private function createItemBtn(caption:String, cb:Function):JPushButton
		{
			var btn:JPushButton = new JPushButton(caption, cb);
			var skin:JPushButtonSkin = new JPushButtonSkin();
			skin.labelFormat = new JTextFormat(null, 12, Builder.LAKE_BLUE, false);
			skin.apply(btn);
			btn.setSize(BTN_W, BTN_H);
			btn.move(nextX(), MARGIN);
			this.addChild(btn);
			btnNum++;
			return btn;
		}
		
		private var separatorNum:int = 0;
		private function createSeparator():void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Builder.LAKE_BLUE, 1);
			shape.graphics.drawRoundRect(0,0,BTN_GAP,BTN_H,2);
			shape.graphics.endFill();
			shape.x = nextX();
			shape.y = MARGIN;
			this.addChild(shape);
			separatorNum++;
		}
		
		private function nextX():int { return MARGIN+(BTN_W+BTN_GAP)*btnNum + BTN_GAP*2*separatorNum; }
		
		private function __proj(e:MouseEvent):void
		{
			//项目操作
			ProjPop.instance.show();
		}
		
		private function __create(e:MouseEvent):void
		{
			//新建
			StatusBar.instance.show("新建一个文档");
			CreatePop.instance.show();
		}
		
		private function __open(e:MouseEvent):void
		{
			//打开
			StatusBar.instance.show("打开一个文档");
			OpenPop.instance.show();
		}
		
		private function __save(e:MouseEvent):void
		{
			//保存
			Builder.saveDoc();
		}
		
		private function __close(e:MouseEvent):void
		{
			//关闭
			Builder.closeDoc();
		}
		
		private function __indexUp(e:MouseEvent):void
		{
			//上浮
			var shell:CShell = Builder.getTarget();
			if(shell && shell.parent && shell.shellParent)
			{
				var curIndex:int = shell.parent.getChildIndex(shell);
				var chNum:int = shell.parent.numChildren;
				if(curIndex < chNum-1)
				{
					shell.parent.setChildIndex(shell, curIndex+1);
				}
				
				var chs:Vector.<CShell> = shell.shellParent.getChildren();
				for(var i:int = 0; i < chs.length; i++)
				{
					if( (chs[i] == shell) && (i+1 < chs.length) )
					{
						chs.splice(i, 1);
						chs.splice(i+1, 0, shell);
						break;
					}
				}
			}
		}
		
		private function __indexDown(e:MouseEvent):void
		{
			//下沉
			var shell:CShell = Builder.getTarget();
			if(shell && shell.parent && shell.shellParent)
			{
				var curIndex:int = shell.parent.getChildIndex(shell);
				var chNum:int = shell.parent.numChildren;
				if(curIndex > 0)
				{
					shell.parent.setChildIndex(shell, curIndex-1);
				}
				
				var chs:Vector.<CShell> = shell.shellParent.getChildren();
				for(var i:int = 0; i < chs.length; i++)
				{
					if( (chs[i] == shell) && (i-1 >= 0) )
					{
						chs.splice(i, 1);
						chs.splice(i-1, 0, shell);
						break;
					}
				}
			}
		}
		
		private function __delete(e:MouseEvent):void
		{
			//删除
			if(Builder.getTarget())
			{
				Builder.getTarget().removeSelf();
				Builder.setTarget(null);
			}
		}
		
		private function __edit(e:MouseEvent):void
		{
			//编辑控件属性
			PropBox.instance.show();
		}
		
		private function __zip(e:MouseEvent):void
		{
			//存档
			var btn:JPushButton = e.target as JPushButton;
			btn.enabled = false;
			Packer.zip();
			btn.enabled = true;
		}
		
		private function __assets(e:MouseEvent):void
		{
			//ui资源
			AssetsPop.instance.show();
		}
		
		private function __config(e:MouseEvent):void
		{
			//设置
			ConfigPop.instance.show();
		}
		
		private function __help(e:MouseEvent):void
		{
			//帮助
			Alert.instance.warn("帮助你妹啊，自己想办法解决？什么？你想不出办法？给我滚！！！犊子", "乐于助人小帮手");
			//Alert.instance.warn("非洲难民特供活动现在已开启，是否立即进入？\r就算你立即进入也来不及了，我就是告诉你一下而已\r口可口可，你来打我啊");
		}
		
	}
}