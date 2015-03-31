package  bbone{
	
	public class mathUtils {

		public function mathUtils() {
		}
		public static function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		public static function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		public static function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}

	}
	
}
