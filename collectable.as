package  {
	import flash.display.MovieClip
	public class collectable extends MovieClip{
		var thisValue:int = 50;
		var isED:Boolean = false;
		var isLE:Boolean = false;
		var leAns:int;
		var leArray:Array;
		public function collectable() {
			// constructor code
		}
		public function setED(b:Boolean){
			isED = b;
		}
		public function getED() : Boolean{
			return isED;
		}
		public function setLE(b:Boolean,i:int,a:Array){
			isLE = b;
			leAns = i;
			leArray = a;
		}
		public function getLE() : Boolean{
			return isLE;
		}
		public function getLeAns() : int{
			return leAns;
		}
		public function getLeArray() : Array{
			return leArray;
		}
		public function setVal(i:int){
			thisValue = i;
		}
		public function getVal() :int{
			return thisValue;
		}

	}
	
}
