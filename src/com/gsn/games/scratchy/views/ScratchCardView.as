package com.gsn.games.scratchy.views {
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.shared.assetsmanagement.AssetManager;
	import com.gsn.games.shared.assetsmanagement.AssetVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class ScratchCardView extends Sprite {
		
		protected var scratchUIContainer:Sprite;
		protected var tickets:Dictionary = new Dictionary();
		
		protected var ticketAsset:MovieClip;
		
		public function ScratchCardView() {
			super();
			initUI();
		}
		
		protected function initUI():void {
			AssetManager.instance.buildPanel("scratch_panel", onPanelBuilt);
		}
		
		protected function onPanelBuilt(loadedAssetsV:Vector.<AssetVO>):void {
			for each (var vo:AssetVO in loadedAssetsV) {
				
				switch (vo.name) {
					case "PANEL_Scratch":
						scratchUIContainer = vo.asset as Sprite;
						addChild(scratchUIContainer);
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
				trace("Scratch works!!");
				dispatchEvent(new GameEvent(GameEvent.SCRATCH_TICKET));
			}
			(tickets[tgt] as MyActionButton).enabled = false;
		}
		
		public function showScratchResult(icons:Array, winnings:Number, numBonuses:int):void {
			
		}
	}
}