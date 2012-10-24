package com.gsn.games.mygame
{
	import com.gsn.games.core.CoreContext;
	
	import flash.display.DisplayObjectContainer;
	
	public class GameContext extends CoreContext
	{
		public function GameContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
	}
}