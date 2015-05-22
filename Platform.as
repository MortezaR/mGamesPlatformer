package  {
	import flash.display.MovieClip
	public class Platform extends MovieClip{
		var bottom:Boolean = false;
		var crossVal:int = 0;

		public function Platform(l:int,w:int) {
			this.height = l;
			this.width = w;

		}
		public function setBottom(a:Boolean){
			bottom = a;
		}
		public function getBottom(){
			
		}
		public function setCV(i:int){
			crossVal = i;
		}
		public function getCV() :int{
			return crossVal;
		}

	}
	
}
