package run.scene.avatar.vo
{
	import flash.utils.ByteArray;

	public class MonsterVO extends CreatureVO
	{
		public function MonsterVO()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
		}
	}
}