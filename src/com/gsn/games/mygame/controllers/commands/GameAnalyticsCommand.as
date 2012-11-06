package com.gsn.games.mygame.controllers.commands
{
	import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
	import com.gsn.games.mygame.services.GameAnalyticsHelper;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class GameAnalyticsCommand extends Command
	{
		
		// INJECTIONS
		[Inject]
		public var gameAnalytics:GameAnalyticsHelper;
		[Inject]
		public var commandEvent:GameAnalyticsEvent;
		
		
		public function GameAnalyticsCommand()
		{
			super();
		}
		
		/**
		 * Call the public trackCustomEvent() function and pass the analyticsType in
		 * */
		override public function execute():void
		{
			gameAnalytics.trackCustomEvent(commandEvent.analyticsType);
		}
	}
}