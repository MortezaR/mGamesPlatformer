package  {
	import flash.display.MovieClip;
	public class endLvl extends MovieClip{
		protected var pointStage:int;
		protected var pointLevel:int;
		public function endLvl(s:int,l:int) {
			pointStage = s;
			pointLevel = l;
		}
		public function getPS() : int{
			return(pointStage);
		}
		public function getLS() : int{
			return(pointLevel);
		}
		public function setPS(c:int){
			pointStage = c;
		}
		public function setLS(c:int){
			pointLevel = c;
		}

	}
	
}
