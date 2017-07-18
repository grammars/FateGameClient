package com.anstu.jui.build.ctrls.base
{

	public interface ICShell
	{
		/** 添加CShell */
		function addShell(child:CShell):void;
		/** 移除CShell */
		function removeShell(child:CShell):void;
		/** 获得CShellChildren */
		function getChildren():Vector.<CShell>;
	}
}