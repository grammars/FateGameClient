package net.msg.scene
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	
	import gamekit.map.material.AStarNode;
	
	import net.SidType;
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	import run.scene.AvatarFactory;
	import run.scene.avatar.SpriteAvt;
	import run.scene.avatar.vo.PlayerVO;
	import run.scene.avatar.vo.SpriteVO;
	
	import test.ctrls.GameConsole;
	
	public class SceneMsg extends IMessage
	{
		private static var instance:SceneMsg;
		public static function getInstance():SceneMsg
		{
			if(instance == null) { instance = new SceneMsg(); }
			return instance;
		}
		
		/** [场景]主消息号 */
		public static const MID:int = SCENE_MID;
		
		/** client向game请求场景信息 */
		private static const SCENE_INFO_REQ_C2G:int = 1;
		/** game向client发送场景信息 */
		private static const SCENE_INFO_RPL_G2C:int = 2;
		/** game向client发送添加sprite */
		private static const SCENE_ADD_SPRITE_G2C:int = 3;
		/** game向client发送移除sprite */
		private static const SCENE_REMOVE_SPRITE_G2C:int = 4;
		/** game向client发送添加多个sprite */
		private static const SCENE_ADD_SPRITES_G2C:int = 5;
		/** game向client发送移除多个sprite */
		private static const SCENE_REMOVE_SPRITES_G2C:int = 6;
		/** client向game发送移动路径 */
		private static const PLAYER_MOVE_PATH_C2G:int = 7;
		/** client向game发送移动单步 */
		private static const PLAYER_MOVE_STEP_C2G:int = 8;
		/** client向game发送移动止步 */
		private static const PLAYER_MOVE_STOP_C2G:int = 12;
		/** game向client发送Sprite移动路径 */
		private static const SPRITE_MOVE_PATH_G2C:int = 9;
		/** game向client发送Sprite移动到指定点 */
		private static const SPRITE_MOVE_TO_POINT_G2C:int = 19;
		/** game向client发送玩家移动退回 */
		private static const PLAYER_MOVE_BACK_G2C:int = 10;
		/** game向client发送Sprite移动止步 */
		private static const SPRITE_MOVE_STOP_G2C:int = 13;
		/** game向client发送玩家场景切换 */
		private static const SCENE_CHANGE_MAP_G2C:int = 11;
		/** game向client发送Sprite的selfLook改变 */
		private static const SELF_LOOK_CHANGE_G2C:int = 20;
		/** game向client发送Sprite的weaponLook改变 */
		private static const WEAPON_LOOK_CHANGE_G2C:int = 21;
		
		public function SceneMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case SCENE_INFO_RPL_G2C:
				recvSceneInfoRpl_G2C(data);
				break;
			case SCENE_ADD_SPRITE_G2C:
				recvSceneAddSprite_G2C(data);
				break;
			case SCENE_REMOVE_SPRITE_G2C:
				recvSceneRemoveSprite_G2C(data);
				break;
			case SCENE_ADD_SPRITES_G2C:
				recvSceneAddSprites_G2C(data);
				break;
			case SCENE_REMOVE_SPRITES_G2C:
				recvSceneRemoveSprites_G2C(data);
				break;
			case SPRITE_MOVE_PATH_G2C:
				recvSpriteMovePath_G2C(data);
				break;
			case SPRITE_MOVE_TO_POINT_G2C:
				recvSpriteMoveToPoint_G2C(data);
				break;
			case PLAYER_MOVE_BACK_G2C:
				recvPlayerMoveBack_G2C(data);
				break;
			case SPRITE_MOVE_STOP_G2C:
				recvSpriteMoveStop_G2C(data);
				break;
			case SCENE_CHANGE_MAP_G2C:
				recvSceneChangeMap_G2C(data);
				break;
			case SELF_LOOK_CHANGE_G2C:
				recvSelfLookChange_G2C(data);
				break;
			case WEAPON_LOOK_CHANGE_G2C:
				recvWeaponLookChange_G2C(data);
				break;
			}
		}
		
		/** send( client向game请求场景信息 ) */
		public function sendSceneInfoReq_C2G():void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, SCENE_INFO_REQ_C2G);
			mb.send();
		}
		/** recv( game向client发送场景信息 ) */
		private function recvSceneInfoRpl_G2C(bytes:ByteArray):void
		{
			var hvo:PlayerVO = new PlayerVO();
			hvo.read(bytes);
			Game.scene.hero.setVO(hvo);
			Game.scene.hero.update();
			Game.scene.sceneVo.readInfo(bytes);
			Log.info("game向client发送场景信息 heroTid=", Game.scene.hero.getTid(), Game.scene.hero.creatureVO.alive, Game.scene.sceneVo);
			Game.scene.setupHero();
			Game.scene.buildScene();
		}
		
		private function handleSpriteCreate(bytes:ByteArray):void
		{
			var vo:SpriteVO = SceneMsgUtils.readSpriteVO(bytes);
			var avt:SpriteAvt = AvatarFactory.create(vo);
			Log.debug("game向client发送添加sprite" + avt);
			Game.scene.addSprite(avt);
		}
		
		/** recv( game向client发送添加sprite ) */
		private function recvSceneAddSprite_G2C(data:ByteArray):void
		{
			handleSpriteCreate(data);
		}
		
		/** recv( game向client发送移除sprite ) */
		private function recvSceneRemoveSprite_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			Log.debug("game向client发送移除spriteId=" + spriteId);
			Game.scene.removeSprite(spriteId);
		}
		
		/** recv( game向client发送添加多个sprite ) */
		private function recvSceneAddSprites_G2C(data:ByteArray):void
		{
			Log.debug("game向client发送添加多个sprite");
			var size:int = EndianFacade.readInt(data);
			for(var i:int = 0; i < size; i++)
			{
				handleSpriteCreate(data);
			}
		}
		
		/** recv( game向client发送移除多个sprite ) */
		private function recvSceneRemoveSprites_G2C(data:ByteArray):void
		{
			Log.debug("game向client发送移除多个sprite");
			var size:int = EndianFacade.readInt(data);
			for(var i:int = 0; i < size; i++)
			{
				var spriteId:int = EndianFacade.readInt(data);
				Log.debug("spriteId["+i+"]=" + spriteId);
				Game.scene.removeSprite(spriteId);
			}
		}
		
		/** send( client向game发送移动路径 ) */
		public function sendPlayerMovePath_C2G(path:Array):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_MOVE_PATH_C2G);
			EndianFacade.writeInt(mb.bytes, path.length);
			for(var i:int = 0; i < path.length; i++)
			{
				var node:AStarNode = path[i];
				EndianFacade.writeInt(mb.bytes, node.ind_X);
				EndianFacade.writeInt(mb.bytes, node.ind_Y);
			}
			mb.send();
		}
		
		/** send( client向game发送移动单步 ) */
		public function sendPlayerMoveStep_C2G(x:int, y:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_MOVE_STEP_C2G);
			EndianFacade.writeInt(mb.bytes, x);
			EndianFacade.writeInt(mb.bytes, y);
			mb.send();
		}
		
		/** send( client向game发送止步 ) */
		public function sendPlayerMoveStop_C2G(x:int, y:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_MOVE_STOP_C2G);
			EndianFacade.writeInt(mb.bytes, x);
			EndianFacade.writeInt(mb.bytes, y);
			mb.send();
		}
		
		/** recv( game向client发送Sprite移动路径 ) */
		private function recvSpriteMovePath_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			Log.debug("game向client发送Sprite移动路径spriteId=" + spriteId);
				
			var len:int = EndianFacade.readInt(data);
			if(len <= 0) { return; }
			var path:Array = [];
			for(var i:int = 0; i < len; i++)
			{
				var gx:int = EndianFacade.readInt(data);
				var gy:int = EndianFacade.readInt(data);
				var node:AStarNode = new AStarNode(gx, gy);
				path.push(node);
			}
			Game.scene.moveSpriteByPath(spriteId, path);
		}
		
		/** recv( game向client发送Sprite移动到指定点 ) */
		private function recvSpriteMoveToPoint_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			Log.debug("game向client发送Sprite移动到指定点 spriteId=" + spriteId);
			
			var gx:int = EndianFacade.readInt(data);
			var gy:int = EndianFacade.readInt(data);
			Game.scene.moveSprite(spriteId, gx, gy);
		}
		
		/** recv( game向client发送玩家移动退回 ) */
		private function recvPlayerMoveBack_G2C(data:ByteArray):void
		{
			var gx:int = EndianFacade.readInt(data);
			var gy:int = EndianFacade.readInt(data);
			Log.debug("game向client发送玩家移动退回(" + gx + "," + gy + ")");
			Game.scene.heroMoveBack(gx, gy);
		}
		
		/** recv( game向client发送Sprite移动止步 ) */
		private function recvSpriteMoveStop_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var gx:int = EndianFacade.readInt(data);
			var gy:int = EndianFacade.readInt(data);
			Game.scene.stopSprite(spriteId, gx, gy);
		}
		
		/** recv( game向client发送玩家场景切换 ) */
		private function recvSceneChangeMap_G2C(data:ByteArray):void
		{
			Log.info("game向client发送玩家场景切换");
			Game.info.notice("场景切换");
			var toX:int = EndianFacade.readInt(data);
			var toY:int = EndianFacade.readInt(data);
			
			Game.scene.hero.teleport(toX, toY);
			Game.scene.sceneVo.readInfo(data);
			Game.scene.buildScene();
			
		}
		
		/** recv( game向client发送Sprite的selfLook改变 ) */
		private function recvSelfLookChange_G2C(data:ByteArray):void
		{
			var changerTid:int = EndianFacade.readInt(data);
			var lookId:String = EndianFacade.readMultiByte(data);
			trace("selfLook改变 changerTid=" + changerTid + " lookId=" + lookId);
			var changer:SpriteAvt = Game.scene.getSprite(changerTid);
			if(changer)
			{
				changer.changeSelfLook(lookId);
			}
		}
		
		/** recv( game向client发送Sprite的weaponLook改变 ) */
		private function recvWeaponLookChange_G2C(data:ByteArray):void
		{
			var changerTid:int = EndianFacade.readInt(data);
			var lookId:String = EndianFacade.readMultiByte(data);
			trace("weaponLook改变 changerTid=" + changerTid + " lookId=" + lookId);
			var changer:SpriteAvt = Game.scene.getSprite(changerTid);
			if(changer)
			{
				changer.changeWeaponLook(lookId);
			}
		}
		
	}
}