package ui.view.login
{
	import central.Centre;
	import central.Game;
	
	import comm.L;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import net.msg.login.PlayerListPack;
	
	import ui.TmpPane;
	import ui.ctrls.Ape;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.StrokeLabel;
	
	public class SelectRolePane extends TmpPane
	{
		private var alertLabel:StrokeLabel;
		private var createRoleBtn:ButtonBase;
		
		private var blocks:Vector.<RoleBlock> = new Vector.<RoleBlock>();
		
		public function SelectRolePane()
		{
			super();
			
			canvas = new Ape(800, 400);
			canvas.uiBgBitmap = new BitmapData(2, 2, true, 0x77dedede);
			canvas.drawRect();
			this.addChild(canvas);
			
			alertLabel = createLabel(L.T("选择角色"), 180, 0, 400);
			createRoleBtn = createBtn(L.T("新建"), 240, 320, __createRoleBtn, 300);
		}
		
		private function __createRoleBtn(e:MouseEvent):void
		{
			Game.login.showCreatePane();
		}
		
		public function addRoles(pList:PlayerListPack):void
		{
			//清理画面
			for(i = 0; i < blocks.length; i++)
			{
				if(blocks[i].parent) { blocks[i].parent.removeChild(blocks[i]); }
			}
			//
			for(var i:int = 0; i < pList.list.length; i++)
			{
				var block:RoleBlock = new RoleBlock(pList.list[i]);
				block.x = i * 250 + 50;
				block.y = 50;
				canvas.addChild(block);
				blocks.push(block);
			}
		}
		
		public function alert(str:String):void
		{
			alertLabel.uiLabel = "" + str;
		}
		
	}
}



import central.Centre;
import central.Game;

import cfg.VocCfg;

import comm.L;
import comm.define.SexType;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.msg.login.LoginMsg;
import net.msg.login.PlayerPreviewVO;

import ui.TmpPane;
import ui.ctrls.Ape;
import ui.ctrls.ButtonBase;
import ui.ctrls.Label;


class RoleBlock extends TmpPane
{
	private var infoLabel:Label;
	private var selectBtn:ButtonBase;
	private var deleteBtn:ButtonBase;
	
	private var pvo:PlayerPreviewVO;
	
	public function RoleBlock(pvo:PlayerPreviewVO)
	{
		super();
		
		this.pvo = pvo;
		
		canvas = new Ape(200, 260);
		canvas.uiBgBitmap = new BitmapData(2, 2, true, 0x77123523);
		canvas.drawRect();
		this.addChild(canvas);
		
		var infoStr:String = "";
		infoStr += "uid:" + pvo.uid + "\r";
		infoStr += "name:" + pvo.name + "\r";
		infoStr += "sex:" + SexType.Str(pvo.sex) + "\r";
		infoStr += "voc:" + VocCfg.getVocName(pvo.voc) + "\r";
		infoStr += "level:" + pvo.level + "\r";
		infoStr += "map:" + pvo.mapId + "(" + pvo.mapX + "," + pvo.mapY + ")" + "\r";
		infoStr += "lastLoginTime:" + L.Tdate(pvo.lastLoginTime.toDate()) + "\r";
		infoStr += "createTime:" + L.Tdate(pvo.createTime.toDate()) + "\r";
		infoLabel = createLabel(infoStr, 0, 0, 180, 200);
		
		selectBtn = createBtn(L.T("选择"), 0, 210, __selectBtn, 80);
		deleteBtn = createBtn(L.T("删除"), 100, 210, __deleteBtn, 80);
	}
	
	private function __selectBtn(e:MouseEvent):void
	{
		trace("选择了" + pvo.uid);
		Game.login.selectPlayer(pvo.uid);
	}
	
	private function __deleteBtn(e:MouseEvent):void
	{
		trace("删除了" + pvo.uid);
		LoginMsg.getInstance().sendPlayerDeleteReq_C2L(pvo.uid);
	}
}