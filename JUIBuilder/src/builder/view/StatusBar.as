package builder.view
{
	import builder.Builder;
	import builder.view.base.BFrame;
	
	import com.anstu.jui.controls.JLabel;
	
	public class StatusBar extends BFrame
	{
		private static var _instance:StatusBar;
		public static function get instance():StatusBar
		{
			if(_instance == null) { _instance = new StatusBar(); }
			return _instance;
		}
		
		override public function get W():int
		{
			return Builder.stage.stageWidth;
		}
		
		override public function get H():int
		{
			return 35;
		}
		
		private var infoLabel:JLabel = new JLabel("Welcome to use <font color='#91ef12'>JUIBuilder</font>. It is created by <font color='#ef9112'>Jack</font>!");
		
		public function StatusBar()
		{
			super();
			
			infoLabel.useStroke = true;
			infoLabel.useHtml = true;
			infoLabel.textFormat.color = Builder.LAKE_BLUE;
			infoLabel.setSize(W-30, H);
			infoLabel.move(15, 0);
			this.addChild(infoLabel);
		}
		
		public function show(text:String):void
		{
			infoLabel.text = text;
		}
		
	}
}