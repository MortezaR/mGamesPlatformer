package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class Player extends MovieClip{
		var yVel:int = 0;
		var xVel:int = 0;
		var jumpCount:int = 0;
		var headHitTimer:Timer = new Timer(100,1);
		var headDaze:Boolean = false;
		var onPlatform:Boolean = false;
		public function Player() {
			addEventListener(Event.ENTER_FRAME, gravity);
		}
		function gravity (e:Event){
			if(onPlatform == false || headDaze == true){
				this.y -= yVel;
				yVel -= 2;
				if(yVel < -10)
					yVel = -10;
			}
		}
		function hitPlatform(){
			
			onPlatform = true;
			yVel = 0;
			if(headDaze ==false)
				jumpCount = 0;
		}
		function offPlatform(){
			onPlatform = false;
		}
		function getPlatform(): Boolean{
			return onPlatform;
		}
		function hitHead(){
			headDaze = true;
			yVel = 0;
			this.y += 4;
			onPlatform = false;
			headHitTimer.addEventListener(TimerEvent.TIMER, headHeal);
			headHitTimer.reset();
			headHitTimer.start();
			
		}
		function headHeal(e:TimerEvent){
			headDaze = false;
		}
		function jump(){
			if(jumpCount <= 1 && headDaze == false){
				this.yVel = 20;
				offPlatform();
				jumpCount++;
			}
		}
		public function getyVel(): Number{
			return yVel;
		}

	}
	
}
