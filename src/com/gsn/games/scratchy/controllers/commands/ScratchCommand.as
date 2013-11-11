package com.gsn.games.scratchy.controllers.commands {
	import com.gsn.games.core.models.playermanager.IPlayerManager;
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.controllers.events.ScratchResultEvent;
	import com.gsn.games.scratchy.models.GameData;
	import com.gsn.games.scratchy.models.GameModel;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class ScratchCommand extends Command {
		
		[Inject]
		public var playerMgr:IPlayerManager;
		[Inject]
		public var model:GameModel;
		
		public function ScratchCommand() {
			super();
		}
		
		override public function execute():void {
			trace("ScratchCommand.execute() start!");
			//determine outcome
			var id:int = determineOutcome();
			//update model
			model.ticketsRemaining--;
			trace(">> Tickets remaining: "+model.ticketsRemaining);
			var winnings:Number = processOutcome(GameData.OUTCOMES[id]) * model.bonusLevel * model.betPerTicket;
			
			model.winningsSoFar += winnings;
			playerMgr.tokens += winnings;
			trace(">>>>>> added winnings: "+winnings);
			
			//do bonuses
			var bonuses:int = int(Math.floor(Math.random()*3));//0,1, or 2
			model.bonusPoints += bonuses;
			
			trace(">>>>>>> Added bonus points: "+bonuses);
			dispatch(new ScratchResultEvent(ScratchResultEvent.RESULT_CHOSEN, id, winnings, bonuses));
			
			if (model.ticketsRemaining <= 0){
				trace(">>>>>>>> OUT OF TICKETS");
				dispatch(new GameEvent(GameEvent.OUT_OF_TICKETS));
			}
			super.execute();
		}
		
		/** takes the 3 symbols, determines which has the most, and does the payouts */
		protected function processOutcome(icons:Array):Number {
			//ICON_Cherry, ICON_7, ICON_Cherry for example
			var dominantIcon:String = "";
			var numIcons:Dictionary = new Dictionary();
			for (var idx:int = 0; idx < icons.length; idx++){
				var curIcon:String = icons[idx];
				if (!numIcons.hasOwnProperty(curIcon)){
					numIcons[curIcon] = 0;
				}
				numIcons[curIcon]++;
				if (dominantIcon == "" || (dominantIcon != curIcon && (numIcons[curIcon] >= numIcons[dominantIcon]) )){
					dominantIcon = curIcon;
				}
			}
			trace(">>>> Outcome dominant icon: "+dominantIcon+ " for result: "+icons.join(','));
			//if tickets are present, award them
			if (numIcons.hasOwnProperty(GameData.ICON_Ticket)){
				var numTickets:int = numIcons[GameData.ICON_Ticket];
				model.ticketsRemaining += numTickets;
				model.totalTickets += numTickets;
				trace(">>>>> Tickets added: "+numTickets);
				dispatch(new GameEvent(GameEvent.TICKETS_ADDED));
			}
			//update tokens
			return Number(GameData.PAYOUTS[dominantIcon][numIcons[dominantIcon]-1]);
			
		}
		
		protected function determineOutcome():int {
			var outcomeId:int = int(Math.floor(Math.random()*GameData.OUTCOMES.length));
			trace(">>> Outcome Chosen: "+outcomeId);
			return outcomeId;
		}
	}
}