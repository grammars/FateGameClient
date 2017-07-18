package run.scene
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import cfg.MapDoorCfg;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.L;
	import comm.effects.EffectFilters;
	import comm.loading.LoadingScreen;
	import comm.vo.SceneVO;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import gamekit.FateGameKit;
	import gamekit.GameScene;
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarFacade;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.map.material.AStarNode;
	import gamekit.map.material.MapLayer;
	import gamekit.utils.IntervalCounter;
	
	import net.msg.scene.SceneMsg;
	
	import run.AbstractRunHandler;
	import run.action.GotoNpcAction;
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.HeroAvt;
	import run.scene.avatar.NpcAvt;
	import run.scene.avatar.PlayerAvt;
	import run.scene.avatar.SpriteAvt;
	import run.scene.avatar.action.FightFollow;
	import run.scene.map.MapClickEffect;
	import run.scene.map.MapDecoHandler;
	
	import test.ctrls.GameConsole;
	
	import ui.view.rebirth.RebirthPane;
	import ui.view.topTar.TopTarPane;
	
	public class SceneRun extends AbstractRunHandler
	{
		/** 主角Avatar */
		public var hero:HeroAvt = new HeroAvt();
		/** 当前场景VO */
		public var sceneVo:SceneVO = new SceneVO();
		
		private var sprites:Vector.<SpriteAvt> = new Vector.<SpriteAvt>();
		
		/** 选中的对象 */
		private var sltTar:CreatureAvt;
		/** set选中的对象 */
		public function setSltTar(value:CreatureAvt):void
		{
			if(this.sltTar && this.sltTar != value)
			{
				this.sltTar.selected = false;
			}
			
			this.sltTar = value;
			
			if(this.sltTar)
			{
				this.sltTar.selected = true;
			}
			
			View.topTarPane.showTarget(this.sltTar);
		}
		/** get选中的对象 */
		public function getSltTar():CreatureAvt { return this.sltTar; }
		
		public function SceneRun()
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
			MapFacade.getInstance().setHero(hero);
			MapDecoHandler.setup();
		}
		
		
		/** 构建场景 */
		public function buildScene():void
		{
			LoadingScreen.getInstance().setInfo(L.T("场景构建中..."));
			LoadingScreen.getInstance().show();
			
			clearScene();
				
			MapMonitor.getInstance().addEventListener(MapConfigEvent.FULL_DONE, __ConfigDone);
			MapMonitor.getInstance().addEventListener(MapEvent.CLICK, __mapLayerClick);
			
			Log.info(L.T("构建地图")+sceneVo.mapId);
			MapFacade.getInstance().changeMap(sceneVo.mapId);
			
		}
		
		/** 清理场景 */
		private function clearScene():void
		{
			clearSprites();
		}
		
		/** 地图配置被完整部署了 */
		private function __ConfigDone(e:MapConfigEvent):void
		{
			putSpritePos();
			LoadingScreen.getInstance().hide();
		}
		
		/** 地图层被点击了 */
		private function __mapLayerClick(e:MapEvent):void
		{
			if(!e.clickBlock)
			{
				MapClickEffect.newInstance(e.clickPx, e.clickPy);
			}
		}
		
		private function putSpritePos():void
		{
			for(var i:int = 0; i < sprites.length; i++)
			{
				sprites[i].syncPxyAtGxy();
			}
			GameScene.getInstance().focusTarget(hero);
		}
		
		/** 设置主角 */
		public function setupHero():void
		{
			Layer.avatar.append(hero);
			hero.addEventListener(AvatarEvent.WALK_PATH, __heroWalkPath);
			hero.addEventListener(AvatarEvent.WALK_STEP, __heroWalkStep);
			hero.addEventListener(AvatarEvent.WALK_STOP, __heroWalkStop);
			sprites.push(hero);
		}
		
		
		/** __heroWalkPath */
		private function __heroWalkPath(e:AvatarEvent):void
		{
			//trace(hero.getGridX(), hero.getGridY(), " 行走的第一个点==", e.walkPath[0] as AStarNode);
			if(e.walkPath && e.walkPath.length > 1)
			{
				SceneMsg.getInstance().sendPlayerMovePath_C2G(e.walkPath.splice(1));
			}
		}
		
		/** __heroWalkStep */
		private function __heroWalkStep(e:AvatarEvent):void
		{
			if(e.walkStep)
			{
				//Game.info.notice("步伐："+e.walkStep.ind_X+","+e.walkStep.ind_Y);
				SceneMsg.getInstance().sendPlayerMoveStep_C2G(e.walkStep.ind_X, e.walkStep.ind_Y);
			}
		}
		
		/** __heroWalkStop */
		private function __heroWalkStop(e:AvatarEvent):void
		{
			//Log.debug("主角停止点", e.avatar.getGridX(), e.avatar.getGridY());
			//GameConsole.getInstance().log("主角停止点" + e.avatar.getGridX() + "_" + e.avatar.getGridY(), true);
			SceneMsg.getInstance().sendPlayerMoveStop_C2G(e.avatar.getGridX(), e.avatar.getGridY());
		}
		
		/** 主角移动退回 */
		public function heroMoveBack(x:int, y:int):void
		{
			Game.info.notice("主角移动退回 ("+x+","+y+")");
			hero.teleport(x, y);
		}
		
		/** 添加sprite */
		public function addSprite(avt:SpriteAvt):void
		{
			Layer.avatar.append(avt);
			sprites.push(avt);
		}
		
		/** 移除sprite */
		public function removeSprite(id:int):void
		{
			if(null != getSltTar())
			{
				if(id == getSltTar().getTid())
				{
					setSltTar(null);
				}
			}
			for(var i:int = 0; i < sprites.length; i++)
			{
				var avt:SpriteAvt = sprites[i];
				if(avt.getTid() == id)
				{
					avt.remove();
					sprites.splice(i, 1);
					break;
				}
			}
		}
		
		/** 清除所有非主角sprite */
		public function clearSprites():void
		{
			for(var i:int = sprites.length-1; i >= 0; i--)
			{
				var avt:SpriteAvt = sprites[i];
				if(!avt.isHero)
				{
					avt.remove();
					sprites.splice(i, 1);
				}
			}
		}
		
		/** 移动sprite到某点 */
		public function moveSprite(id:int, gx:int, gy:int):void
		{
			//trace("移动其他精灵到("+gx+","+gy+")");
			var avt:SpriteAvt = getSprite(id);
			if(avt)
			{
				avt.to(gx, gy);
			}
		}
		
		/** 移动sprite按照指定路径 */
		public function moveSpriteByPath(id:int, path:Array):void
		{
			var avt:SpriteAvt = getSprite(id);
			if(avt)
			{
				avt.go(path, false);
			}
		}
		
		/** 停止sprite移动 */
		public function stopSprite(id:int, gx:int, gy:int):void
		{
			var avt:SpriteAvt = getSprite(id);
			if(avt)
			{
				avt.to(gx, gy);
			}
		}
		
		/** 根据tid获取sprite */
		public function getSprite(id:int):SpriteAvt
		{
			for(var i:int = 0; i < sprites.length; i++)
			{
				var avt:SpriteAvt = sprites[i];
				if(avt.getTid() == id)
				{
					return avt;
				}
			}
			return null;
		}
		
		/** 根据tid获取creature */
		public function getCreature(id:int):CreatureAvt
		{
			var avt:SpriteAvt = getSprite(id);
			if(avt && avt.isCreature) { return avt as CreatureAvt; }
			return null;
		}
		
		/** 根据tid获取player */
		public function getPlayer(id:int):PlayerAvt
		{
			var avt:SpriteAvt = getSprite(id);
			if(avt && avt.isPlayer) { return avt as PlayerAvt; }
			return null;
		}
		
		/** 根据npc配置id获取NpcAvt */
		public function getNpcByCfgId(cfgId:int):NpcAvt
		{
			for(var i:int = 0; i < sprites.length; i++)
			{
				var avt:SpriteAvt = sprites[i];
				if(avt.isNpc && avt.toNpc().npcVO.cfgId == cfgId)
				{
					return avt.toNpc();
				}
			}
			return null;
		}
		
	}
}