package com.gsn.games.mygame.controllers.events {

    import com.gsn.games.mygame.models.GameVO;

    import flash.events.Event;

    /**
    * Sample of Game Event
    * */
    public class GameEvent extends Event {

        // CONSTANTS
        public static const UPDATE_MODEL:String = "UPDATE_MODEL";
        public static const GAME_MODEL_UPDATED:String = "GAME_MODEL_UPDATED";

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
