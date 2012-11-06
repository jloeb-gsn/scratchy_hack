package com.gsn.games.mygame.controllers.commands {
    
    import com.gsn.games.mygame.controllers.events.GameEvent;
    import com.gsn.games.mygame.models.GameModel;
    
    import org.robotlegs.mvcs.Command;
    
    /**
    * Sample Do Something command
    * */
    public class GetModelUpdateCommand extends Command {
        
        // INJECTIONS
        [Inject]
        public var model:GameModel;
        
		
        // CONSTANTS
        
        
        // PROPERTIES
        
        
        // PUBLIC
        public function GetModelUpdateCommand() {
            super();
        }
        
        /**
        * Sample of round-trip communication View<->Command<->Model
        * */
        override public function execute():void {
            
            // <Insert your code here>
            model.vo.youDidIt = "You did It!"; 
            
            // Notify listeners (especially views)
            var evt:GameEvent = new GameEvent(GameEvent.GAME_MODEL_UPDATED);
            // Include a snapshot of the model - views can't change models directly to keep things losely coupled
            evt.vo = model.vo.clone();
            dispatch(evt);
        }
        
        
        // PROTECTED
        
        
        
        // PRIVATE
        
        
    }
}
