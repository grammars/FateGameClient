package builder.view.prop
{
	import builder.Builder;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.item.PIPosition;
	import builder.view.prop.item.PITag;
	import builder.view.prop.item.PIType;
	import builder.view.prop.item.PropItemBase;
	
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PropBase extends Sprite
	{
		protected var shell:CShell;
		
		protected var typePI:PIType;
		
		protected var tagPI:PITag;
		
		protected var positionPI:PIPosition;
		
		protected var itemsPosX:int = ITEM_GAP_X;
		protected var itemsPosY:int = ITEM_GAP_Y;
		
		protected static const ITEM_GAP_X:int = 5;
		protected static const ITEM_GAP_Y:int = 5;
		
		public function PropBase()
		{
			super();
			
			typePI = new PIType();
			addRoot(typePI, false);
			
			tagPI = new PITag();
			addRoot(tagPI, true);
			
			positionPI = new PIPosition();
			addRoot(positionPI, false);
		}
		
		protected function addRoot(pi:PropItemBase, nextBr:Boolean=true):void
		{
			pi.x = itemsPosX;
			pi.y = itemsPosY;
			this.addChild(pi);
			if(nextBr)
			{
				itemsPosX = ITEM_GAP_X;
				itemsPosY += pi.paneH() + ITEM_GAP_Y;
			}
			else
			{
				itemsPosX += pi.paneW() + ITEM_GAP_X;
			}
		}
		
		/** 应用属性 */
		public function apply():void
		{
			if(shell == null) { return; }
			shell.setTag( tagPI.getTag() );
			shell.setX( positionPI.getX() );
			shell.setY( positionPI.getY() );
			
			Builder.regShell(shell);
		}
		
		/** 展现属性 */
		public function print(shell:CShell=null):void
		{
			this.shell = shell;
			if(shell == null)
			{
				typePI.setType( "不可操作的底层画布" );
				return;
			}
			typePI.setType( shell.getType() );
			tagPI.setTag( shell.getTag() );
			positionPI.setX( shell.getX() );
			positionPI.setY( shell.getY() );
		}
		
	}
}