package com.gsn.games.scratchy.views {

    import com.gsn.games.core.controllers.events.ShowPurchaseDialogEvent;
    import com.gsn.games.core.controllers.events.StartupEvent;
    import com.gsn.games.core.models.gameconfigmanager.IGameConfigManager;
    import com.gsn.games.core.models.languagemanager.ILanguageManager;
    import com.gsn.games.core.models.playermanager.IPlayerManager;
    import com.gsn.games.scratchy.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.scratchy.controllers.events.GameEvent;
    import com.gsn.games.scratchy.models.GameModel;
    import com.gsn.games.scratchy.services.GameAnalyticsHelper;
    
    import org.robotlegs.mvcs.Mediator;

    /**
     * Mediator : communication point between a view and the game.
     * This class should not have any UI Logic.
     */
    public class MyGameViewMediator extends Mediator {

        // INJECTIONS
        // Reference to the view mapped to this mediator
        [Inject]
        public var view:MyGameView;
        [Inject]
        public var languageManager:ILanguageManager;
        [Inject]
        public var gameAnalytics:GameAnalyticsHelper;
        [Inject]
        public var gameConfigManager:IGameConfigManager;
		[Inject]
		public var model:GameModel;
		[Inject]
		public var playerManager:IPlayerManager;

        // PROPERTIES


        // GETTERS/SETTERS



        // PUBLIC
        /**
         * Fired as soon as the mapped View is added to stage.
         * */
        override public function onRegister():void {
			view.numTickets = model.totalTickets;
			updateBetAmount();

            // Listeners to the view - re-dispatch automatically to game 
            // Note: views do not need to use mediators to talk to each other
            addViewListener(GameEvent.UPDATE_MODEL, dispatch);
			addViewListener(GameEvent.PLACE_BET, onPlaceBet);
			addViewListener(GameEvent.INCR_BET, onIncrBet);
			addViewListener(GameEvent.DECR_BET, onDecrBet);

            // Listeners to the game
            addContextListener(GameEvent.GAME_MODEL_UPDATED, onGameModelUpdated);
			addContextListener(GameEvent.END_GAME, onGameEnd);
			addContextListener(GameEvent.START_GAME, onGameStart);

            // Example usage of analytics tracking from the view
            addViewListener(GameAnalyticsEvent.TRACK, onTrackClick);


            // Call the super.onRegister() to complete mediation
            super.onRegister();

            // Example using the LanguageManager to look up a text message
           // var balanceText:String = languageManager.getMessage("balance_label");
            //DebugUtils.log(("test lang lookup:" + balanceText), "TestGame", DebugUtils.VERBOSE);

        }

        /**
         * Fired when the view is removed from the stage.
         * Handle all cleanup of eventListeners here.
         * */
        override public function onRemove():void {

            removeContextListener(StartupEvent.GAMEFORGE2_READY, onGameModelUpdated, StartupEvent);

            // Call the super.onRemove() to complete removal of mediator
            super.onRemove();

            // Clean up the view
            view.dispose();

        }


        // PROTECTED
        /**
         * Event handler for GameModel update.
         * */
        protected function onGameModelUpdated(event:GameEvent):void {
            // Example output
            view.updateFromModel(event.vo);

            // Example calling an analytics event through GameAnalyticsHelper
            gameAnalytics.trackPopupCount();
        }
		
		protected function onPlaceBet(event:GameEvent):void {
			var betPerTicket:int = GameModel.BET_AMOUNTS[model.betIndex];
			var totalBet:int = model.totalTickets * betPerTicket;
			
			playerManager.tokens = totalBet;
			if(totalBet <= playerManager.tokens) {
				dispatch(event);
			} else {
				var showDialogEvent:ShowPurchaseDialogEvent = new ShowPurchaseDialogEvent(ShowPurchaseDialogEvent.SHOW_PURCHASE_DIALOG);
				showDialogEvent.suggestedMinimum = totalBet;
				dispatch(showDialogEvent);
			}
		}
		
		protected function onIncrBet(evt:GameEvent):void {
			model.betIndex++;
			if (model.betIndex == GameModel.BET_AMOUNTS.length - 1) {
				view.incrEnabled = false;
			}
			
			view.decrEnabled = true;
			updateBetAmount();
		}
		
		protected function onDecrBet(evt:GameEvent):void {
			model.betIndex--;
			if (model.betIndex == 0) {
				view.decrEnabled = false;
			}
			
			view.incrEnabled = true;
			updateBetAmount();
		}
		
		protected function updateBetAmount():void {
			const betPerTicket:int = GameModel.BET_AMOUNTS[model.betIndex];
			view.betPerTicket = betPerTicket;
			view.totalBet = model.totalTickets * betPerTicket;
		}
		
		protected function onGameStart(evt:GameEvent):void {
			view.startScratching();
		}
		
		protected function onGameEnd(event:GameEvent):void {
			view.onGameEnd(model.totalTickets, model.totalBet, model.winningsSoFar);
		}

        /**
         * Event handler for tracking events from the view
         * */
        protected function onTrackClick(event:GameAnalyticsEvent):void {
            // The GameAnalyticsHelper shows an example of switching tracking events based on the event.analyticsType

            gameAnalytics.trackCustomEvent(event.analyticsType);
        }

        // PRIVATE


    }

}
