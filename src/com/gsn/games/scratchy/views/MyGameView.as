package com.gsn.games.scratchy.views {

    import com.greensock.TweenMax;
    import com.gsn.games.core.models.common.interfaces.IDisposable;
    import com.gsn.games.core.models.soundmanager.vo.SoundOptionsVO;
    import com.gsn.games.core.services.soundmanager.SoundManager;
    import com.gsn.games.scratchy.controllers.events.GameAnalyticsEvent;
    import com.gsn.games.scratchy.controllers.events.GameEvent;
    import com.gsn.games.scratchy.models.GameVO;
    import com.gsn.games.shared.assetsmanagement.AssetManager;
    import com.gsn.games.shared.assetsmanagement.AssetVO;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
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
		protected var panel_scratch:ScratchCardView;
		protected var panel_results:ResultsView;
		
		protected var btn_incr:MyActionButton;
		protected var btn_decr:MyActionButton;
		
		protected var numTickets_tf:TextField;
		protected var betPerTicket_tf:TextField;
		protected var totalBet_tf:TextField;
		
		private var _numTickets:int;
		private var _betPerTicket:int;
		private var _totalBet:int;

//		protected var hud;
        //--------------------------------------------
        // PUBLIC
        //--------------------------------------------
        public function MyGameView() {

            super();
            initUI();
        }
		
		public function set numTickets(val:int):void {
			_numTickets = val;
			
			if (numTickets_tf) {
				numTickets_tf.text = val.toString();
			}
		}
		
		public function set betPerTicket(val:int):void {
			_betPerTicket = val;
			
			if (betPerTicket_tf) {
				betPerTicket_tf.text = val.toString();
			}
		}
		
		public function set totalBet(val:int):void {
			_totalBet = val;
			
			if (totalBet_tf) {
				totalBet_tf.text = val.toString();
			}
		}
		
		public function set incrEnabled(val:Boolean):void {
			btn_incr.enabled = val;
		}
		
		public function set decrEnabled(val:Boolean):void {
			btn_decr.enabled = val;
		}

        public function updateFromModel(vo:GameVO):void {

		}
		
		public function startScratching():void {
			removeChild(panel_wager);
			addChild(panel_scratch);
			panel_scratch.start(_numTickets);
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
			AssetManager.instance.buildPanel("results_panel", onResultsPanel);

            // Request additional assets. Add the name of each asset, at it appears in the assetsManifest.xml or gameConfig.xml
            var assetNameV:Vector.<String> = new Vector.<String>();
            assetNameV.push("SND_music", "SND_cardlose", "SND_cardwin", "SND_results", "SND_gamestart", "SND_buycards", "SND_bonuslevelup");
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
						
						numTickets_tf = panel_wager.getChildByName("TF_numTickets") as TextField;
						betPerTicket_tf = panel_wager.getChildByName("TF_betPerTicket") as TextField;
						totalBet_tf = panel_wager.getChildByName("TF_totalBet") as TextField;
						
						numTickets = _numTickets;
						betPerTicket = _betPerTicket;
						totalBet = _totalBet;
                        break;
					case "BTN_Start":
						// Because my layout uses the same button asset for the buttons, differentiate by the instance name assigned to each
						var btn:MyActionButton = new MyActionButton(vo.asset as MovieClip);
						btn.addEventListener(MouseEvent.CLICK, onStart);
						break;
					case "BTN_Add":
						this.btn_incr = new MyActionButton(vo.asset as MovieClip);
						this.btn_incr.addEventListener(MouseEvent.CLICK, onIncrBet);
						break;
					case "BTN_Subtract":
						this.btn_decr = new MyActionButton(vo.asset as MovieClip);
						this.btn_decr.addEventListener(MouseEvent.CLICK, onDecrBet);
						break;
                }
            }
        }
		
		protected function onResultsPanel(loadedAssetsV:Vector.<AssetVO>):void {
			var panel:MovieClip; var tix:TextField; var bet:TextField; var won:TextField;
			
			for each (var vo:AssetVO in loadedAssetsV) {
				switch (vo.name) {
					case "PANEL_Results":
						panel = vo.asset as MovieClip;
						break;
					case "GFX_Winningtickets":
						tix = (vo.asset as MovieClip).getChildByName("TF_amount") as TextField;
						break;
					case "GFX_Totalbet":
						bet = (vo.asset as MovieClip).getChildByName("TF_amount") as TextField;
						break;
					case "GFX_TotalWon":
						won = (vo.asset as MovieClip).getChildByName("TF_amount") as TextField;
						break;
				}
			}
			panel_results = new ResultsView(panel, tix, bet, won);
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
                    case "SND_music":
                        // Register the sound
                        SoundManager.instance.registerSound(vo.sound, "main_music", SoundManager.SOUND_TYPE_MUSIC);
						SoundManager.instance.playSound("main_music", new SoundOptionsVO(.4,-1,0,false,SoundOptionsVO.PLAYBACK_TYPE_RESTART));
                        break;
					default:
						SoundManager.instance.registerSound(vo.sound, vo.name, SoundManager.SOUND_TYPE_SFX);
						break;
                }
            }

        }

        protected function onStart(event:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.PLACE_BET));
			SoundManager.instance.playSound("SND_gamestart");
		}
		
		protected function onIncrBet(evt:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.INCR_BET));
		}
		
		protected function onDecrBet(evt:MouseEvent):void {
			dispatchEvent(new GameEvent(GameEvent.DECR_BET));
		}
		
		public function onGameEnd(tickets:int, bet:int, won:int):void {
			removeChild(panel_scratch);
			addChild(panel_results);
			panel_results.showResults(tickets, bet, won);
			SoundManager.instance.playSound("SND_results");
			//temp:
			TweenMax.delayedCall(8, onResultsEnd);
		}
		
		public function onResultsEnd():void {
			removeChild(panel_results);
			addChild(panel_wager);
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
