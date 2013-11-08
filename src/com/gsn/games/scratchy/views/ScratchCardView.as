package com.gsn.games.scratchy.views {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.gsn.games.scratchy.controllers.events.GameEvent;
	import com.gsn.games.scratchy.models.GameData;
	import com.gsn.games.shared.assetsmanagement.AssetManager;
	import com.gsn.games.shared.assetsmanagement.AssetVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	public class ScratchCardView extends Sprite {
		
		protected var scratchUIContainer:Sprite;
		protected var noTicketsPanel:Sprite;
		protected var tickets:Dictionary = new Dictionary();
		
		protected var tokensWon_tf:TextField;
		protected var ticketsLeft_tf:TextField;
		
		protected var showingSymbols:Array = [];
		protected var showingBonuses:Array = [];
		
		protected var ticketAsset:MovieClip;
		protected var iconsLoaded:Dictionary = new Dictionary();
		
		protected var lastScratched:String = "";
		
		protected var showNoTickets:Boolean = false;
		
		public function ScratchCardView() {
			super();
			initUI();
		}
		
		public function start(tickets:int):void {
			ticketsLeft_tf.text = String(tickets);
			tokensWon_tf.text = "0";
		}
		
		protected function initUI():void {
			AssetManager.instance.buildPanel("scratch_panel", onPanelBuilt);
			AssetManager.instance.buildPanel("notickets_panel",onNoTicketsLoaded);
			var assetNameV:Vector.<String> = new Vector.<String>();
			assetNameV.push(GameData.ICON_Cherry,GameData.ICON_7,GameData.ICON_Bell,GameData.ICON_Diamond,GameData.ICON_Ticket,GameData.ICON_Bonus);
			assetNameV.push("ANIM_ScratchingParticles","ANIM_Scratching");
			AssetManager.instance.bulkRequest(assetNameV,onAssets);
		}
		
		protected function onAssets(loadedAssetsV:Vector.<AssetVO>):void {
			for each (var vo:AssetVO in loadedAssetsV) {
				iconsLoaded[vo.name] = vo.asset as Sprite;
			}
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
						for (var i:int=0; i < 3; i++){
							var mc:MovieClip = ((tickets[instanceName] as MyActionButton).controlledMc.getChildByName("symbol_"+i) as MovieClip);
							mc.visible = false;
						}
						break;
				}
			}
		}
		
		protected function onNoTicketsLoaded(loadedAssetsV:Vector.<AssetVO>):void {
			for each (var vo:AssetVO in loadedAssetsV) {
				switch (vo.name) {
					case "PANEL_MoreTickets":
						noTicketsPanel = vo.asset as Sprite;
						break;
					case "BTN_buymore":
						var btn:MyActionButton = new MyActionButton(vo.asset as MovieClip);
						btn.addEventListener(MouseEvent.CLICK, onMoreTickets);
						break;
					case "BTN_results":
						var btn2:MyActionButton = new MyActionButton(vo.asset as MovieClip);
						btn2.addEventListener(MouseEvent.CLICK, onResults);
						break;
				}
			}
		}
		
		protected function onResults(e:MouseEvent):void {
			removeChild(noTicketsPanel);
			dispatchEvent(new GameEvent(GameEvent.END_GAME));
		}
		
		protected function onMoreTickets(e:MouseEvent):void {
			removeChild(noTicketsPanel);
			dispatchEvent(new GameEvent(GameEvent.TICKETS_ADDED));
		}
		
		public function onTicketsGone():void {
			showNoTickets = true;
			if (lastScratched == ""){
				//do the no ticket dialog
				addChild(noTicketsPanel);
				showNoTickets = false;
			}
		}
		
		protected function onScratch(event:MouseEvent):void {
			trace("[SCRATCH] ");
			//disable button
			var tgt:String = (event.target as DisplayObject).name;
			if ((tickets[tgt] as MyActionButton).enabled && lastScratched == ""){
				trace("Scratch!! "+tgt);
				lastScratched = tgt;
				dispatchEvent(new GameEvent(GameEvent.SCRATCH_TICKET));
				ticketsLeft_tf.text = String(Number(ticketsLeft_tf.text)-1);
				(tickets[tgt] as MyActionButton).enabled = false;
			}
		}
		
		public function addTickets(numTickets:int):void {
			var diff:Number = numTickets - Number(ticketsLeft_tf.text);
			ticketsLeft_tf.text = String(numTickets);
		}
		
		public function showScratchResult(icons:Array, winnings:Number, numBonuses:int):void {
			var total:Number = Number(tokensWon_tf.text)+ winnings;
			tokensWon_tf.text = String(total);
			
			trace("### tokens displayed so far: "+total);
			
			var ticket:MyActionButton = (tickets[lastScratched] as MyActionButton);
			for (var i:int=0; i < 3; i++){
				var mc:MovieClip = (ticket.controlledMc.getChildByName("symbol_"+i) as MovieClip);
				mc.visible = true;
				mc.alpha = 0;
				//add icon symbol
				var newClip:MovieClip = cloneObject(this.iconsLoaded[icons[i]]);
				mc.addChild(newClip);
				showingSymbols[i] = newClip;
				//add bonus symbol
				if (numBonuses > 0){
					var r:Number = Math.random()*icons.length-i;//max 3, max 2, max 1
					if (r < numBonuses){
						showingBonuses[i] = cloneObject(iconsLoaded[GameData.ICON_Bonus]);
						mc.addChild(showingBonuses[i]);
						numBonuses--;
					}
				}
				TweenMax.delayedCall(.2*i+.2,scratchTicketAnim,[mc])
			}
			
			TweenMax.delayedCall(1.2, showNewTicket);
		}
		
		protected function scratchTicketAnim(mc:MovieClip):void {
			TweenLite.to(mc,.2,{alpha:1});
		}
		
		protected function showNewTicket():void {
			trace("### show new ticket for "+lastScratched);
			TweenLite.to((tickets[lastScratched] as MyActionButton).controlledMc, .3, {alpha:0, onComplete:easeInTicket});
		}
		
		protected function easeInTicket():void {
			//todo: remove all "scratched effects"
			var ticket:MyActionButton = (tickets[lastScratched] as MyActionButton);
			for (var i:int=0; i < 3; i++){
				var mc:MovieClip = (ticket.controlledMc.getChildByName("symbol_"+i) as MovieClip);
				mc.visible = false;
				mc.removeChild(showingSymbols[i]);
				if (showingBonuses[i] != null){
					mc.removeChild(showingBonuses[i]);
					showingBonuses[i] = null;
				}
			}
			
			TweenLite.to((tickets[lastScratched] as MyActionButton).controlledMc, .3, {alpha:1});
			(tickets[lastScratched] as MyActionButton).enabled = true;
			lastScratched = "";
			if (showNoTickets){
				this.onTicketsGone();
			}
		}
		
		private function cloneObject(source:DisplayObject):MovieClip {
			var objectClass:Class = Object(source).constructor;
			var instance:MovieClip = new objectClass() as MovieClip;
			instance.transform = source.transform;
			instance.filters = source.filters;
			instance.cacheAsBitmap = source.cacheAsBitmap;
			instance.opaqueBackground = source.opaqueBackground;
			return instance;
		}
	}
}