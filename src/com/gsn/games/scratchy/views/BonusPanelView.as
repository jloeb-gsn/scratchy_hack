package com.gsn.games.scratchy.views {
	import com.greensock.TweenLite;
	import com.gsn.games.core.models.soundmanager.vo.SoundOptionsVO;
	import com.gsn.games.core.services.soundmanager.SoundManager;
	
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
		
		protected var sndLevel:Number = .4;
		
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
				currentBonusProgress = num+(currentBonusProgress % 4);
				TweenLite.to(fillMask,.3,{scaleY:(currentBonusProgress/4)});
			} else {//will hit the top
				progressToAdd = (num + currentBonusProgress) % 4;
				TweenLite.to(fillMask, .2,{scaleY:(1),onComplete:rolloverMeter});
			}
			
		}
		
		private function rolloverMeter():void {
			SoundManager.instance.playSound("SND_bonuslevelup");
			TweenLite.to(fillMask,.15,{scaleY: .00125, onComplete: bonusTweenUp});
		}
		
		private function bonusTweenUp():void {
			sndLevel += .05;
			SoundManager.instance.playSound("main_music", new SoundOptionsVO(sndLevel,-1,0,false,SoundOptionsVO.PLAYBACK_TYPE_RESTART));
			bonus_tf.text = String(1+int(bonus_tf.text));
			if (progressToAdd > 0) {
				TweenLite.to(fillMask,.15,{scaleY:(progressToAdd/4)});
			}
			currentBonusProgress = progressToAdd;
		}
	}
}