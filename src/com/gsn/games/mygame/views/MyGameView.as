package com.gsn.games.mygame.views {

    import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.mygame.controllers.events.GameEvent;
    import com.gsn.games.mygame.models.GameVO;
    import com.gsn.games.shared.assetsmanagement.AssetManager;
    import com.gsn.games.shared.assetsmanagement.AssetVO;
    import com.gsn.games.shared.utils.LayerManager;
    

    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    /**
     * Sample View
     * */
    public class MyGameView extends Sprite {

        //--------------------------------------------
        // CONSTANTS
        //--------------------------------------------

        //--------------------------------------------
        // PROPERTIES
        //--------------------------------------------
        // References to important display objects
        protected var myBackground:Sprite;
        protected var myPanel:Sprite;
        protected var myButton:MovieClip;
        protected var myTextField:TextField;

        //--------------------------------------------
        // PUBLIC
        //--------------------------------------------
        public function MyGameView() {

            super();
            initUI();
        }

        public function updateFromModel(vo:GameVO):void {
            myTextField.text = vo.youDidIt;
        }


        //--------------------------------------------
        // PROTECTED
        //--------------------------------------------
        /**
         * Requests all ui elements for this view
         *
         * */
        protected function initUI():void {

            // Request assets
            var assetNameV:Vector.<String> = new Vector.<String>();

            // Add identifiers of all assets needed at this time by this view
            // Example: we want one instance of an asset identified by "PANEL_MyPanel"
            // Note that identifier is different than classname
            // This identifier is what you have defined in gameConfig.xml
            assetNameV.push("PANEL_MyPanel");

            AssetManager.instance.bulkRequest(assetNameV, onAssetsLoaded);

        }

        /**
         * Callback triggered when all UI elements are received from Asset Manager.
         * Immediate if related bundles already loaded.
         * This function assembles & configures the UI
         * */
        protected function onAssetsLoaded(loadedAssetsV:Vector.<AssetVO>):void {

            // Loop over all assets returned from request
            // Do something with them
            for each (var vo:AssetVO in loadedAssetsV) {
                switch (vo.name) {
                    case "PANEL_MyPanel":
                        myPanel = vo.asset as Sprite;
                        addChild(myPanel);
                        break;
                }
            }

            // Get references on UI elements
            myBackground = myPanel.getChildByName("PROP_myBackground") as Sprite;
            myButton = myPanel.getChildByName("PROP_doSomething") as MovieClip;
            myButton.buttonMode = true;
            myButton.mouseChildren = false;
            myButton.addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
            myTextField = myPanel.getChildByName("PROP_txtfeedback") as TextField;

            // Swap placeholders if needed
            // This utility function replaces the placeholder identified by "PROP_myBackground" 
            // by the display object myNewBackground in container myPanel
            //FlashUtils.swapSymbols("PROP_myBackground", myNewBackground, myPanel);

        }

        protected function onMouseClick(e:Event):void {
            // Request update of UI from model
            this.getModelUpdate();

            // Example analytics event
            this.trackEvent();
        }

        //--------------------------------------------
        // PRIVATE
        //--------------------------------------------
        private function getModelUpdate():void {
            dispatchEvent(new GameEvent(GameEvent.UPDATE_MODEL));
        }

        private function trackEvent():void {
            var gaEvent:GameAnalyticsEvent = new GameAnalyticsEvent(GameAnalyticsEvent.TRACK);
            gaEvent.analyticsType = GameAnalyticsEvent.TRACK_DO_SOMETHING;
            dispatchEvent(gaEvent);
        }

    }
}
