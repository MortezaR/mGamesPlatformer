package  {
	import flash.display.MovieClip;
	public class HPbar extends MovieClip{
		var MaxHP:Number = new Number;
		var CurHP:Number = new Number;
		var PerHP:Number = new Number;
		public function HPbar(maxhp:Number) {
			MaxHP = maxhp;
			CurHP = MaxHP;
		}
		public function setHealth(dam:Number){
			CurHP = dam;
			PerHP = CurHP/MaxHP;
			HPVal.scaleX = PerHP;
		}

	}
	
}
