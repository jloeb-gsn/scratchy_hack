package com.gsn.games.scratchy.models
{
    import com.gsn.games.core.models.playermanager.IPlayerManager;
    import com.gsn.games.scratchy.controllers.events.GameEvent;
    
    import org.robotlegs.mvcs.Actor;

    /**
    * Sample of game model
    * */
    public class GameModel extends Actor {
        
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
		public var betPerTicket:int;
		public var totalTickets:int;
		
		// scratching state variables needed
		public var ticketsRemaining:int;
		public var bonusPoints:int;
		public var winningsSoFar:int = 0;
		
		
    }
}