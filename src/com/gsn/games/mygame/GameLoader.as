package com.gsn.games.mygame {

    import com.gsn.games.core.models.common.constants.FlashVarNames;
    import com.gsn.games.core.views.gameloader.CoreGameLoader;
    import com.gsn.games.shared.utils.DebugUtils;

    import flash.utils.describeType;

    // AUTOMATED METADATA. DO NOT UPDATE. This metadata is replaced by the ANT task during compile
    [SWF(width = "760", height = "680", frameRate = "30", backgroundColor = "#FFFFFF")]

    /**
     * Game implementation of CoreSprite as a root level SWF to handle loading progress bar and then game app.
     * Width/height are assigned by ANT build task.
     * Path to progressbar and game app are assigned by ANT and inserted into assignedProgressBarPath and assignedAppPath.
     * */
    public class GameLoader extends CoreGameLoader {

        // AUTOMATED METADATA. DO NOT UPDATE. This metatdata is replaced by the ANT task during compile. Any changes will be replaced during compile
        [progressPathDefinition(pathName = "ProgressBar.swf")]
        public var assignedProgressBarPath:String;
        [appPathDefinition(pathName = "GameApp.swf")]
        public var assignedAppPath:String;

        // END AUTOMATED METADATA


        //--------------------------------------------
        // PUBLIC
        //--------------------------------------------
        public function GameLoader() {


            // Set the alignment if necessary
            //this.stage.align = StageAlign.TOP_LEFT;
            //this.stage.scaleMode = StageScaleMode.NO_SCALE;

            // Set debugging level
            DebugUtils.loggingLevel = DebugUtils.VERBOSE;

            super();

            // Turn off centering of the progress bar
            centerProgressBar = false;

        }


        //--------------------------------------------
        // PROTECTED
        //--------------------------------------------
        /**
         * Retrieve the assetPaths out of the metadata.
         * No need to update.
         * */
        override protected function assignPaths():void {

            // Generate the assets path
            super.assignPaths();

            // Retrieve paths out of metadata by retrieving the description
            var description:XML = describeType(this);

            var metaDataPath:XMLList;
            var arg:XMLList;

            //// PROGRESS BAR
            // First check for a FlashVar named "progressBarPath", next, use the data assigned through the meta data
            // If the path doesn't start as a full URL, the path is appended to the assetDir
            progressBarPath = flashVars[FlashVarNames.progressBarPath];
            if (progressBarPath == null) {
                // Use the meta version
                metaDataPath = (description..variable.(@name == "assignedProgressBarPath"));

                if (metaDataPath) {
                    arg = metaDataPath..arg.(@key == "pathName");
                    if (arg) {
                        progressBarPath = (arg.@value);
                    }
                }
            }
            if (progressBarPath.indexOf("http") == -1) {
                progressBarPath = assetDir + progressBarPath;
            }

            //// GAME APP
            // First check for a FlashVar named "gameAppPath", next, use the data assigned through the meta data
            // If the path doesn't start as a full URL, the path is appended to the assetDir
            gameAppPath = flashVars[FlashVarNames.gameAppPath];
            if (gameAppPath == null) {
                // Use the meta version
                metaDataPath = (description..variable.(@name == "assignedAppPath"));
                if (metaDataPath) {
                    arg = metaDataPath..arg.(@key == "pathName");
                    if (arg) {
                        gameAppPath = (arg.@value);

                    }
                }
            }
            if (gameAppPath.indexOf("http") == -1) {
                gameAppPath = mesmoResourceDir + gameAppPath;
            }

        }

        override protected function handleGameStartupFail():void {
            DebugUtils.log("GameLoader.handleGameStartupFail()", "MyGame", DebugUtils.VERBOSE);
        }

    }
}
