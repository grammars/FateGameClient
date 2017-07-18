package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsListItem;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PISize;
	
	public class PropListItem extends PropBase
	{
		private static var _instance:PropListItem;
		public static function get instance():PropListItem
		{
			if(_instance == null) { _instance = new PropListItem(); }
			return _instance;
		}
		
		private var piSize:PISize;
		
		public function PropListItem()
		{
			super();
			
			piSize = new PISize();
			addRoot(piSize);
		}
		
		override public function apply():void
		{
			super.apply();
			var listItem:CsListItem = shell as CsListItem;
			listItem.setWidth( piSize.getWidth() );
			listItem.setHeight( piSize.getHeight() );
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var listItem:CsListItem = shell as CsListItem;
			piSize.setWidth( listItem.getWidth() );
			piSize.setHeight( listItem.getHeight() );
		}
		
	}
}