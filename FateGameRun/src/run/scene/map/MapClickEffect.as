package run.scene.map
{
	import central.Centre;
	
	import gamekit.component.Swf;
	import gamekit.layer.Layer;
	
	public class MapClickEffect extends Swf
	{
		public function MapClickEffect()
		{
			super(Centre.RES_ROOT+"map/deco/click/click.swf", "click", 800, false, false);
		}
		
		public static function newInstance(px:int, py:int):void
		{
			var eff:MapClickEffect = new MapClickEffect();
			eff.x = px;
			eff.y = py;
			eff.addTo(Layer.map);
		}
		
	}
}