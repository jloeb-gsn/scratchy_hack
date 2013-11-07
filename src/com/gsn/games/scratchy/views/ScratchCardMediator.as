package com.gsn.games.scratchy.views {
	
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.controllers.events.ScratchResultEvent;
	import com.gsn.games.scratchy.models.GameModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ScratchCardMediator extends Mediator {
		
		[Inject]
		public var model:GameModel;
		
		public function ScratchCardMediator() {
			super();
		}
		
		override public function onRegister():void {
			addViewListener(GameEvent.SCRATCH_TICKET, onScratchedTicket);
			addContextListener(ScratchResultEvent.RESULT_CHOSEN, onResults);
			addContextListener(GameEvent.TICKETS_ADDED, onAddTickets);
			addContextListener(GameEvent.GAME_MODEL_UPDATED, onModelUpdated);
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
		}
		
		protected function onAddTickets(event:GameEvent):void {
			//update view that tickets are added
		}
		
		protected function onModelUpdated(event:GameEvent):void {
			
		}
	}
}