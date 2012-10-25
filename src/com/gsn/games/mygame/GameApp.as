package com.gsn.games.mygame {

    import flash.display.Sprite;

	// AUTOMATED METADATA. DO NOT UPDATE.This metadata is replaced by the ANT task during compile
	[SWF(width = "760", height = "550", frameRate = "30")]
	
    public class GameApp extends Sprite {
        //
        private var _context:GameContext;

        //
        public function GameApp() {

            // Initialize the GameContext
            _context = new GameContext(this);

        }
    }
}
