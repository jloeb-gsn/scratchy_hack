package com.gsn.games.mygame.controllers.events {
	
    import flash.events.Event;

    /**
     * Event to use for analytics tracking.
     * */
    public class GameAnalyticsEvent extends Event {

		// CONSTANTS
		public static const TRACK:String="TRACK";
		public static const TRACK_DO_SOMETHING:String="TRACK_DO_SOMETHING";
		
        // PROPERTIES
        public var analyticsType:String;

        public function GameAnalyticsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        override public function clone():Event {
            var newEvent:GameAnalyticsEvent = new GameAnalyticsEvent(type, bubbles, cancelable);
			newEvent.analyticsType = this.analyticsType;
			return newEvent;
        }
    }
}
