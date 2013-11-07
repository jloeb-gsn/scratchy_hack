package com.gsn.games.scratchy.controllers.events {
	import flash.events.Event;
	
	public class ScratchResultEvent extends Event {
		
		public var outcome:int;
		public var winningsRecieved:int;
		public var numBonusSymbols:int = 0;
		public static const RESULT_CHOSEN:String = "RESULT_CHOSEN";
		
		public function ScratchResultEvent(type:String, outcomeId:int, winnings:int, bonus:int=0) {
			outcome = outcomeId;
			winningsRecieved=winnings;
			numBonusSymbols=bonus;
			super(type);
		}
	}
}