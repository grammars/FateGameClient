package comm.component.goods.info
{
	import comm.component.goods.GoodsInfo;
	
	import flash.utils.ByteArray;
	
	public class GiftGI extends GoodsInfo
	{
		override public function available():Boolean
		{
			if(super.available() == false) { return false; }
			return true;
		}
		
		public function GiftGI()
		{
			super();
		}
		
		override protected function build():void
		{
			super.build();
		}
		
		override protected function readHandler(bytes:ByteArray):void
		{
			
		}
		
		override protected function copyHandler(source:GoodsInfo):void
		{
			
		}
		
	}
}