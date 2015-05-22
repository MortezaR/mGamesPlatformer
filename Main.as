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
	import flash.display.BitmapData;
	import flash.display.Shape;
	import CollisionList;
	import CollisionGroup;
	import Player;
	import Platform;
	import enemy;
	import flash.geom.Point;
	import fl.controls.TextArea;
	public class Main extends MovieClip{
		var guy:Player = new Player();
		var guyImage:playerSprites = new playerSprites;
		var AllP:Array = [];
		var Allleft:Array = [];
		var Allright:Array = [];
		var Allspecial:Array = [];
		var AllBP:Array = [];
		var AllC:Array = [];
		var AllendLvl:Array = [];
		var AllEnem:Array = [];
		var AllEffects:Array = [];
		var movinL:Boolean;
		var movinR:Boolean;
		var col = new CollisionList(guy);
		var colB = new CollisionList(guy);
		var colP = new CollisionList(guyImage);
		var colleft = new CollisionList(guy);
		var colright = new CollisionList(guy);
		var colspecial = new CollisionList(guy);
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
		var isInvin:Boolean = false;
		var ecTxt:ECtxt = new ECtxt;
		var hpBar:HPbar;
		var spBar:SPbar = new SPbar;
		var menuBar:MENUbar = new MENUbar;
		var menu:menuScreen = new menuScreen;
		var cd:countdown = new countdown;
		var menuON:Boolean = false;
		var gameON:Boolean = false;
		var topbar:Array = new Array;
		var playerHP:int = 100;
		var ECPoints:int = 0;
		var PHPoints:int = 0;
		var ANPoints:int = 0;
		var FIPoints:int = 0;
		var EDPoints:int = 0;
		var LEPoints:int = 0;
		var MainStat:String = "ED";
		var curWeapon:String = "ED";
		var sd:sword = new sword;
		var MainStatVal:int = 0;
		var curStage:int;
		var curLevel:int;
		public function Main() {
			
			addChild(guy);
			addChild(guyImage);
			guyImage.gotoAndStop(2);
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
			hpBar.setHealth(playerHP);
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
			stage.focus = guy;
			stage.focus = stage;
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
			if(menuON ==false && gameON ==false){
				guy.jump();
			}
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
			if(curLevel == 10 && playerHP <= 0){
					guy.x = 110;
					guy.y = -990;
					addEC(-300);
			}else if(playerHP <= 0){
				resetPlayer();
			}

		}
		function setHP(i:int){
			playerHP =i;
			hpBar.setHealth(playerHP);
			if(curLevel == 10 && playerHP <= 0){
					guy.x = 110;
					guy.y = -990;
					addEC(-300);
			}else if(playerHP <= 0){
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
				/*if(LEPoints > MainStatVal){
					setMainStat("LE");
				}*/
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
				/*if(LEPoints > MainStatVal){
					setMainStat("LE");
				}*/
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
				addChild(sd);
				sd.x = guy.x
				sd.y = guy.y;
				break;
				
				case "LE":

				break;
				
			}
		}
		function resetPlayer(){
/*				removeEverything();
				LOAD(curStage,curLevel);*/
				this.x =0;
				this.y =0;
				guy.x = 320;
				guy.y = 390;
				removeTopbar();
				addTopbar();
				setHP(100);
				addEC(-300);
				if(mpON == true){
					deleteMovepad()
					addMovepad();
				}
				movinL = false;
				movinR = false
		}
		
		function removeEverything(){
			while (this.numChildren > 0) {
   				this.removeChildAt(0);
			}
		}
		function playEDgame(){
			gameON = true;
			var gameScore:int = 0;
			var WB:whiteBG = new whiteBG;
			addChild(WB);
			WB.score.gotoAndStop(1);
			WB.x = guy.x - 320;
			var roll:Film = new Film;
			addChild(roll);
			var hitValue:Boolean = false;
			roll.x = guy.x -320;
			roll.y = 480;
			var makeS:Timer = new Timer(1000,30);
			makeS.start();
			makeS.addEventListener(TimerEvent.TIMER, nextBeat);
			makeS.addEventListener(TimerEvent.TIMER_COMPLETE,leave);
			addEventListener(MouseEvent.CLICK,Check);
			addEventListener(Event.ENTER_FRAME, rollTape);
			var markers:Array = new Array(210);
			var curNum:Number = 0;
			function rollTape (e:Event){
				roll.x -= 2 +curStage*2;
				if(roll.x < -500 +guy.x -320){
					roll.x = guy.x -320;;
				}
				for(var i:int; i <markers.length; i++){
					markers[i].x -= 2 +curStage*2;
				}
				if(markers[curNum].x - guy.x + 320<= 150){
					if(hitValue == false && !(markers[curNum] is fakeBeat)){
						markers[curNum].gotoAndStop(5);
					}
					hitValue = false;
					curNum++;
				}
			}
			function randomRange(minNum:Number, maxNum:Number):Number 
			{
				return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			}
			for(var i:int; i <markers.length; i++){
				if(randomRange(0,3) <= 1){
					var b:beatMarker = new beatMarker;
					markers[i] = b;
					addChild(b);
					b.y = 480;
					b.x = 400 + guy.x - 320 + i*100;
				}else{
					var f:fakeBeat = new fakeBeat;
					markers[i] = f;
					addChild(f);
					f.y = 480;
					f.x = 400 + guy.x - 320 + i*100;
				}
			}
			function nextBeat(e:TimerEvent){
				if(makeS.currentCount > 23){
					switch(makeS.currentCount){
						case 25:
						addChild(cd);
						cd.x =100 + guy.x - 320;
						cd.y =100 + guy.x - 320;
						cd.gotoAndStop(1);
						break;
						case 26:
						cd.gotoAndStop(2);
						break;
						case 27:
						cd.gotoAndStop(3);
						break;
						case 28:
						cd.gotoAndStop(4);
						break;
						case 29:
						cd.gotoAndStop(5);
						break;
						case 30:
						removeChild(cd);
						break;
					}
				}
			}
			function Check(e:MouseEvent){
				if (!(markers[curNum] is fakeBeat) && hitValue == false){
					//trace(markers[curNum].x - guy.x + 320 - 200);
					switch (true){
						case (markers[curNum].x - guy.x + 320 - 200 >= -8 && markers[curNum].x - guy.x + 320 - 200 <= 8):
						//trace("great")
						gameScore += 100 * curStage;
						markers[curNum].gotoAndStop(2);
						hitValue = true;
						break;
						case (markers[curNum].x - guy.x + 320 - 200 >= -16 && markers[curNum].x - guy.x + 320 - 200 <= 16):
						//trace("good")
						gameScore += 10 * curStage;
						markers[curNum].gotoAndStop(3);
						hitValue = true;
						break;
						
						case (markers[curNum].x - guy.x + 320 - 200 >= -40 && markers[curNum].x - guy.x + 320 - 200 <= 40):
						//trace("almost")
						gameScore += 1 * curStage;
						markers[curNum].gotoAndStop(4);
						hitValue = true;
						break;
					
						case (markers[curNum].x - guy.x + 320 - 200 >= -100 && markers[curNum].x - guy.x + 320 - 200 <= 100):
						//trace("so bad")
						break;
					
					}
					var frame:int = gameScore /25;
					if(frame > 190){
						frame = 190;
					}
					WB.score.gotoAndStop(frame +10);
				}
			}
			function leave(e:TimerEvent){
				gameON = false;
				removeChild(WB);
				removeChild(roll);
				makeS.removeEventListener(TimerEvent.TIMER, nextBeat);
				makeS.removeEventListener(TimerEvent.TIMER_COMPLETE,leave);
				removeEventListener(MouseEvent.CLICK,Check);
				removeEventListener(Event.ENTER_FRAME, rollTape);
				for(var i:int; i <markers.length; i++){
					removeChild(markers[i]);
				}
				
				addSP(30 + gameScore * .01,"ED");
				//addEC(gameScore *.1);
			}
		}
		function playLEgame(ans:int,choices:Array, xCor:int,yCor:int){
			gameON = true;
			var cury:int = guy.y;
			var b1:lButton = new lButton;
			var b2:lButton = new lButton;
			var b3:lButton = new lButton;
			var b4:TextArea = new TextArea;
			addChild(b1);
			addChild(b2);
			addChild(b3);
			addChild(b4);
			
			b1.x = 20 + guy.x - 320;
			b1.y = 760;
			b1.height =  170;
			b1.width = 190;
			b2.x = 230 + guy.x - 320;
			b2.y = 760;
			b2.height = 170; 
			b2.width = 190;
			b3.x = 430 + guy.x - 320;
			b3.y = 760;
			b3.height = 170;
			b3.width = 190;
			b4.x = 70 + guy.x - 320;
			b4.y = 140;
			b4.height = 425;
			b4.width = 500;
			b4.editable = false;
			//addEventListener(MouseEvent.CLICK,checkc1);
			var c1:String = choices[0];
			c1 = strReplace(c1, "_" , " ");
			var c2:String = choices[1];
			c2 = strReplace(c2, "_" , " ");
			var c3:String = choices[2];
			c3 = strReplace(c3, "_" , " ");
			var c4:String = choices[3];
			c4 = strReplace(c4, "_" , " ");
			b1.btntxt.text = c1;
			b2.btntxt.text = c2;
			b3.btntxt.text = c3;
			b4.text = c4;
			trace(c1, c2, c3, c4);
			b1.addEventListener(MouseEvent.CLICK,checkc1);
			b2.addEventListener(MouseEvent.CLICK,checkc2);
			b3.addEventListener(MouseEvent.CLICK,checkc3);
			function strReplace(str:String, search:String, replace:String):String {
				return str.split(search).join(replace);
			}
			function checkc1(e:MouseEvent){
				if(ans == 1){
					kleave(3);
				}else if (ans == 2){
					kleave(2);
				}else if (ans == 3){
					kleave(1);
				}
			}
			function checkc2(e:MouseEvent){
				if(ans == 2){
					kleave(3);
				}else if (ans == 3){
					kleave(2);
				}else if (ans == 1){
					kleave(1);
				}
			}
			function checkc3(e:MouseEvent){
				if(ans == 3){
					kleave(3);
				}else if (ans == 1){
					kleave(2);
				}else if (ans == 2){
					kleave(1);
				}
			}
			function kleave(score:int){
				switch(score){
					case 1:
					b4.text = "Rethink your life decisions. Here is a free time machine for the cost of 300 Extra Credit Points"
					break;
					case 2:
					b4.text = "Could of made a better choice, but hey, it's passable"
					break;
					case 3:
					b4.text = "That's about right"
					break;
				}
				var u:Timer = new Timer(3000);
				u.start();
				b1.removeEventListener(MouseEvent.CLICK,checkc1);
				b2.removeEventListener(MouseEvent.CLICK,checkc2);
				b3.removeEventListener(MouseEvent.CLICK,checkc3);
				u.addEventListener(TimerEvent.TIMER,go);
				guy.y -= 10000;
				function go(e:TimerEvent){
					leave(score);
					u.removeEventListener(TimerEvent.TIMER,go);
				}
			}
			function leave(score:int){
				gameON = false;
				removeChild(b1);
				removeChild(b2);
				removeChild(b3);
				removeChild(b4);
				switch(score){
					case 1:
					setHP(0);
					var eatable:collectable = new collectable();
					colP.addItem(eatable);
					AllC.push(eatable);
					addChild(eatable);
					eatable.x = xCor;
					eatable.y = yCor;
					eatable.gotoAndStop(2);
					eatable.setLE(true , ans , choices);
					break;
					
					case 2:
					addSP(50,"LE");
					guy.y = cury;
					break;
					
					case 3:
					addSP(50,"LE");
					addEC(500);
					guy.y = cury;
					break;
				}
				stage.focus = guy;
				stage.focus = stage;
			}
			
		}
		function check_hit (e:Event){
			for(var i:int =0; i<AllEffects.length; i++){
				if(guy.hitTestObject(AllEffects[i])){
					AllEffects[i].play();
					AllEffects.splice([i],1);
				}
			}
			if(col.checkCollisions()[0] != null){
				for(var i:int = 0; i < AllP.length; i++){
					if(guy.hitTestObject(AllP[i]) == true){
						guy.y = AllP[i].y +1;
					}
				}
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
			if(colspecial.checkCollisions()[0] != null){
				for(var i:int = 0; i < Allspecial.length; i++){
					if(guy.hitTestObject(Allspecial[i]) == true){
						if(Allspecial[i].getCV() > LEPoints){
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
					}
				}
			}
			if(col.checkCollisions()[0] != null){
				guy.hitPlatform();
			}
			if(colP.checkCollisions()[0] != null){
				for(var i:int = 0; i < AllC.length; i++){
					if(guyImage.hitTestObject(AllC[i]) == true){
						removeChild(AllC[i]);
						addEC(AllC[i].getVal());
						if(AllC[i].getED()){
							playEDgame();
						}
						if(AllC[i].getLE()){
							//trace(AllC[i].getLeAns,AllC[i].getLeArray);
							playLEgame(AllC[i].getLeAns(),AllC[i].getLeArray(), AllC[i].x,AllC[i].y);
						}
					}
				}
			}
			if(colEnem.checkCollisions()[0] != null && isInvin == false){
				for(var j:int = 0; j < AllEnem.length; j++){
					if(guy.hitTestObject(AllEnem[j]) == true){
						//removeChild(AllEnem[j]);
						addHP(-25);
						invin(1000);
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
				trace(st,lv);
				LOAD(st,lv);
				addChild(guy);
				addChild(guyImage);
				this.x = 0;
				this.y = 0;
				guy.x = 320;
				guy.y = 390;
				addTopbar();
				setHP(100);
				if(curLevel == 10){
					finalboss();
				}
			}
			if(guy.y > 1300){
				addHP(-100);
			}
			if(movinL == true && movinR != true && rightTouch == false && menuON ==false && gameON ==false){
				guy.x -= 5;
				if(guy.getPlatform() && isInvin == false){
					guyImage.gotoAndStop(3);
				}else if(isInvin == false){
					guyImage.gotoAndStop(6);
				}
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
				if(guy.getPlatform() && isInvin == false){
					guyImage.gotoAndStop(4);
				}else if(isInvin == false){
					guyImage.gotoAndStop(5);
				}
				this.x -=5
				right_arrow_btn.x +=5;
				left_arrow_btn.x +=5;
				down_arrow_btn.x +=5;
				up_arrow_btn.x +=5;
				for(var l:int = 0; l < topbar.length; l++){
					topbar[l].x +=5;
				}
			}
			if((movinR == false && movinL == false && isInvin == false) || menuON ==true || gameON ==true){
				guyImage.gotoAndStop(2);
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
			guyImage.x = guy.x;
			guyImage.y = guy.y;
		}
		public function invin(LENGTH:int){
			isInvin = true;
			guyImage.gotoAndStop(8);
			var T:Timer = new Timer(LENGTH,1);
			T.start();
			T.addEventListener(TimerEvent.TIMER_COMPLETE,stopinvin);
			function stopinvin(e:TimerEvent){
				isInvin = false;
				guy.gotoAndStop(1);
				T.removeEventListener(TimerEvent.TIMER_COMPLETE,stopinvin);
			}
		}
		function finalboss () {
			var take:essay = new essay;
			var give:turnitin = new turnitin;
			var gameinfo:TextArea = new TextArea;
			var hasEssay:Boolean = new Boolean;
			var friendHP:Number = 100*curStage;
			var friendFace:FFACE = new FFACE;
			var colNUKES:CollisionList = new CollisionList(guy);
			var AllNUKES:Array = [];
			addChild(take);
			addChild(give);
			addChild(gameinfo);
			addChild(friendFace);
			take.x = -270;
			take.y = 600;
			give.x = 875;
			give.y = 580;
			friendFace.x = 480;
			friendFace.y = 710;
			friendFace.gotoAndStop(30);
			//gameinfo.x = 490;
			gameinfo.y = 800;
			gameinfo.height = 120;
			gameinfo.width = 300;
			gameinfo.editable = false;
			gameinfo.text = "Get the essay and just turn it in before you run out of time";
			var nukeTime:Timer = new Timer(2000);
			nukeTime.start();
			var turnInTime:Timer = new Timer(30000 - 1000*curStage);
			turnInTime.start();
			turnInTime.addEventListener(TimerEvent.TIMER,failEssay);
			nukeTime.addEventListener(TimerEvent.TIMER,getinhere);
			var Qdelay:Timer = new Timer(5000);
			Qdelay.addEventListener(TimerEvent.TIMER, leave);
			function failEssay(e:TimerEvent){
				if(hasEssay){
					hasEssay = false;
					addChild(take);
					take.x = -270;
					take.y = 600;
					gameinfo.text = "You didn't turn in the essay on time";
				}
				addHP(-10 - curStage*5);
			}
			function getinhere(e:TimerEvent){
				if(randomRange(0,7 - curStage) <= 2){
					var NUKE:PopQuiz = new PopQuiz;
					addChild(NUKE);
					NUKE.x = guy.x;
					NUKE.y = -60;
					colNUKES.addItem(NUKE);
					AllNUKES.push(NUKE);
				}
				   
			}
			function randomRange(minNum:Number, maxNum:Number):Number 
			{
				return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			}
			addEventListener(Event.ENTER_FRAME, checkGoals);
			function checkGoals(e:Event){
				if(curLevel !=10){
					removeEventListener(Event.ENTER_FRAME, checkGoals)
					turnInTime.stop();
					turnInTime.removeEventListener(TimerEvent.TIMER,failEssay);
					nukeTime.removeEventListener(TimerEvent.TIMER,getinhere);
					nukeTime.stop();
					Qdelay.stop();
					Qdelay.removeEventListener(TimerEvent.TIMER, leave);
				}
				gameinfo.x = guy.x - 300;
				friendFace.x = guy.x + 160;
				if(guyImage.hitTestObject(take)){
					hasEssay = true;
					removeChild(take);
					turnInTime.reset();
					turnInTime.start();
					gameinfo.text = "You picked up the essay";
				}
				if(guyImage.hitTestObject(give)){
					if(hasEssay){
						hasEssay = false;
						addChild(take);
						take.x = -270;
						take.y = 600;
						turnInTime.reset();
						turnInTime.start();
						gameinfo.text = "Nice job, I guess";
						friendHP -= 10 + EDPoints*.1; 
						friendFace.gotoAndStop(int((friendHP/(100*curStage))* 30));
						if(friendHP <= 0) {
							gameON = true;
							guyImage.gotoAndStop(7);
							Qdelay.start();
							invin(5000);
							
						}
					}
				}
				for(var i:int =0; i< AllNUKES.length; i++){
					AllNUKES[i].y += 15;
					/*if(AllNUKES[i].y > 2000){
						removeChild(AllNUKES[i])
					}*/
				}
				if(colNUKES.checkCollisions()[0] != null){
					if(isInvin == false){
						addHP(-10 - curStage *3);
						invin(1000);
					}
				}
			}
			function leave(e:TimerEvent){
				guy.x = -100;
				guy.y = -1000;
				gameON = false;
				removeEventListener(Event.ENTER_FRAME, checkGoals)
				turnInTime.stop();
				turnInTime.removeEventListener(TimerEvent.TIMER,failEssay);
				nukeTime.removeEventListener(TimerEvent.TIMER,getinhere);
				nukeTime.stop();
				Qdelay.stop();
				Qdelay.removeEventListener(TimerEvent.TIMER, leave);
			}
		}
		public function LOAD (curMap:int, CStage:int){
			var file:File = File.desktopDirectory;
			var input:String = new String;
			file = file.resolvePath("SeniorProject/maps/MAP" + curMap + "_" + CStage +".txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			input = fileStream.readUTFBytes(fileStream.bytesAvailable);
			var a:Array = input.split(">>");
			fileStream.close();
			/*mapWidth = int(a[0]);
			mapHeight = int(a[1]);*/
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadimage);
			ldr.load(new URLRequest("maps/MAP" + curMap + "_" + CStage +".png"));
			function loadimage(evt:Event):void {
				var bmp:Bitmap = ldr.content as Bitmap;
				addChildAt(bmp, 0);
				bmp.x = int(a[0]);
				bmp.y = int(a[1]);
			}
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
					gate.name = c[3];
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
					eatable.setVal(c[4]);
					
				}
				if(c[0] == "Scollectable"){
					var eatable:collectable = new collectable();
					eatable.name = c[3];
					colP.addItem(eatable);
					AllC.push(eatable);
					addChild(eatable);
					eatable.x = c[1];
					eatable.y = c[2];
					eatable.setED(true);
					eatable.gotoAndStop(3);
					
				}
				if(c[0] == "Lcollectable"){
					var eatable:collectable = new collectable();
					eatable.name = c[3];
					colP.addItem(eatable);
					AllC.push(eatable);
					addChild(eatable);
					eatable.x = c[1];
					eatable.y = c[2];
					var choices:Array = new Array;
					choices.push(c[5],c[6],c[7],c[8]);
					eatable.setLE(true , c[4], choices);
					eatable.gotoAndStop(2);
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
					//plat.graphics.beginBitmapFill(new MeshBitmapData(), null, true, false);
					//plat.graphics.drawRect(0, 0, 40, 40);
					//plat.graphics.drawRect(0,0,c[5],c[4]);
					//plat.graphics.endFill();
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
					botPlat.y = int(c[2]) + 20;
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
				if(c[0] == "specialPlatform"){
					var specplat:Platform = new Platform(c[4],c[5]);
					specplat.name = c[3];
					colspecial.addItem(specplat);
					Allspecial.push(specplat);
					addChild(specplat);
					specplat.x = c[1];
					specplat.y = c[2];
					specplat.setCV(c[6]);
				}
				if(c[0] == "flag"){
					var FLAG:wflag = new wflag;
					FLAG.name = c[3];
					addChild(FLAG);
					FLAG.x = c[1];
					FLAG.y = c[2];
					FLAG.height = c[4];
					FLAG.width = c[4];
				}
				if(c[0] == "torch"){
					var TORCH:torch = new torch;
					TORCH.name = c[3];
					addChild(TORCH);
					TORCH.x = c[1];
					TORCH.y = c[2];
					TORCH.height = c[4];
					TORCH.width = c[4];
				}
				if(c[0] == "doorOne"){
					var D:doorOne = new doorOne;
					D.name = c[3];
					addChild(D);
					D.x = c[1];
					D.y = c[2];
					AllEffects.push(D);
				}
				if(c[0] == "doorTwo"){
					var D2:doorTwo = new doorTwo;
					D2.name = c[3];
					addChild(D2);
					D2.x = c[1];
					D2.y = c[2];
					AllEffects.push(D2);
				}
				if(c[0] == "clouds"){
					var CLOUDS:clouds = new clouds;
					CLOUDS.name = c[3];
					addChild(CLOUDS);
					CLOUDS.x = c[1];
					CLOUDS.y = c[2];
				}
				if(c[0] == "gates"){
					var BILLY:gates = new gates;
					BILLY.name = c[3];
					addChild(BILLY);
					BILLY.x = c[1];
					BILLY.y = c[2];
					AllEffects.push(BILLY);
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
			if(menuON ==false && gameON ==false){
				if(e.charCode == 97){
					//a
					movinL = true;
				}
				if(e.charCode == 100){
					//d
					movinR = true;
				}
				if(e.charCode ==  119 && !(gameON) && !(menuON)){
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
