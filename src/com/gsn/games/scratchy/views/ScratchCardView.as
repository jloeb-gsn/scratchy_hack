package com.gsn.games.scratchy.views {
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.shared.assetsmanagement.AssetManager;
	import com.gsn.games.shared.assetsmanagement.AssetVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	public class ScratchCardView extends Sprite {
		
		protected var scratchUIContainer:Sprite;
		protected var tickets:Dictionary = new Dictionary();
		
		protected var tokensWon_tf:TextField;
		protected var ticketsLeft_tf:TextField;
		
		protected var ticketAsset:MovieClip;
		
		public function ScratchCardView() {
			super();
			initUI();
		}
		
		protected function initUI():void {
			AssetManager.instance.buildPanel("scratch_panel", onPanelBuilt);
		}
		
		public function start(tickets:int):void {
			ticketsLeft_tf.text = String(tickets);
			tokensWon_tf.text = "0";
		}
		
		protected function onPanelBuilt(loadedAssetsV:Vector.<AssetVO>):void {
			for each (var vo:AssetVO in loadedAssetsV) {
				
				switch (vo.name) {
					case "PANEL_Scratch":
						scratchUIContainer = vo.asset as Sprite;
						addChild(scratchUIContainer);
						
						tokensWon_tf = scratchUIContainer.getChildByName("TF_tokenswon") as TextField;
						ticketsLeft_tf = scratchUIContainer.getChildByName("TF_ticketsleft") as TextField;
						// txtOutput = pnlMain.getChildByName("PROP_Output") as TextField;
						break;
					case "BTN_Ticket":
						//ticket_0 ... ticket_5
						ticketAsset = vo.asset as MovieClip
						var instanceName:String = vo.instanceName;
						tickets[instanceName] = new MyActionButton(vo.asset as MovieClip);
						(tickets[instanceName] as MyActionButton).addEventListener(MouseEvent.CLICK, onScratch);
						break;
					
				}
			}
		}
		
		protected function onScratch(event:MouseEvent):void {
			trace("[SCRATCH] ");
			//disable button
			var tgt:String = (event.target as DisplayObject).name;
			if ((tickets[tgt] as MyActionButton).enabled){
				trace("Scratch!!");
				dispatchEvent(new GameEvent(GameEvent.SCRATCH_TICKET));
			}
			ticketsLeft_tf.text = String(Number(ticketsLeft_tf.text)-1);
			(tickets[tgt] as MyActionButton).enabled = false;
		}
		
		public function showScratchResult(icons:Array, winnings:Number, numBonuses:int):void {
			var total:Number = Number(tokensWon_tf.text)+ winnings;
			tokensWon_tf.text = String(total);
			trace("### tokens displayed so far: "+total);
		}
	}
}