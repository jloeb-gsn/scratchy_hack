package com.gsn.games.scratchy.views {
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.models.GameModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BonusPanelMediator extends Mediator {
		
		[Inject]
		public var model:GameModel;
		[Inject]
		public var view:BonusPanelView;
		
		public function BonusPanelMediator() {
			super();
		}
		
		override public function onRegister():void {
			addContextListener(GameEvent.BONUS_ADDED,onBonusIncrease);
			super.onRegister();
		}
		
		override public function onRemove():void {
			super.onRemove();
		}
		
		protected function onBonusIncrease(e:GameEvent):void {
			view.addBonusStickers(model.bonusPoints);
		}
	}
}