package com.gsn.games.mygame.views {

    import com.gsn.games.core.models.common.interfaces.IDisposable;
    import com.gsn.games.core.models.languagemanager.LanguageManager;
    import com.gsn.games.core.services.soundmanager.SoundManager;
    import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.mygame.controllers.events.GameEvent;
    import com.gsn.games.mygame.models.GameVO;
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
        protected var pnlMain:Sprite;
        protected var btnChange:MCButton;
        protected var btnReset:MCButton;
        protected var btnRestart:MCButton;
        protected var btnQuit:MCButton;
        protected var btnClose:MCButton;
        protected var txtOutput:TextField;

        //--------------------------------------------
        // PUBLIC
        //--------------------------------------------
        public function MyGameView() {

            super();
            initUI();
        }

        public function updateFromModel(vo:GameVO):void {
            txtOutput.text = vo.message;
        }

        /**
         * Handle cleanup
         * */
        public function dispose():void {

            if (btnChange) {
                btnChange.removeEventListener(MouseEvent.CLICK, onMouseClick);
            }
            if (btnReset) {
                btnReset.removeEventListener(MouseEvent.CLICK, onMouseClick);
            }
            if (btnRestart) {
                btnRestart.removeEventListener(MouseEvent.CLICK, onMouseClick);
            }
            if (btnQuit) {
                btnQuit.removeEventListener(MouseEvent.CLICK, onMouseClick);
            }
            if (btnClose) {
                btnClose.removeEventListener(MouseEvent.CLICK, onMouseClick);
            }
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
            AssetManager.instance.buildPanel("main_screen_1", onMainPanel1Complete);

            // Request additional assets. Add the name of each asset, at it appears in the assetsManifest.xml or gameConfig.xml
            var assetNameV:Vector.<String> = new Vector.<String>();
            //assetNameV.push("SND_Aww");
            assetNameV.push("SND_Beginpuzzle");
            assetNameV.push("SND_Click02");
            //assetNameV.push("SND_Correctletter");
            assetNameV.push("SND_Prize03");
            AssetManager.instance.bulkRequest(assetNameV, onAssetsLoaded);

        }

        private function onMainPanel1Complete(loadedAssetsV:Vector.<AssetVO>):void {

            for each (var vo:AssetVO in loadedAssetsV) {

                switch (vo.name) {
                    case "PANEL_Main":
                        pnlMain = vo.asset as Sprite;
                        addChild(pnlMain);
                        txtOutput = pnlMain.getChildByName("PROP_Output") as TextField;
                        break;
                    case "BTN_EditAction":
                        // Because my layout uses the same button asset for the buttons, differentiate by the instance name assigned to each
                        var instanceName:String = vo.instanceName;
                        var buttonLabel:String = LanguageManager.instance.getMessage(instanceName);
                        switch (instanceName) {
                            case "button_change":
                                btnChange = new MyActionButton(vo.asset as MovieClip, buttonLabel);
                                btnChange.addEventListener(MouseEvent.CLICK, onMouseClick);
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
                        }
                        break;
                    case "BTN_Close":
                        btnClose = new MCButton(vo.asset as MovieClip);
                        btnClose.addEventListener(MouseEvent.CLICK, onMouseClick);
                        break;

                }
            }
        }

        private function onMainPanel2Complete(loadedAssetsV:Vector.<AssetVO>):void {
            for each (var vo:AssetVO in loadedAssetsV) {
                switch (vo.name) {
                    case "PANEL_Main":
                        pnlMain = vo.asset as Sprite;
                        addChild(pnlMain);
                        txtOutput = pnlMain.getChildByName("PROP_Output") as TextField;
                        break;
                    case "BTN_Close":
                        // Because my layout uses the same button asset for the buttons, differentiate by the instance name assigned to each
                        switch (vo.instanceName) {
                            case "button_change":
                                btnChange = new MCButton(vo.asset as MovieClip);
                                btnChange.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_reset":
                                btnReset = new MCButton(vo.asset as MovieClip);
                                btnReset.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_restart":
                                btnRestart = new MCButton(vo.asset as MovieClip);
                                btnRestart.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_quit":
                                btnQuit = new MCButton(vo.asset as MovieClip);
                                btnQuit.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                            case "button_close":
                                btnClose = new MCButton(vo.asset as MovieClip);
                                btnClose.addEventListener(MouseEvent.CLICK, onMouseClick);
                                break;
                        }
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

        protected function onMouseClick(event:Event):void {

            var instanceName:String = (event.currentTarget as DisplayObject).name;
            var message:String = "Clicked: " + instanceName;
            switch (instanceName) {
                case "button_change":
                    SoundManager.instance.playSound("click");
                    break;
                case "button_reset":
                    SoundManager.instance.playSound("begin");
                    break;
                case "button_restart":
                    SoundManager.instance.playSound("click");
                    break;
                case "button_quit":
                    SoundManager.instance.playSound("begin");
                    break;
                case "button_close":
                    SoundManager.instance.playSound("prize");
                    break;
            }


            // Request update of UI from model
            this.getModelUpdate(message);

            // Example analytics event
            this.trackEvent();

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
