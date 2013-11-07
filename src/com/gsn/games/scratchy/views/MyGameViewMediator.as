package com.gsn.games.scratchy.views {

    import com.gsn.games.core.controllers.events.StartupEvent;
    import com.gsn.games.core.models.gameconfigmanager.IGameConfigManager;
    import com.gsn.games.core.models.languagemanager.ILanguageManager;
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

        // PROPERTIES


        // GETTERS/SETTERS



        // PUBLIC
        /**
         * Fired as soon as the mapped View is added to stage.
         * */
        override public function onRegister():void {

            // Listeners to the view - re-dispatch automatically to game 
            // Note: views do not need to use mediators to talk to each other
            addViewListener(GameEvent.UPDATE_MODEL, dispatch);

            // Listeners to the game
            addContextListener(GameEvent.GAME_MODEL_UPDATED, onGameModelUpdated);
			addViewListener(GameEvent.START_GAME, onGameStart);

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
		
		protected function onGameStart(event:GameEvent):void {
			model.betPerTicket = view.BET_PER_TICKET;
			model.totalTickets = view.NUMBER_OF_TICKETS;
			model.currentState = GameEvent.GAME_STATE_PLAY;
			model.ticketsRemaining = model.totalTickets = 10;
			model.bonusPoints = model.winningsSoFar = 0;
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
