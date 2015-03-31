package  {
	import flash.display.MovieClip
	public class collectable extends MovieClip{
		var quick:Boolean = false;
		public function collectable() {
			// constructor code
		}
		public function yes(){
			quick = true;
		}
		public function getyes() : Boolean{
			return quick;
		}

	}
	
}
