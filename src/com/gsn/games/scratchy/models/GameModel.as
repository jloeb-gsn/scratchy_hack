package com.gsn.games.scratchy.models
{
    import com.gsn.games.core.models.playermanager.IPlayerManager;
    import com.gsn.games.scratchy.controllers.events.GameEvent;
    
    import org.robotlegs.mvcs.Actor;

    /**
    * Sample of game model
    * */
    public class GameModel extends Actor {
        
		public static const BET_AMOUNTS:Vector.<int> = new <int>[10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000];
		
        // Some attributes
        public var vo:GameVO;
		
		[Inject]
		public var playerMgr:IPlayerManager;
		        
        public function GameModel() {
            vo = new GameVO();
        }
		
		private static var _instance:GameModel;
		
		public static function get instance():GameModel {
			if (GameModel._instance == null){
				GameModel._instance = new GameModel();
			}
			return GameModel._instance;
		}
		
		/////// Game variables
		public var currentState:String = GameEvent.GAME_STATE_WAGER;
		
		//wager state variables needed
		public var betIndex:int = 3;
		public var totalTickets:int = 25;
		
		// scratching state variables needed
		public var ticketsRemaining:int;
		public var bonusPoints:int;
		public var winningsSoFar:int = 0;
		
		public function get bonusLevel():int {
			return int(Math.floor(bonusPoints/5))+1;
		}
    }
}