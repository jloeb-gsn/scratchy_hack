package com.gsn.games.scratchy.views {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class ResultsView extends Sprite {
		
		protected var m_sprite:Sprite;
		protected var tf_tickets:TextField;
		protected var tf_bet:TextField;
		protected var tf_won:TextField;
		
		public function ResultsView(panel:Sprite, ticket:TextField, bet:TextField, won:TextField) {
			m_sprite = panel;
			tf_tickets = ticket;
			tf_bet = bet;
			tf_won = won;
			super();
		}
		
		public function showResults(tickets:int, bet:int, winnings:int):void {
			addChild(m_sprite);
			tf_tickets.text = String(tickets);
			tf_bet.text = String(bet);
			tf_won.text = String(winnings);
		}
	}
}