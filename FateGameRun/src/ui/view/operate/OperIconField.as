package ui.view.operate
{
	import flash.display.Sprite;
	
	public class OperIconField extends Sprite
	{
		private static var _instance:OperIconField;
		public static function get instance():OperIconField
		{
			if(_instance == null) { _instance = new OperIconField(); }
			return _instance;
		}
		
		private static const W:int = 376;
		private static const H:int = 40;
		
		/** 可以容纳的最大icon数 */
		private const MAX_SIZE:int = 8;
		
		private const ICON_W:int = 48;
		private const ICON_H:int = 48;
		
		private var icons:Array = [];
		
		public function OperIconField()
		{
			super();
			if(_instance) { throw new Error("OperIconField::Singleton"); }
			init();
		}
		
		private function init():void
		{
			this.graphics.beginFill(0xff0000, 0.001);
			this.graphics.drawRect(0,0,W,H);
			this.graphics.endFill();
			
			for(var i:int = 0; i < MAX_SIZE; i++)
			{
				icons.push(null);
			}
		}
		
		/** 清空所有的OperIcon */
		public function clear():void
		{
			for(var i:int = 0; i < MAX_SIZE; i++)
			{
				var icon:OperIcon = icons[i];
				if(icon && icon.parent) { icon.parent.removeChild(icon); }
				icons[i] = null;
			}
		}
		
		/** 添加OperIcon */
		public function add(icon:OperIcon, pIndex:Object=null):void
		{
			var index:int = -1;
			if(pIndex != null)
			{
				index = int(pIndex);
			}
			else
			{
				for(var i:int = 0; i < MAX_SIZE; i++)
				{
					if(icons[i] == null)
					{
						index = i;
						break;
					}
				}
			}
			if(index < 0 || index >= MAX_SIZE)
			{
				trace("超过OperIconField的容纳上下限");
				return;
			}
			remove(index);
			
			icon.x = ICON_W * index;
			this.addChild(icon);
			icons[index] = icon;
		}
		
		/** 移除OperIcon(通过index) */
		public function remove(index:int):void
		{
			var old:OperIcon = icons[index];
			if(old && old.parent) { old.parent.removeChild(old); }
			icons[index] = null;
		}
		
		/** 移除OperIcon(通过icon) */
		public function removeIcon(icon:OperIcon):void
		{
			for(var i:int = 0; i < MAX_SIZE; i++)
			{
				if(icons[i] == icon)
				{
					remove(i);
					break;
				}
			}
		}
		
		/** 使用操作项
		 * @param index:int 序号[0,n) */
		public function useItem(index:int):void
		{
			if(index < 0 || index >= icons.length)
			{
				return;
			}
			var icon:OperIcon = icons[index];
			if(icon)
			{
				icon.apply();
			}
		}
		
	}
}