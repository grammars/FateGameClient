package run.cd
{
	import central.Game;
	
	import comm.struct.cd.StCDInfo;
	import comm.struct.cd.StCDUint;
	
	import run.AbstractRunHandler;
	
	[Event(name="CDEvent.UPDATE", type="run.cd.CDEvent")]
	public class CDRun extends AbstractRunHandler
	{
		public function CDRun()
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
		
		public function initCD(data:StCDUint):void
		{
			Game.hero.cd.importData(data);
			var i:int = 0;
			var infos:Array = null;
			var inf:StCDInfo = null;
			
			infos = Game.hero.cd.goods.values();
			for(i = 0; i < infos.length; i++)
			{
				inf = infos[i];
				CDEvent.dispatchUpdate(inf);
			}
			
			infos = Game.hero.cd.skill.values();
			for(i = 0; i < infos.length; i++)
			{
				inf = infos[i];
				CDEvent.dispatchUpdate(inf);
			}
		}
		
		public function addCD(info:StCDInfo):void
		{
			Game.hero.cd.setCD(info);
			CDEvent.dispatchUpdate(info);
		}
		
		public function removeCD(type:int, id:int):void
		{
			Game.hero.cd.removeCD(type, id);
		}
		
	}
}