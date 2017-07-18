package ui.view.debug
{
	import central.Game;
	
	import comm.struct.player.StAttriSet;
	import comm.component.player.AttriSet;

	public class DebugFast
	{
		public function DebugFast()
		{
		}
		
		/** 纯前端加攻速 */
		public static function clientAddAttackSpeed():void
		{
			Game.hero.attris.changeAttackSpeedTo(3.8, StAttriSet.SRC_BASE);
			Game.scene.hero.update();
		}
		
		/** 主角立刻停止移动 */
		public static function heroMoveStopRightNow():void
		{
			Game.scene.hero.stopMove();
		}
		
	}
}