package com.gsn.games.mygame.views {

    import com.gsn.games.core.controllers.events.StartupEvent;
    import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.mygame.controllers.events.GameEvent;

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

            // Example usage of analytics tracking
            addViewListener(GameAnalyticsEvent.TRACK, dispatch);


            // Call the super.onRegister() to complete mediation
            super.onRegister();

        }

        /**
         * Fired when the view is removed from the stage.
         * Handle all cleanup of eventListeners here.
         * */
        override public function onRemove():void {

            removeContextListener(StartupEvent.GAMEFORGE2_READY, onGameModelUpdated, StartupEvent);

            // Call the super.onRemove() to complete removal of mediator
            super.onRemove();
        }


        // PROTECTED
        /**
         * Event handler for GameModel update.
         * */
        protected function onGameModelUpdated(event:GameEvent):void {
            // Example output
            view.updateFromModel(event.vo);
        }

        // PRIVATE


    }

}
