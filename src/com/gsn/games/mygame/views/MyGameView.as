package com.gsn.games.mygame.views {
	
	import com.gsn.games.mygame.controllers.events.GameAnalyticsEvent;
	import com.gsn.games.mygame.controllers.events.GameEvent;
	import com.gsn.games.mygame.models.GameVO;
	import com.gsn.games.shared.assetsmanagement.AssetManager;
	import com.gsn.games.shared.assetsmanagement.AssetVO;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
    * A Sample View.
	 * */
	public class MyGameView extends Sprite {
		
		// PROPERTIES
        
        // References to important display objects
		protected var myBackground:Sprite;
        protected var myPanel:Sprite;
        protected var myButton:MovieClip;
        protected var myTextField:TextField;
		
		// PUBLIC
		public function MyGameView() {
			super();
            this.iniUI();
		}
        
        // Sample callback functions
        public function getModelUpdate() : void {
            dispatchEvent(new GameEvent(GameEvent.UPDATE_MODEL));    
        }
        
        public function updateFromModel(vo:GameVO) : void {
            myTextField.text = vo.youDidIt;
        }
		
		private function trackEvent():void {
			var gaEvent:GameAnalyticsEvent=new GameAnalyticsEvent(GameAnalyticsEvent.TRACK);
			gaEvent.analyticsType=GameAnalyticsEvent.TRACK_DO_SOMETHING;
			dispatchEvent(gaEvent);
		}
        
		// PROTECTED
        
        /**
        * Requests all ui elements for this view
        * */
        protected function iniUI() : void {
            
            // Request assets
            var v:Vector.<String> = new Vector.<String>();
            v.push("PANEL_MyPanel");
            
            AssetManager.instance.bulkRequest(v, onAssetsLoaded);
            
        }
        
        /**
        * Callback triggered when all UI elements are received from Asset Manager.
        * Immediate if related bundles already loaded.
        * This function assembles & configures the UI
        * */
        protected function onAssetsLoaded(v:Vector.<AssetVO>) : void {
        
            for each (var vo:AssetVO in v) {
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
        
        protected function onMouseClick(e:Event) : void {
            // Request update of UI from model
            this.getModelUpdate();
			
			// Example analytics event
			this.trackEvent();
        }
		
		// PRIVATE
		
	}
}
