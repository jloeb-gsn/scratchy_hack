﻿package {	import com.gsn.games.core.views.progressbar.BaseProgressBar;	    /**     * Document Class for ProgressBar.fla     * Extends functionality from GameForge2 BaseProgressBar	 * Available elements of the CoreProgressBar:	 * <ul>	 * <li>public var progressBar:MovieClip; // The bar which is resized to show progress</li>	 * <li>public var progressBarBG:MovieClip; // An optional background around the bar to show total size</li>	 * <li>public var background:MovieClip; // The main background</li>	 * </ul>     * */    public class ProgressBar extends BaseProgressBar {        public function ProgressBar() {            super();        }				override public function showProgress(percent:Number):void {			// You can override the function to handle different load types						// Super defaults to scaling the progressBar			super.showProgress(percent);					}    }}