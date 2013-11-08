package com.gsn.games.scratchy.controllers.commands
{
	import com.gsn.games.core.controllers.events.AdjustTokensEvent;
	import com.gsn.games.core.controllers.events.PlayerManagerEvent;
	import com.gsn.games.core.models.common.datarequests.vo.AdjustTokensVO;
	import com.gsn.games.core.models.playermanager.IPlayerManager;
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.models.GameModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlaceBetCommand extends Command
	{
		[Inject]
		public var model:GameModel;
		[Inject]
		public var playerManager:IPlayerManager;
		
		override public function execute():void {
			var totalBet:int = model.totalTickets * GameModel.BET_AMOUNTS[model.betIndex];
			
			eventDispatcher.addEventListener(PlayerManagerEvent.BET_PLACED_COMPLETE, onBetPlaceComplete);
			eventDispatcher.addEventListener(PlayerManagerEvent.BET_PLACED_ERROR, onBetPlaceError);
			
			var placeBetEvent:AdjustTokensEvent = new AdjustTokensEvent(AdjustTokensEvent.PLACE_BET);
			var placeBetVO:AdjustTokensVO = new AdjustTokensVO(totalBet);
			placeBetEvent.vo = placeBetVO;
			dispatch(placeBetEvent);
			
			commandMap.detain(this);
		}
		
		private function onBetPlaceComplete(e:PlayerManagerEvent) : void {
			eventDispatcher.removeEventListener(PlayerManagerEvent.BET_PLACED_COMPLETE, onBetPlaceComplete);
			eventDispatcher.removeEventListener(PlayerManagerEvent.BET_PLACED_ERROR, onBetPlaceError);
			
			playerManager.refreshTokenBalance();
			
			model.currentState = GameEvent.GAME_STATE_PLAY;
			model.ticketsRemaining = model.totalTickets;
			model.bonusPoints = model.winningsSoFar = 0;
			
			dispatch(new GameEvent(GameEvent.START_GAME));
			
			commandMap.release(this);
		}
		
		private function onBetPlaceError(e:PlayerManagerEvent) : void {
			eventDispatcher.removeEventListener(PlayerManagerEvent.BET_PLACED_COMPLETE, onBetPlaceComplete);
			eventDispatcher.removeEventListener(PlayerManagerEvent.BET_PLACED_ERROR, onBetPlaceError);
			
			commandMap.release(this);
		}
	}
}