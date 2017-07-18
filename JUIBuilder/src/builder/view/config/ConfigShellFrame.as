package builder.view.config
{
	import builder.view.UICanvas;
	import builder.view.base.CrystalLabel;
	
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.ctrls.base.ICShell;
	import com.anstu.jui.build.ctrls.base.ShellFrame;
	
	import flash.display.Sprite;
	
	public class ConfigShellFrame extends Sprite
	{
		private static var _instance:ConfigShellFrame;
		public static function get instance():ConfigShellFrame
		{
			if(_instance == null) { _instance = new ConfigShellFrame(); }
			return _instance;
		}
		
		private var frames:Vector.<ShellFrame> = new Vector.<ShellFrame>();
		
		public function ConfigShellFrame()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			var label:CrystalLabel = new CrystalLabel("线框风格:", 80, 25);
			label.x = 0;
			label.y = 0;
			this.addChild(label);
			
			frames.push(new ShellFrame("null", 0x0, 0, 0, 0x0, 0, 0, frameSelectHandler));
			frames.push(new ShellFrame("red", 0xff0000, 1, 1, 0xff3300, 2, 1, frameSelectHandler));
			frames.push(new ShellFrame("shine", 0xffff00, 3, 0.7, 0xffff00, 5, 1, frameSelectHandler));
			frames.push(new ShellFrame("digital", 0x2b2b2b, 1, 0.9, 0x111111, 2, 0.9, frameSelectHandler));
			frames.push(new ShellFrame("honor", 0x123456, 2, 0.9, 0x654321, 3, 1, frameSelectHandler));
			frames.push(new ShellFrame("orange", 0xf46d0b, 2, 0.7, 0xf06000, 4, 0.9, frameSelectHandler));
			frames.push(new ShellFrame("sea", 0x6dadf6, 2, 0.7, 0x506080, 4, 0.9, frameSelectHandler));
			frames.push(new ShellFrame("green", 0x2b8462, 2, 0.7, 0x50ca65, 4, 0.9, frameSelectHandler));
			
			const ROW_SIZE:int = 4;
			for(var i:int = 0; i < frames.length; i++)
			{
				var sf:ShellFrame = frames[i];
				sf.x = (i % ROW_SIZE) * ShellFrame.WIDTH + 5;
				sf.y = Math.floor(i / ROW_SIZE) * ShellFrame.HEIGHT + 40;
				this.addChild(sf);
			}
		}
		
		private function frameSelectHandler(frame:ShellFrame):void
		{
			CShell.setFrame(frame);
			repaintContainer(UICanvas.instance);
		}
		
		private function repaintContainer(shell:ICShell):void
		{
			for(var i:int = 0; i < shell.getChildren().length; i++)
			{
				var sh:CShell = shell.getChildren()[i];
				sh.paint();
				repaintContainer(sh);
			}
		}
		
	}
}