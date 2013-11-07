﻿package {    import flash.display.MovieClip;    import flash.events.MouseEvent;    import flash.events.Event;    import flash.display.Sprite;    import com.gsn.games.core.views.progressbar.BaseProgressBar;    /**     * Document Class for ProgressBar.fla     * Extends functionality from GameForge2 CoreProgressBar     * Available elements of the CoreProgressBar:     * <ul>     * <li>public var progressBar:MovieClip; // The bar which is resized to show progress</li>     * <li>public var progressBarBG:MovieClip; // An optional background around the bar to show total size</li>     * <li>public var background:MovieClip; // The main background</li>     * </ul>         * */    public class AnimatedProgressBar extends BaseProgressBar {        private const BUBBLE_MARGIN:int = 0;        // Animated GSN progressbar        public var animatedBar:MovieClip;        //        // Minimum animation length for the progressbar        private var _minPBarDuration:Number = (8 * 1000);        // Time the animation/load started        private var _startTime:Number;        // Flag indicating primary loading is complete and the progressbar animation is being throttled by the min duration        private var _throttledLoadingEnabled:Boolean = false;		// Length of the animation timeline		private var _lastFrame:int = 0;        public function AnimatedProgressBar() {            super();            // Stop the animation            animatedBar.gotoAndStop(1);						// Capture length of animation			_lastFrame = animatedBar.totalFrames            // Manage the minimum duration of the progressbar            _startTime = new Date().time;        }        override protected function updateProgress(in_percent:Number):void {            // Override to support a throttled progress animation            // showProgress is called by the loader.            // Determine the percentage complete as the minimum of the load progress or the timed min duration            var elapsedPCT:Number = getElapsedPCT();            var percent:Number = Math.min(in_percent, elapsedPCT);			            // If the load is complete but is faster than throttled speed, start an enterframe            if ((in_percent == 1) && (elapsedPCT < 1)) {                if (_throttledLoadingEnabled == false) {                    _throttledLoadingEnabled = true;                    this.addEventListener(Event.ENTER_FRAME, onThrottledLoadProgress);                }            }            if (percent == 1) {                if (_throttledLoadingEnabled == true) {                    _throttledLoadingEnabled = false;                    this.removeEventListener(Event.ENTER_FRAME, onThrottledLoadProgress);                    this.releaseProgressBar();                }                    //            }            // Show the progress            var newFrameNum:int = (_lastFrame * percent);            animatedBar.gotoAndStop(newFrameNum);        }        private function getElapsedTime():Number {            var curTime:Number = new Date().time;            return (curTime - _startTime);        }        private function getElapsedPCT():Number {            // If no time is set, always return 100%            if (_minPBarDuration == 0) {                return 1;            }            // If a time is set, get percent complete            var elapsed:Number = getElapsedTime();            return Math.min(1, (elapsed / _minPBarDuration));        }        private function onThrottledLoadProgress(event:Event):void {            updateProgress(getElapsedPCT());        }    }}