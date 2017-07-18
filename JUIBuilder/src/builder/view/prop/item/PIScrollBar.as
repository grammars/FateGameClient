package builder.view.prop.item
{
	import com.anstu.jui.define.JuiConst;

	public class PIScrollBar extends PropItemBase
	{
		private var orientation:String;
		private var lockFatSize:Boolean;
		
		public var fatSize:PIPair;
		public var bgFill:PIFill;
		public var handleBtn:PIButton;
		public var upBtn:PIButton;
		public var downBtn:PIButton;
		
		public function PIScrollBar(orientation:String, noteContent:String=null, hasMargin:Boolean=true, lockFatSize:Boolean=true)
		{
			this.orientation = orientation;
			this.lockFatSize = lockFatSize;
			super(noteContent, hasMargin);
			
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 460;
			mainH = 860;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			var upMark:String = "←↑";
			var downMark:String = "↓→";
			if(orientation == JuiConst.HORIZONTAL)
			{
				upMark = "←";
				downMark = "→";
			}
			else if(orientation == JuiConst.VERTICAL)
			{
				upMark = "↑";
				downMark = "↓";
			}
			
			fatSize = new PIPair(140, "fatSize");
			fatSize.lock(lockFatSize);
			addAndPut(fatSize, true);
			
			bgFill = new PIFill("bgFill");
			addAndPut(bgFill, true);
			
			handleBtn = new PIButton(false, false, false, "handle");
			addAndPut(handleBtn, true);
			
			upBtn = new PIButton(true, false, false, upMark+"button");
			addAndPut(upBtn, true);
			
			downBtn = new PIButton(true, false, false, downMark+"button");
			addAndPut(downBtn, true);
		}
	}
}