package com.gsn.games.scratchy.models {
	import flash.utils.Dictionary;

	public class GameData {
		public function GameData() { }
		
		//icons
		public static const ICON_Bonus:String = "GFX_bonus_stickers";
		
		public static const ICON_7:String = "GFX_7";
		public static const ICON_Bell:String = "GFX_Bell";
		public static const ICON_Cherry:String =  "GFX_cherry";
		public static const ICON_Diamond:String = "GFX_diamond";
		public static const ICON_Ticket:String = "GFX_ticket";
		
		private static var _PAYOUTS:Dictionary;
		public static function get PAYOUTS():Dictionary {
			if (_PAYOUTS == null){
				_PAYOUTS = new Dictionary();
				//bell, cherry, diamond, seven, ticket
				_PAYOUTS[ICON_Cherry] = [0,2,4];
				_PAYOUTS[ICON_Bell] = [0,4,8];
				_PAYOUTS[ICON_Diamond] = [0,10,25];
				_PAYOUTS[ICON_7] = [0,25,100];
				_PAYOUTS[ICON_Ticket] = [1,2,10];
			}
			return _PAYOUTS;
		}
		
		public static const OUTCOMES:Array = [
				[ICON_Diamond, ICON_7, ICON_Bell],
				[ ICON_Cherry, ICON_Cherry, ICON_Cherry],//3 cherries
				[ ICON_Cherry, ICON_Cherry, ICON_Cherry],
				[ ICON_Cherry, ICON_Cherry, ICON_Cherry],
				[ ICON_Cherry, ICON_Cherry, ICON_Cherry],
				[ ICON_Cherry, ICON_Cherry, ICON_Cherry],
				[ICON_Bell,ICON_Bell,ICON_Bell],//bells
				[ICON_Bell,ICON_Bell,ICON_Bell],
				[ICON_Bell,ICON_Bell,ICON_Bell],
				[ICON_Diamond,ICON_Diamond,ICON_Diamond],//diamonds
				[ICON_Diamond,ICON_Diamond,ICON_Diamond],
				[ICON_7, ICON_7, ICON_7],//7-7-7
				[ICON_Cherry, ICON_Ticket, ICON_Bell],//tickets
				[ICON_Cherry, ICON_Ticket, ICON_Diamond],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],//two cherries
				[ICON_Cherry, ICON_7, ICON_Cherry],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],
				[ICON_7, ICON_Cherry, ICON_Cherry],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],
				[ICON_Cherry, ICON_Diamond, ICON_Cherry],
				[ICON_7, ICON_7, ICON_Cherry],//two 7s
				[ICON_7, ICON_Bell, ICON_7],
				[ICON_Diamond,ICON_Bell,ICON_Bell],//two bells
				[ICON_Bell, ICON_7, ICON_Bell],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Cherry, ICON_7, ICON_Bell],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Bell, ICON_Diamond, ICON_Cherry],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Bell, ICON_7, ICON_Cherry],
				[ICON_Bell, ICON_7, ICON_Diamond],
				[ICON_Diamond, ICON_7, ICON_Cherry]
			];
	}
}