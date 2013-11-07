package com.gsn.games.scratchy.views {
	
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.controllers.events.ScratchResultEvent;
	import com.gsn.games.scratchy.models.GameData;
	import com.gsn.games.scratchy.models.GameModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ScratchCardMediator extends Mediator {
		
		[Inject]
		public var model:GameModel;
		[Inject]
		public var view:ScratchCardView;
		
		public function ScratchCardMediator() {
			super();
		}
		
		override public function onRegister():void {
			addViewListener(GameEvent.SCRATCH_TICKET, onScratchedTicket);
			addContextListener(ScratchResultEvent.RESULT_CHOSEN, onResults);
			addContextListener(GameEvent.TICKETS_ADDED, onAddTickets);
			super.onRegister();
		}
		
		override public function onRemove():void {
			super.onRemove();
		}
		
		protected function onScratchedTicket(e:GameEvent):void {
			trace("Mediator handles the scratch!");
			dispatch(e);
		}
		
		protected function onResults(event:ScratchResultEvent):void {
			//show the scratch results
			trace("--> ScratchcardMediator onResults: [won "+event.winningsRecieved+"][bonus stickers "+event.numBonusSymbols+"]");
			var icons:Array = GameData.OUTCOMES[event.outcome];
			view.showScratchResult(icons, event.winningsRecieved, event.numBonusSymbols);
		}
		
		protected function onAddTickets(event:GameEvent):void {
			//update view that tickets are added
			trace("--> ScratchcardMediator onAddTickets");
		}
	}
}