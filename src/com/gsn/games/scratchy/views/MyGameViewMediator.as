package com.gsn.games.mygame.views {

    import com.gsn.games.core.controllers.events.StartupEvent;
    import com.gsn.games.core.models.gameconfigmanager.IGameConfigManager;
    import com.gsn.games.core.models.languagemanager.ILanguageManager;
    import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.mygame.controllers.events.GameEvent;
    import com.gsn.games.mygame.services.GameAnalyticsHelper;
    import com.gsn.games.shared.utils.DebugUtils;
    import com.gsn.games.shared.utils.JSONUtils;

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

            // Example usage of analytics tracking from the view
            addViewListener(GameAnalyticsEvent.TRACK, onTrackClick);


            // Call the super.onRegister() to complete mediation
            super.onRegister();

            // Example using the LanguageManager to look up a text message
            var balanceText:String = languageManager.getMessage("balance_label");
            DebugUtils.log(("test lang lookup:" + balanceText), "TestGame", DebugUtils.VERBOSE);

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