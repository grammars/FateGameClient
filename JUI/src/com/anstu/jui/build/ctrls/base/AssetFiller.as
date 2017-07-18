package com.anstu.jui.build.ctrls.base
{
	import com.anstu.jui.assets.JResource;

	public class AssetFiller implements IAssetFiller
	{
		public function AssetFiller()
		{
		}
		
		public function fill(fillMethod:Function, cls:String, ns:String, fillOpt:String=null):void
		{
			if(cls == null) { return; }
			JResource.fill(fillMethod, cls, ns, fillOpt);
		}
	}
}