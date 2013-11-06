package com.gsn.games.mygame {

    import com.gsn.games.core.views.gameapp.CoreGameApp;
    import com.gsn.games.shared.utils.DebugUtils;

    // AUTOMATED METADATA. DO NOT UPDATE. This metadata is replaced by the ANT task during compile
    [SWF(width="760", height="680", frameRate="30", backgroundColor="#FFFFFF")]

    public class GameApp extends CoreGameApp {
        //
        public function GameApp() {

            // Initialize the GameContext
            DebugUtils.loggingLevel = DebugUtils.VERBOSE;
            context = new GameContext(this);

        }
    }
}
