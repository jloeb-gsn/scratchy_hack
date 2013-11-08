package com.gsn.games.scratchy.views {
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class BonusPanelView extends Sprite {
		
		public var meterMc:MovieClip;
		public var fillMask:Sprite;
		public var bonus_tf:TextField;
		
		protected var currentBonusProgress:int = 0;
		protected var progressToAdd:int = 0;
		protected const SCALE:int = 8;
		
		public function BonusPanelView(mc:MovieClip) {
			meterMc = mc;
			fillMask = mc.getChildByName("MeterMask") as Sprite;//10px in fla
			fillMask.scaleY = .00125;
			bonus_tf = mc.getChildByName("TF_bonus") as TextField;
			bonus_tf.text = "1";
			super();
		}
		
		public function setBonusLevel(lvl:int):void {
			bonus_tf.text = String(lvl);
		}
		
		public function addBonusStickers(num:Number):void {
			if (num == 0) { return;}
			
			if ((currentBonusProgress % 4) + num < 4){//will not hit the top
				currentBonusProgress = num+currentBonusProgress;
				TweenLite.to(fillMask,.3,{scaleY:(1/num)});
			} else {
				progressToAdd = num - (4 - (currentBonusProgress % 4));
				TweenLite.to(fillMask, .2,{scaleY:(SCALE*4),onComplete:rolloverMeter});
			}
			
		}
		
		private function rolloverMeter():void {
			TweenLite.to(fillMask,.1,{scaleY: 1, onComplete: bonusTweenUp});
		}
		
		private function bonusTweenUp():void {
			bonus_tf.text = String(1+int(bonus_tf.text));
			TweenLite.to(fillMask,.15,{scaleY:(SCALE*progressToAdd)});
			currentBonusProgress = progressToAdd;
		}
	}
}