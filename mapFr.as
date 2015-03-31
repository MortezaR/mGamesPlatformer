package  bbone{
	import flash.display.MovieClip;
	import allChar.*;
	import allChar.tiles.tile;
	import flash.events.MouseEvent;
	public class mapFr extends MovieClip{
		var grid:Array = new Array;
		var listChar:Array = new Array;
		var super_meat_boy:mainChar;
		public function mapFr(x:int,y:int) {
			super_meat_boy = new mainChar();
			this.addEventListener(MouseEvent.CLICK, unOccupied)
			for(var i:int = 0; i < 1.5 * x; i++){
				grid[i] = new Array;
				for(var j:int = 0; j< y; j++){
					grid[i][j] = new tile();
					grid[i][j].x = 80 * i - 40 * j;
					grid[i][j].y = 40 * 1.732 * j;
					addChild(grid[i][j]);
				}
			}
			
		}
		public function findselection(x:int, y:int){
			var points:Array = new Array;
			var b:int = y/(40*1.732);
			x += b * 40;
			var a:int = x / 80;
			y -= b * 40 * 1.732;
			x -= a * 80;
			if (y < 40 / 1.732) {
				if (x < 40) {
					if(x/40 < 1 - y/(40/1.732)) {
						b -= 1;
						a -= 1;
					}
				} else {
					if( (x-40)/40 > y/(40/1.732)) {
						b -= 1;
					}
					
				}
			}
			points.push(a, b);
			return points;
			
		}
		public function addChar(){
			listChar.push(Char)
		}
		public function moveleft(a:Char,dis:int){
			a.x = -80*dis
		}
		public function moveright(a:Char,dis:int){
			a.x = 80*dis
		}
		public function movedown(a:Char,dis:int){
			a.y = -80*dis
		}
		public function moveup(a:Char,dis:int){
			a.y = 80*dis
		}
		private function unOccupied(e:MouseEvent) :void{
			trace(findselection(mouseX,mouseY));
		}
	}
	
}
