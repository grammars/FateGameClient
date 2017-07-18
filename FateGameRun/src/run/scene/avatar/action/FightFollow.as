package run.scene.avatar.action
{
	import central.Centre;
	import central.Game;
	
	import gamekit.avatar.events.AvatarEvent;
	
	import run.scene.avatar.CreatureAvt;

	public class FightFollow
	{
		private var prey:CreatureAvt;
		
		public function FightFollow()
		{
		}
		
		public function start(prey:CreatureAvt):void
		{
			stop();
			this.prey = prey;
			this.prey.addEventListener(AvatarEvent.WALK_STEP, __step);
			if(false == Game.fight.tryHit())
			{
				Game.scene.hero.towards(this.prey);
			}
		}
		
		private function __step(e:AvatarEvent):void
		{
			if(this.prey)
			{
				Game.fight.tryHit();
			}
		}
		
		public function stop():void
		{
			if(!prey) { return; }
			prey.removeEventListener(AvatarEvent.WALK_STEP, __step);
			prey = null;
		}
		
	}
}