package com.gsn.games.mygame {
	
	import flash.display.Sprite;
	
	[SWF(width = "760", height = "550", frameRate = "30")]
	public class my_app extends Sprite {
		//
		private var _context:GameContext;
		
		//
		public function my_app() {
			
			// Initialize the GameContext
			_context = new GameContext(this);
		}
	}
}
