package com.gsn.games.scratchy.views {

    import com.gsn.games.core.models.common.interfaces.IDisposable;
    import com.gsn.games.core.models.languagemanager.LanguageManager;
    import com.gsn.games.core.services.soundmanager.SoundManager;
    import com.gsn.games.scratchy.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.scratchy.controllers.events.GameEvent;
    import com.gsn.games.scratchy.models.GameVO;
    import com.gsn.games.shared.assetsmanagement.AssetManager;
    import com.gsn.games.shared.assetsmanagement.AssetVO;
    import com.gsn.games.shared.components.mcbutton.MCButton;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    /**
     * Sample View
     * */
    public class MyGameView extends Sprite implements IDisposable {

        //--------------------------------------------
        // CONSTANTS
        //--------------------------------------------

        //--------------------------------------------
        // PROPERTIES
        //--------------------------------------------
        // References to important display objects
        protected var panel_wager:Sprite;
		protected var panel_scratch:Sprite;
		protected var panel_results:Sprite;
		
		public var BET_PER_TICKET:int = 100;
		public var NUMBER_OF_TICKETS:int = 10;

//		protected var hud;
        //--------------------------------------------
        // PUBLIC
        //--------------------------------------------
        public function MyGameView() {

            super();
            initUI();
        }

        public function updateFromModel(vo:GameVO):void {

		}

        /**
         * Handle cleanup
         * */
        public function dispose():void {

        }


        //--------------------------------------------
        // PROTECTED
        //--------------------------------------------
        /**
         * Requests all ui elements for this view
         *
         * */
        protected function initUI():void {

            // Request a panel build
            AssetManager.instance.buildPanel("wager_panel", onMainPanel1Complete);
			panel_scratch = new ScratchCardView();

            // Request additional assets. Add the name of each asset, at it appears in the assetsManifest.xml or gameConfig.xml
            var assetNameV:Vector.<String> = new Vector.<String>();
            //assetNameV.push("SND_Aww");
           // assetNameV.push("SND_Beginpuzzle");
            //assetNameV.push("SND_Click02");
            //assetNameV.push("SND_Correctletter");
           // assetNameV.push("SND_Prize03");
            AssetManager.instance.bulkRequest(assetNameV, onAssetsLoaded);

        }

        private function onMainPanel1Complete(loadedAssetsV:Vector.<AssetVO>):void {

            for each (var vo:AssetVO in loadedAssetsV) {

                switch (vo.name) {
                    case "PANEL_Wager":
						panel_wager = vo.asset as Sprite;
                        addChild(panel_wager);
                       // txtOutput = pnlMain.getChildByName("PROP_Output") as TextField;
                        break;
                    case "BTN_Start":
                        // Because my layout uses the same button asset for the buttons, differentiate by the instance name assigned to each
                        var btn:MyActionButton = new MyActionButton(vo.asset as MovieClip);
						btn.addEventListener(MouseEvent.CLICK, onStart);
                      //  var buttonLabel:String = LanguageManager.instance.getMessage(instanceName);
                      /*  switch (instanceName) {
                            case "button_change":
                             //   btnChange = new MyActionButton(vo.asset as MovieClip, buttonLabel);
                             //   btnChange.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_reset":
                               btnReset = new MyActionButton(vo.asset as MovieClip, buttonLabel);
                                btnReset.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_restart":
                                btnRestart = new MyActionButton(vo.asset as MovieClip, buttonLabel);
                                btnRestart.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_quit":
                                btnQuit = new MyActionButton(vo.asset as MovieClip, buttonLabel);
                                btnQuit.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                        }*/
                        break;
                    case "BTN_Close":
                    //    btnClose = new MCButton(vo.asset as MovieClip);
                   //     btnClose.addEventListener(MouseEvent.CLICK, onMouseClick);
                        break;

                }
            }
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
                    case "SND_Aww":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "aww", SoundManager.SOUND_TYPE_SFX);
                        break;
                    case "SND_Beginpuzzle":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "begin", SoundManager.SOUND_TYPE_SFX);
                        break;
                    case "SND_Click02":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "click", SoundManager.SOUND_TYPE_SFX);
                        break;
                    case "SND_Correctletter":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "correct", SoundManager.SOUND_TYPE_SFX);
                        break;
                    case "SND_Prize03":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "prize", SoundManager.SOUND_TYPE_SFX);
                        break;
                }
            }

        }

        protected function onStart(event:MouseEvent):void {
			removeChild(panel_wager);
			addChild(panel_scratch);
			dispatchEvent(new GameEvent(GameEvent.START_GAME));
		}
		

        //--------------------------------------------
        // PRIVATE
        //--------------------------------------------
        private function getModelUpdate(message:String):void {
            var gameEvent:GameEvent = new GameEvent(GameEvent.UPDATE_MODEL);
            gameEvent.message = message;
            dispatchEvent(gameEvent);
        }

        private function trackEvent():void {
            // This event is received by GameAnalyticsCommand
            var gaEvent:GameAnalyticsEvent = new GameAnalyticsEvent(GameAnalyticsEvent.TRACK);
            gaEvent.analyticsType = GameAnalyticsEvent.TRACK_DO_SOMETHING;
            dispatchEvent(gaEvent);
        }

    }
}
