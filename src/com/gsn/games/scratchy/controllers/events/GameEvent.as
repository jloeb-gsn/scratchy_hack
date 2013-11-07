package com.gsn.games.scratchy.controllers.events {

    import com.gsn.games.scratchy.models.GameVO;
    
    import flash.events.Event;

    /**
    * Sample of Game Event
    * */
    public class GameEvent extends Event {

        // CONSTANTS
        public static const UPDATE_MODEL:String = "UPDATE_MODEL";
        public static const GAME_MODEL_UPDATED:String = "GAME_MODEL_UPDATED";
		public static const TICKETS_ADDED:String = "TICKETS_ADDED";
		public static const OUT_OF_TICKETS:String = "OUT_OF_TICKETS";
		
		public static const SCRATCH_TICKET:String = "SCRATCH_TICKET";
		public static const START_GAME:String = "START_GAME";
		
		public static const GAME_STATE_WAGER:String = "GAME_STATE_WAGER";
		public static const GAME_STATE_PLAY:String = "GAME_STATE_PLAY";
		public static const GAME_STATE_RESULTS:String = "GAME_STATE_RESULTS";
		

        // Optional
        public var vo:GameVO;
        public var message:String;

        public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {

            super(type, bubbles, cancelable);

            // Default vo - optional
            vo = new GameVO();
        }

        // Make sure to include a clone override to allow redispatching events with payloads
        override public function clone():Event {
            var event:GameEvent = new GameEvent(type, bubbles, cancelable);
            event.message = this.message;
            event.vo = vo.clone();
            return event;
        }
    }
}
