package run.buff
{
	import central.Game;
	import central.View;
	
	import comm.component.buff.Buff;
	import comm.struct.buff.StBuff;
	
	import run.AbstractRunHandler;
	import run.scene.avatar.CreatureAvt;
	
	import ui.view.heroCorner.HeroCornerPane;
	import ui.view.topTar.TopTarPane;
	
	public class BuffRun extends AbstractRunHandler
	{
		public function BuffRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
		}
		
		/** 收到来自服务器端的buff添加的消息 */
		public function buffAdded(data:StBuff):void
		{
			var buff:Buff = new Buff();
			buff.importData(data);
			var target:CreatureAvt = Game.scene.getCreature( buff.targetTid );
			if(target)
			{
				target.creatureVO.buffs.addBuff(buff);
				Game.info.notice(""+target.creatureVO.name+"添加buff"+buff.id);
				if(Game.isHeroByTid(target.getTid()))
				{
					View.heroCornerPane.addBuff(buff);
				}
				else
				{
					if(View.topTarPane.getTarget() == target)
					{
						View.topTarPane.addBuff(buff);
					}
				}
			}
		}
		
		/** 收到来自服务器端的buff移除的消息 */
		public function buffRemoved(data:StBuff):void
		{
			var target:CreatureAvt = Game.scene.getCreature( data.targetTid );
			if(target)
			{
				target.creatureVO.buffs.remove(data.id);
				Game.info.notice(""+target.creatureVO.name+"移除buff"+data.id);
				if(Game.isHeroByTid(target.getTid()))
				{
					View.heroCornerPane.removeBuff(data.id);
				}
				else
				{
					if(View.topTarPane.getTarget() == target)
					{
						View.topTarPane.removeBuff(data.id);
					}
				}
			}
		}
	}
}