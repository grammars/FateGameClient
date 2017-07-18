package run.scene.avatar
{
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	public class PathSkillAvt extends SpriteAvt
	{
		public function PathSkillAvt(pBornTime:Object=null)
		{
			super(pBornTime);
			this.mouseEnabled = false;
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
		}
		
	}
}