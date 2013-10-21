package com.gsn.games.mygame.models
{
    /**
    * Sample of game value object.
    * */
    public class GameVO {
        // Some properties here
        public var message:String;
        
        public function clone() : GameVO {

            var vo:GameVO = new GameVO();
            // clone attributes
            vo.message = message;
            
            return vo;
        }
    }
}