package com.gsn.games.mygame.models
{
    import org.robotlegs.mvcs.Actor;

    /**
    * Sample of game model
    * */
    public class GameModel extends Actor {
        
        // Some attributes
        public var vo:GameVO;
        
        public function GameModel() {
            vo = new GameVO();
        }
    }
}