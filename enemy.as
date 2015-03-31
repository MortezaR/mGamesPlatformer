package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import mathUtils;
	import flash.geom.Point;
	public class enemy extends MovieClip{
		var hit_points:int;
		var max_health:int;
		var armor:int;
		var patrol_points:Array =[];
		var patrol_speed:Number = .02;
		var curDes:int = 0;
		var currentLoc:Point;
		public function enemy(a:int,b:int,pPoints:Array) {
			max_health = a;
			hit_points = a;
			armor = b;
			currentLoc = pPoints[0];
			for(var i:int = 1; i < pPoints.length; i ++)
				patrol_points.push(pPoints[i]);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		private function enterFrameHandler(event:Event):void
		{
			patrol();
		}
		public function getHealth(): int{
			return hit_points;
		}
		public function setHealth(life:int){
			hit_points = life;
		}
		public function takeDamage(c:int){
			if(c < armor){
			hit_points -= c - armor;
			}
			else{
			hit_points -= 1;
			}
			if(hit_points <= 0){
				this.removeChild(this);
			}
		}
		public function setPatrolPoints(pPoints:Array){
			for(var i:int = 0; i < pPoints.length; i ++)
				patrol_points.push(pPoints[i]);
		}
										
		public function patrol(){
			var tempX:Number = patrol_speed * (patrol_points[curDes].x - currentLoc.x);
			var tempY:Number = patrol_speed * (patrol_points[curDes].y - currentLoc.y);
			this.x += tempX;
			this.y += tempY;
			if(Math.abs(this.x - patrol_points[curDes].x) < 10 && Math.abs(this.y - patrol_points[curDes].y) < 10){
				currentLoc = new Point(this.x,this.y);
				if(curDes == patrol_points.length - 1)
				curDes = 0;
				else
				curDes ++;
			}
		}
		

	}
	
}
