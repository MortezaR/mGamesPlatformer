package  {
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.filesystem.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.net.dns.ARecord;
	import CollisionList;
	import CollisionGroup;
	import Player;
	import Platform;
	import enemy;
	import flash.geom.Point;
	import fl.controls.TextArea;
	public class Main extends MovieClip{
		var guy:Player = new Player();
		var AllP:Array = [];
		var Allleft:Array = [];
		var Allright:Array = [];
		var AllBP:Array = [];
		var AllC:Array = [];
		var AllendLvl:Array = [];
		var AllEnem:Array = [];
		var movinL:Boolean;
		var movinR:Boolean;
		var col = new CollisionList(guy);
		var colB = new CollisionList(guy);
		var colP = new CollisionList(guy);
		var colleft = new CollisionList(guy);
		var colright = new CollisionList(guy);
		var colEnem = new CollisionList(guy);
		var colendLvl = new CollisionList(guy);
		var right_arrow_btn:moveArrows = new moveArrows;
		var left_arrow_btn:moveArrows = new moveArrows;
		var down_arrow_btn:moveArrows = new moveArrows;
		var up_arrow_btn:moveArrows = new moveArrows;
		var mpON:Boolean = false;
		var leftTouch:Boolean = false;
		var rightTouch:Boolean = false;
		var weaponON:Boolean = true;
		var ecTxt:ECtxt = new ECtxt;
		var hpBar:HPbar;
		var spBar:SPbar = new SPbar;
		var menuBar:MENUbar = new MENUbar;
		var menu:menuScreen = new menuScreen;
		var menuON:Boolean = false;
		var gameON:Boolean = false;
		var topbar:Array = new Array;
		var playerHP:int = 0;
		var ECPoints:int = 0;
		var PHPoints:int = 0;
		var ANPoints:int = 0;
		var FIPoints:int = 0;
		var EDPoints:int = 0;
		var LEPoints:int = 0;
		var MainStat:String = "AN";
		var curWeapon:String = "AN";
		var sd:sword = new sword;
		var MainStatVal:int = 0;
		var curStage:int;
		var curLevel:int;
		public function Main() {
			
			addChild(guy);
			guy.x = 320;
			guy.y = 400;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			addEventListener(Event.ENTER_FRAME, check_hit);
			LOAD(1,1);
			curStage = 1;
			curLevel = 1;
			addTopbar();
			//addMovepad();
		}
		///////////////////////////////////////////////////////////////////////UI//////////////////////////////////////////////////////////////////////////////////////////
		function addTopbar(){
			hpBar = new HPbar(100);
			hpBar.setHealth(50);
			addChild(hpBar);
			addChild(ecTxt);
			addChild(spBar);
			addChild(menuBar);
			menuBar.addEventListener(MouseEvent.CLICK, this.open_menu);
			ecTxt.x = 150 + guy.x -320;
			ecTxt.y = 10;
			hpBar.x = 420 + guy.x -320;
			hpBar.y = 10;
			menuBar.x = 20 + guy.x -320;
			menuBar.y = 20;
			spBar.x = 300 + guy.x -320;
			spBar.y = 2;
			ecTxt.Ectxtbox.text = String(ECPoints);
			
			
			switch (MainStat){

				case "PH":
				spBar.gotoAndStop(1);
				break;
				
				case "AN":
				spBar.gotoAndStop(2);
				break;
				
				case "FI":
				spBar.gotoAndStop(3);
				break;
				
				case "ED":
				spBar.gotoAndStop(4);
				break;
				
				case "LE":
				spBar.gotoAndStop(5);
				break;
				
			}
			topbar = [ecTxt,hpBar,spBar,menuBar];
		}
		function removeTopbar(){
			removeChild(hpBar);
			removeChild(ecTxt);
			removeChild(spBar);
			removeChild(menuBar);
			menuBar.removeEventListener(MouseEvent.CLICK, this.open_menu);
			stage.focus
		}
		function open_menu(e:MouseEvent){
			if(guy.getyVel() == 0){
				menuBar.removeEventListener(MouseEvent.CLICK, this.open_menu);
				addChild(menu);
				menu.x = 100 + guy.x -320;
				menu.y = 100;
				menu.PHVAL.statVal.scaleX = PHPoints/1000;
				menu.ANVAL.statVal.scaleX = ANPoints/1000;
				menu.FIVAL.statVal.scaleX = FIPoints/1000;
				menu.EDVAL.statVal.scaleX = EDPoints/1000;
				menu.LEVAL.statVal.scaleX = LEPoints/1000;
				menu.VOLVAL.addEventListener(Event.ENTER_FRAME,this.changeVol);
				menu.backBttn.addEventListener(MouseEvent.CLICK, this.close_menu);
				menuON = true;
				movinL = false;
				movinR = false;
			}
		}
		function close_menu(e:MouseEvent){
			menuBar.addEventListener(MouseEvent.CLICK, this.open_menu);
			menu.VOLVAL.removeEventListener(Event.ENTER_FRAME,this.changeVol);
			menu.backBttn.removeEventListener(MouseEvent.CLICK, this.close_menu);
			removeChild(menu);
			menuON = false;
		}
		function changeVol(e:Event){
			trace(menu.VOLVAL.value);
		}
		function addMovepad() {
			addChild(right_arrow_btn);
			right_arrow_btn.y = 710;
			right_arrow_btn.x = 100 + guy.x -320;
			right_arrow_btn.rotation = 90;
			addChild(left_arrow_btn);
			left_arrow_btn.y = 710;
			left_arrow_btn.x = 100+ guy.x -320;
			left_arrow_btn.rotation = 270;
			addChild(down_arrow_btn);
			down_arrow_btn.y = 710;
			down_arrow_btn.x = 100+ guy.x -320;
			down_arrow_btn.rotation = 180;
			addChild(up_arrow_btn);
			up_arrow_btn.y = 700;
			up_arrow_btn.x = 100+ guy.x -320;
			
			right_arrow_btn.addEventListener(MouseEvent.MOUSE_DOWN, this.hit_right);
			left_arrow_btn.addEventListener(MouseEvent.MOUSE_DOWN, this.hit_left);
			down_arrow_btn.addEventListener(MouseEvent.MOUSE_DOWN, this.hit_down);
			up_arrow_btn.addEventListener(MouseEvent.CLICK, this.hit_up);
			right_arrow_btn.addEventListener(MouseEvent.MOUSE_UP, this.release_right);
			left_arrow_btn.addEventListener(MouseEvent.MOUSE_UP, this.release_left);
			/*down_arrow_btn.addEventListener(MouseEvent.MOUSE_UP, this.release_down);
			up_arrow_btn.addEventListener(MouseEvent.MOUSE_UP, this.release_up);*/
			mpON = true;
		}
		function deleteMovepad() {
			removeChild(right_arrow_btn);
			
			removeChild(left_arrow_btn);
			
			removeChild(down_arrow_btn);
			
			removeChild(up_arrow_btn);
		
			right_arrow_btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.hit_right);
			left_arrow_btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.hit_left);
			down_arrow_btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.hit_down);
			up_arrow_btn.removeEventListener(MouseEvent.CLICK, this.hit_up);
			right_arrow_btn.removeEventListener(MouseEvent.MOUSE_UP, this.release_right);
			left_arrow_btn.removeEventListener(MouseEvent.MOUSE_UP, this.release_left);
			/*down_arrow_btn.removeEventListener(MouseEvent.MOUSE_UP, this.release_down);
			up_arrow_btn.removeEventListener(MouseEvent.MOUSE_UP, this.release_up);*/
			mpON = false;
		}
		public function hit_right(event:MouseEvent){
			movinR = true;
		}
		public function hit_left(event:MouseEvent){
			movinL = true;
		}
		public function hit_down(event:MouseEvent){
		}
		public function hit_up(event:MouseEvent){
			guy.jump();
		}
		public function release_right(event:MouseEvent){
			movinR = false;
		}
		public function release_left(event:MouseEvent){
			movinL = false;
		}
		/*public function release_down(event:MouseEvent){
		}
		public function release_up(event:MouseEvent){
			guy.jump();
		}*/
		function addEC(i:int){
			ECPoints +=i;
			ecTxt.Ectxtbox.text = String(ECPoints);

		}
		function setEC(i:int){
			ECPoints =i;
			ecTxt.Ectxtbox.text = String(ECPoints);

		}
		function addHP(i:int){
			playerHP +=i;
			hpBar.setHealth(playerHP);
			if(playerHP <= 0){
				resetPlayer();
			}

		}
		function setHP(i:int){
			playerHP =i;
			hpBar.setHealth(playerHP);
			if(playerHP <= 0){
				resetPlayer();
			}

		}
		function addSP(i:int,l:String){
			switch (l){

				case "PH":
				PHPoints += i;
				if(PHPoints > MainStatVal){
					setMainStat("PH");
				}
				break;
				
				case "AN":
				ANPoints += i;
				if(ANPoints > MainStatVal){
					setMainStat("AN");
				}
				break;
				
				case "FI":
				FIPoints += i;
				if(FIPoints > MainStatVal){
					setMainStat("FI");
				}
				break;
				
				case "ED":
				EDPoints += i;
				if(EDPoints > MainStatVal){
					setMainStat("ED");
				}
				break;
				
				case "LE":
				LEPoints += i;
				if(LEPoints > MainStatVal){
					setMainStat("LE");
				}
				break;
				
			}

		}
		function setSP(i:int,l:String){
			switch (l){

				case "PH":
				PHPoints = i;
				if(PHPoints > MainStatVal){
					setMainStat("PH");
				}
				break;
				
				case "AN":
				ANPoints = i;
				if(ANPoints > MainStatVal){
					setMainStat("AN");
				}
				break;
				
				case "FI":
				FIPoints = i;
				if(FIPoints > MainStatVal){
					setMainStat("FI");
				}
				break;
				
				case "ED":
				EDPoints = i;
				if(EDPoints > MainStatVal){
					setMainStat("ED");
				}
				break;
				
				case "LE":
				LEPoints = i;
				if(LEPoints > MainStatVal){
					setMainStat("LE");
				}
				break;
				
			}

		}
		function setMainStat(l:String){
			switch (l){

				case "PH":
				MainStat = "PH";
				spBar.gotoAndStop(1);
				MainStatVal = PHPoints;
				break;
				
				case "AN":
				MainStat = "AN";
				spBar.gotoAndStop(2);
				MainStatVal = ANPoints;
				break;
				
				case "FI":
				MainStat = "FI";
				spBar.gotoAndStop(3);
				MainStatVal = FIPoints;
				break;
				
				case "ED":
				MainStat = "ED";
				spBar.gotoAndStop(4);
				MainStatVal = EDPoints;
				break;
				
				case "LE":
				MainStat = "LE";
				spBar.gotoAndStop(5);
				MainStatVal = LEPoints;
				break;
				
			}
		}
		function setWeapon(l:String){
			if(l == "tab"){
				if(curWeapon == "PH"){
					curWeapon = "AN";
				}
				if(curWeapon == "AN"){
					curWeapon = "FI";
				}
				if(curWeapon == "FI"){
					curWeapon = "ED";
				}
				if(curWeapon == "ED"){
					curWeapon = "LE";
				}
				if(curWeapon == "LE"){
					curWeapon = "PH";
				}
			}
			else{
				curWeapon = l;
			}
		}
		function useWeapon(){
			switch (curWeapon){
				case "PH":
				break;
				
				case "AN":
				addChild(sd);
				sd.x = guy.x
				sd.y = guy.y;
				break;
				
				case "FI":
				break;
				
				case "ED":
				break;
				
				case "LE":

				break;
				
			}
		}
		function resetPlayer(){
				removeEverything();
				LOAD(curStage,curLevel);
				this.x =0;
				this.y =0;
				addChild(guy);
				guy.x = 320;
				guy.y = 390;
				//removeTopbar();
				addTopbar();
				setHP(50);
				addEC(-300);
				if(mpON == true){
					//deleteMovepad()
					addMovepad();
				}
				movinL = false;
				movinR = false
		}
		
		function removeEverything(){
			while (this.numChildren > 0) {
   				this.removeChildAt(0);
			}
			/*if(mpON == true){
				deleteMovepad();
			}*/
		}
		function playEDgame(){
			
			gameON = true;
			var WB:whiteBG = new whiteBG;
			addChild(WB);
			WB.x = guy.x - 320;
			var roll:Film = new Film;
			addChild(roll);
			roll.x = 0;
			roll.y = 480;
			var makeS:Timer = new Timer(100,120);
			makeS.start();
			makeS.addEventListener(TimerEvent.TIMER, makeLine);
			makeS.addEventListener(TimerEvent.TIMER_COMPLETE,leave);
			addEventListener(Event.ENTER_FRAME, rollTape);
			function rollTape (e:Event){
				roll.x -= 10;
			}
			function makeLine(e:TimerEvent){
				function randomRange(minNum:Number, maxNum:Number):Number 
					{
						return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
					}
				if(makeS.currentCount > 9 && randomRange(1,100) < 20){
					var bm:beatMarker = new beatMarker;
					roll.addChild(bm);
					bm.x = -(roll.x )+ 640 ;
				}
			}
			function leave(e:TimerEvent){
				gameON = false;
				removeChild(WB);
				removeChild(roll);
				
				addSP(70,"ED");
				trace(MainStat);
			}
		}
		
		function check_hit (e:Event){
			if(col.checkCollisions()[0] != null){
				/*for(var i:int = 0; i < AllP.length; i++){
					if(guy.hitTestObject(AllP[i]) == true){
						guy.y = AllP[i].y;
					}
				}*/
				guy.hitPlatform();
			}
			else if(col.checkCollisions()[0] == null){
				guy.offPlatform();
			}
			if(colB.checkCollisions()[0] != null){
				guy.hitHead();
			}
			if(colleft.checkCollisions()[0] != null){
				rightTouch = true;
			}
			else{
				rightTouch = false;
			}
			if(colright.checkCollisions()[0] != null){
				leftTouch = true;
			}
			else{
				leftTouch = false;
			}
			if(col.checkCollisions()[0] != null){
				guy.hitPlatform();
			}
			if(colP.checkCollisions()[0] != null){
				for(var i:int = 0; i < AllC.length; i++){
					if(guy.hitTestObject(AllC[i]) == true){
						removeChild(AllC[i]);
						addEC(20);
						if(AllC[i].getyes()){
							playEDgame();
						}
					}
				}
			}
			if(colEnem.checkCollisions()[0] != null){
				for(var j:int = 0; j < AllEnem.length; j++){
					if(guy.hitTestObject(AllEnem[j]) == true){
						removeChild(AllEnem[j]);
						addHP(-50);
					}
				}
			}
			if(colendLvl.checkCollisions()[0] != null){
				var st:int;
				var lv:int;
				for(var i:int = 0; i < AllendLvl.length; i++){
					if(guy.hitTestObject(AllendLvl[i]) == true){
						st = AllendLvl[i].getPS();
						lv = AllendLvl[i].getLS();
					}
				}
				removeEverything();
				curStage = st;
				curLevel = lv;
				LOAD(st,lv);
				addChild(guy);
				this.x = 0;
				this.y = 0;
				guy.x = 320;
				guy.y = 390;
				addTopbar();
			}
			if(guy.y > 2000){
				resetPlayer();
			}
			if(movinL == true && movinR != true && rightTouch == false && menuON ==false && gameON ==false){
				guy.x -= 5;
				this.x +=5;
				right_arrow_btn.x -=5;
				left_arrow_btn.x -=5;
				down_arrow_btn.x -=5;
				up_arrow_btn.x -=5;
				for(var k:int = 0; k < topbar.length; k++){
					topbar[k].x -=5;
				}
			}
			if(movinR == true && movinL != true && leftTouch == false && menuON ==false && gameON ==false){
				guy.x +=5;
				this.x -=5
				right_arrow_btn.x +=5;
				left_arrow_btn.x +=5;
				down_arrow_btn.x +=5;
				up_arrow_btn.x +=5;
				for(var l:int = 0; l < topbar.length; l++){
					topbar[l].x +=5;
				}
			}
			if(weaponON == true){
				switch (curWeapon){
					case "PH":
					break;
				
					case "AN":
					sd.x = guy.x;
					sd.y = guy.y;
					break;
				
					case "FI":
					break;
				
					case "ED":
					break;
					
					case "LE":
					break;
				
				}
				/*for(var m:int = 0; m < AllEnem.length; m++){
					if(sd.hitTestObject(AllEnem[m])){
						AllEnem[m].takeDamage(50000);
					}
				}*/
			}
		}
		public function LOAD (curMap:int, curStage:int){
			var file:File = File.desktopDirectory;
			var input:String = new String;
			file = file.resolvePath("Senior Project/maps/MAP" + curMap + "_" + curStage +".txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			input = fileStream.readUTFBytes(fileStream.bytesAvailable);
			var a:Array = input.split(">>");
			fileStream.close();
			/*mapWidth = int(a[0]);
			mapHeight = int(a[1]);
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadimage);
			ldr.load(new URLRequest("stages/image" + curStage + "_" + curMap +".png"));
			function loadimage(evt:Event):void {
				var bmp:Bitmap = ldr.content as Bitmap;
				addChildAt(bmp, 0);
				bmp.height = mapHeight;
				bmp.width = mapWidth;
			}*/
			var b:Array = a[2].split("\n");
			for (var i:String in b){
				var c:Array = b[i].split(" ");
				/*if(c[0] == "aSwitch"){
					aSwi = new aSwitch();
					aSwi.name = c[3];
					this.addObj(aSwi);
					aSwi.x = c[1];
					aSwi.y = c[2];
					if(c[4] == "true"){
						aSwi.turnON();
					}
				}*/
				if(c[0] == "endLvl"){
					var gate:endLvl = new endLvl(c[4],c[5]);
					colendLvl.addItem(gate);
					AllendLvl.push(gate);
					addChild(gate);
					gate.x = c[1];
					gate.y = c[2];
				}
				if(c[0] == "collectable"){
					var eatable:collectable = new collectable();
					eatable.name = c[3];
					colP.addItem(eatable);
					AllC.push(eatable);
					addChild(eatable);
					eatable.x = c[1];
					eatable.y = c[2];
					
				}
				if(c[0] == "Scollectable"){
					var eatable:collectable = new collectable();
					eatable.name = c[3];
					colP.addItem(eatable);
					AllC.push(eatable);
					addChild(eatable);
					eatable.x = c[1];
					eatable.y = c[2];
					eatable.height /= 2;
					eatable.width *= 2;
					eatable.yes();
					
				}
				if(c[0] == "enemy"){
					var p:Array = [];
					p.push(new Point(c[1],c[2]));
					p.push(new Point(c[6],c[7]));
					p.push(new Point(c[8],c[9]));
					var emy:enemy = new enemy(c[4],c[5],p);
					emy.name = c[3];
					addChild(emy);
					AllEnem.push(emy);
					colEnem.addItem(emy);
					emy.x = c[1];
					emy.y = c[2];
				}
				if(c[0] == "Platform"){
					var plat:Platform = new Platform(c[4],c[5]);
					plat.name = c[3];
					col.addItem(plat);
					AllP.push(plat);
					addChild(plat);
					plat.x = c[1];
					plat.y = c[2];
				}
				if(c[0] == "botPlatform"){
					var platT:Platform = new Platform(c[4],c[5]);
					var botPlat:Platform = new Platform(c[4],c[5]);
					platT.name = c[3];
					col.addItem(platT);
					colB.addItem(botPlat);
					AllP.push(platT);
					AllBP.push(botPlat);
					addChild(platT);
					addChild(botPlat);
					platT.x = c[1];
					platT.y = c[2];
					botPlat.x = c[1];
					botPlat.y = int(c[2]) + 15;
					botPlat.setBottom(true);
				}
				if(c[0] == "rightPlatform"){
					var rightplat:Platform = new Platform(c[4],c[5]);
					rightplat.name = c[3];
					colright.addItem(rightplat);
					Allright.push(rightplat);
					addChild(rightplat);
					rightplat.x = c[1];
					rightplat.y = c[2];
				}
				if(c[0] == "leftPlatform"){
					var leftplat:Platform = new Platform(c[4],c[5]);
					leftplat.name = c[3];
					colleft.addItem(leftplat);
					Allleft.push(leftplat);
					addChild(leftplat);
					leftplat.x = c[1];
					leftplat.y = c[2];
				}
				/*if(c[0] == "NPC"){
					aNPC = new NPC(c[4]);
					aNPC.name = c[3];
					this.addObj(aNPC);
					aNPC.x = c[1];
					aNPC.y = c[2];
				}*/
			}
			/*var d:Array = a[3].split("\n");
			for (var i:String in d){
				listDia[i] = d[i];
			}*/
			/*var e:Array = a[4].split("\n");
			for(var i:String in e)
				*/
		}
		function addblock (xcord:int,ycord:int,len:int,wid:int){
			var block:Platform = new Platform(len,wid);
			addChild(block);
			block.x = xcord;
			block.y = ycord;
			col.addItem(block);
			AllP.push(block);
			
		}
		function KeyDown (e:KeyboardEvent){
			if(menuON ==false){
				if(e.charCode == 97){
					//a
					movinL = true;
				}
				if(e.charCode == 100){
					//d
					movinR = true;
				}
				if(e.charCode ==  119){
					//w
					guy.jump();
				}
				/*if(e.charCode == 32){
					//useWeapon();
					playEDgame();
				}*/
				/*if(e.charCode == 83){
					//s
					movinD = true;
				}*/
			}
		}
		function KeyUp (e:KeyboardEvent){
			if(menuON == false){
				if(e.charCode == 97){
					//a
					movinL = false;
				}
				if(e.charCode == 100){
					//d
					movinR = false;
				}
				/*if(e.charCode ==  87){
					//w
					movinU = false;
				}
				if(e.charCode == 83){
					//s
					movinD = false;
				}*/
			}
		}
	}
	
}
