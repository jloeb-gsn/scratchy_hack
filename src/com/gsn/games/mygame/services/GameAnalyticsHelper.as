package com.gsn.games.mygame.services
{
	import com.gsn.games.core.models.analytics.vo.AnalyticsVO;
	import com.gsn.games.core.services.analytics.AnalyticsHelper;
	
	/**
	 * Extension of AnalyticsHelper to provide game-specific tracking events.
	 * */
	public class GameAnalyticsHelper extends AnalyticsHelper
	{
		public function GameAnalyticsHelper()
		{
			super();
		}
		
		// Example function setting specific tracking event
		public function trackPopupCount():void {
			var category:String="game";
			var action:String="window";
			var newCount:Number=2;
			var vo:AnalyticsVO = new AnalyticsVO(category, action, "", newCount);
			generateRequest(vo);
		}
		
		// Example function using event data to switch the tracking event
		public function trackCustomEvent(eventName:String):void {
			var logName:String = "";
			
			/*
			switch(eventName){
				case SomeEvent.SOME_VALUE:
					logName = "bandit_boom;                                                                                                              
					break;                                                                                                                                  
				case SomeEvent.OTHER_VALUE:
					logName = "skipper_skip";                                                                                                             
					break;                                                                                                                                                                                                                                                                   
			}
			*/
			
			var vo:AnalyticsVO = new AnalyticsVO("custom", logName);
			generateRequest(vo);
		}
		
	}
}