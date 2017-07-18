package builder.ctrls.base
{
	import builder.view.assets.AssetsNode;
	
	import com.anstu.jui.build.ctrls.base.IAssetFiller;
	
	public class BuilderAssetFiller implements IAssetFiller
	{
		private static var _instance:BuilderAssetFiller;
		public static function get instance():BuilderAssetFiller
		{
			if(_instance == null) { _instance = new BuilderAssetFiller(); }
			return _instance;
		}
		
		public function BuilderAssetFiller()
		{
		}
		
		public function fill(fillMethod:Function, cls:String, ns:String, fillOpt:String=null):void
		{
			if(cls == null || cls == "" || cls == "null")
			{
				fillMethod(null);
			}
			else
			{
				var node:AssetsNode = AssetsNode.getNode(cls);
				if(node)
				{
					fillMethod( node.createPic(fillOpt) );
				}
			}
		}
	}
}