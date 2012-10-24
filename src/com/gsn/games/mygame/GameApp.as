package com.gsn.games.mygame {
	
	import flash.display.Sprite;
	
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
