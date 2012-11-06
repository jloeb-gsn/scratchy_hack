package com.gsn.games.mygame.controllers.commands {
	
	import com.gsn.games.mygame.views.MyGameView;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Add MyGameView to display list once GameForge2 is ready
	 * */
	public class AddGameViewCommand extends Command {
		
		
		// PUBLIC
		public function AddGameViewCommand() {
			super();
            
		}
		
		/**
		 * On execute of command, the first game view is added
		 * */
		override public function execute():void {
			contextView.addChild(new MyGameView());
		}
        
	}
}
