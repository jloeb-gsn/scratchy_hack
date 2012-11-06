package com.gsn.games.mygame {

    import com.gsn.games.core.CoreContext;
    import com.gsn.games.core.controllers.events.StartupEvent;
    import com.gsn.games.mygame.controllers.commands.AddGameViewCommand;
    import com.gsn.games.mygame.controllers.commands.GameAnalyticsCommand;
    import com.gsn.games.mygame.controllers.commands.GetModelUpdateCommand;
    import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.mygame.controllers.events.GameEvent;
    import com.gsn.games.mygame.models.GameModel;
    import com.gsn.games.mygame.services.GameAnalyticsHelper;
    import com.gsn.games.mygame.views.MyGameView;
    import com.gsn.games.mygame.views.MyGameViewMediator;

    import flash.display.DisplayObjectContainer;

    /**
     * Game-specific override of CoreContext.
     * Override the assignDevKey() function to assign a devKey for your game (REQUIRED).
     * Override or extend activateLoaders() if other LoaderMax loader types are needed.
     * Override or extend bootstrapOptionalModels(), bootstrapOptionalServices(), bootstrapOptionalMediators(), and bootstrapOptionalCommands() if other commands are required.
     * */
    public class GameContext extends CoreContext {

        public function GameContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
            super(contextView, autoStartup);
        }

        /**
         * Override the startup to add your models, services, commands, and views.
         * Don't forget to call super.startup() at the end of your function to allow the framework to continue.
         * */
        override public function startup():void {

            trace("startup");

            //!! map your custom commands, models, services, mediators here or in the bootstrap functions below...

            // Main view
            mediatorMap.mapView(MyGameView, MyGameViewMediator);

            // Example of a singleton Model
            injector.mapSingleton(GameModel);

            // When the framework is ready, the command is called which draws the first view
            commandMap.mapEvent(StartupEvent.GAMEFORGE2_READY, AddGameViewCommand, StartupEvent);
            commandMap.mapEvent(GameEvent.UPDATE_MODEL, GetModelUpdateCommand, GameEvent);

            // Example setup for analytics tracking
            commandMap.mapEvent(GameAnalyticsEvent.TRACK, GameAnalyticsCommand, GameAnalyticsEvent);


            // After you've mapped your items, call the super to start up the rest of the framework
            super.startup();

        }

        /**
         * Provide the devKey for your game.
         * */
        override protected function assignDevKey():String {
            return "98vspnAnjT3TUkqpbSrMGK6ApsGjy9KkK1Pvfeasin3tbodUWLe9tFAxOZB8trjc";
        }

        /**
         * Optionally override activateLoaders() to activate other Loadermax loader types
         * The default framework currently includes SWFLoader, ImageLoader, MP3Loader
         * You may override with your own or call super and then add additional ones
         * Example: LoaderMax.activate([SWFLoader, MP3Loader]);
         * */
        override protected function activateLoaders():void {

            // Call super to get the default loaders
            super.activateLoaders();
        }

        /**
         * Optionally override bootstrapOptionalModels() to activate your own Models or to omit the ones included in the framework
         * You may override or call super and add additional ones
         * */
        override protected function bootstrapOptionalModels():void {


            // Call super to include the optional Models
            super.bootstrapOptionalModels();
        }

        /**
         * Optionally override bootstrapOptionalServices() to activate your own Services or to omit the ones included in the framework
         * You may override or call super and add additional ones
         * */
        override protected function bootstrapOptionalServices():void {

            // Game-specific AnalyticHelper to assist with analytic events
            injector.mapSingleton(GameAnalyticsHelper);


            // Call super to include the optional Services
            super.bootstrapOptionalServices();
        }

        /**
         * Optionally override bootstrapOptionalMediators() to activate your own Mediators or to omit the ones included in the framework
         * You may override or call super and add additional ones
         * */
        override protected function bootstrapOptionalMediators():void {


            // Call super to include the optional Mediators
            super.bootstrapOptionalMediators();
        }

        /**
         * Optionally override bootstrapOptionalCommands() to activate your own Commands or to omit the ones included in the framework
         * You may override or call super and add additional ones
         * */
        override protected function bootstrapOptionalCommands():void {


            // Call super to include the optional Command
            super.bootstrapOptionalCommands();
        }
    }
}
