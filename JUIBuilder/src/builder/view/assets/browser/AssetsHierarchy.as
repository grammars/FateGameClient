package builder.view.assets.browser
{
	import builder.view.assets.AssetsNode;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class AssetsHierarchy extends Sprite
	{
		private static const MAX_WIDTH:int = 666;
		
		private var items:Array = [];
		
		public function AssetsHierarchy()
		{
			super();
		}
		
		public function freshAddr(node:AssetsNode):void
		{
			var i:int = 0;
			for(i = 0; i < items.length; i++)
			{
				var item:DisplayObject = items[i];
				if(item && item.parent) { item.parent.removeChild(item); }
			}
			items.length = 0;
			//
			var parent:AssetsNode = node;
			var ofx:int = 0;
			while(parent)
			{
				if(!parent.parent) { break; }
				var hi:HierarchyItem = new HierarchyItem(parent);
				items.push(hi);
				ofx += hi.width;
				this.addChild(hi);
				parent = parent.parent;
				if(ofx >= MAX_WIDTH)
				{
					break;
				}
			}
			ofx = 0;
			for(i = items.length-1; i >= 0; i--)
			{
				var pHi:HierarchyItem = items[i];
				pHi.x = ofx;
				ofx += pHi.width;
			}
		}
		
	}
}


import builder.view.assets.AssetsNode;
import builder.view.assets.browser.AssetsBrowser;
import builder.view.base.CrystalBtn;

import flash.events.MouseEvent;

class HierarchyItem extends CrystalBtn
{
	private var node:AssetsNode;
	
	public function HierarchyItem(node:AssetsNode)
	{
		this.node = node;
		super(node.name, mouse_click, 100, 25);
		this.label.draw();
		this.width = this.label.textField.textWidth + 16;
	}
	
	private function mouse_click(e:MouseEvent):void
	{
		AssetsBrowser.instance.browse(node);
	}
	
}