package com.gsn.games.scratchy.services {
    import com.gsn.games.core.models.analytics.vo.AnalyticsVO;
    import com.gsn.games.core.services.analytics.AnalyticsHelper;
    import com.gsn.games.scratchy.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.shared.utils.DebugUtils;

    /**
     * Extension of AnalyticsHelper to provide game-specific tracking events.
     * */
    public class GameAnalyticsHelper extends AnalyticsHelper {
        public function GameAnalyticsHelper() {
            super();
        }

        // Example function setting specific tracking event
        public function trackPopupCount():void {
            var category:String = "game";
            var action:String = "window";
            var newCount:Number = 2;
            var vo:AnalyticsVO = new AnalyticsVO(category, action, "", newCount);
            generateRequest(vo);
        }

        // Example function using event data to switch the tracking event
        public function trackCustomEvent(eventName:String):void {


            var logName:String = "";

            switch (eventName) {
                case GameAnalyticsEvent.TRACK_DO_SOMETHING:
                    logName = "do_something";
                    break;
                /*case GameAnalyticsEvent.OTHER_VALUE:
                    logName = "skipper_skip";
                    break;*/
            }

            DebugUtils.log("GameAnalyticsHelper.trackCustomEvent() logging:" + eventName + " as:" + logName, "Game");

            // Log event
            var vo:AnalyticsVO = new AnalyticsVO("custom", logName);
            generateRequest(vo);
        }

    }
}
