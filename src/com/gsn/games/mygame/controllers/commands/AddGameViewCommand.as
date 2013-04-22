package com.gsn.games.mygame.controllers.commands {

    import com.gsn.games.mygame.views.MyGameView;
    import com.gsn.games.shared.utils.LayerManager;

    import org.robotlegs.mvcs.Command;

    /**
     * Add MyGameView to display list once GameForge2 is ready
     * */
    public class AddGameViewCommand extends Command {


        [Inject]
        public var layerManager:LayerManager;

        // PUBLIC
        public function AddGameViewCommand() {
            super();

        }

        /**
         * On execute of command, the first game view is added
         * */
        override public function execute():void {
            var myGameView:MyGameView = new MyGameView();
            layerManager.addChild(myGameView, LayerManager.BACKGROUND_LAYER);
        }

    }
}
