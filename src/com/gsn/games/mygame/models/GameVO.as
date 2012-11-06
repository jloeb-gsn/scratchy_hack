package com.gsn.games.mygame.models
{
    /**
    * Sample of game value object.
    * */
    public class GameVO {
        // Some properties here
        public var youDidIt:String;
        
        public function clone() : GameVO {

            var vo:GameVO = new GameVO();
            // clone attributes
            vo.youDidIt = youDidIt;
            
            return vo;
        }
    }
}