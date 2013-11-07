package com.gsn.games.scratchy.controllers.events {
	import flash.events.Event;
	
	public class ScratchResultEvent extends Event {
		
		public var outcome:int;
		public static const RESULT_CHOSEN:String = "RESULT_CHOSEN";
		
		public function ScratchResultEvent(type:String, outcomeId:int) {
			outcome = outcomeId;
			super(type);
		}
	}
}