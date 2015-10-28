/**
 * Created by Dryaglin on 20.10.2015.
 */
package utils
{

	import flash.geom.Point;

	public class IsoHelper
	{
		public static function convertToIso( mX : int, my : int, tileHeight : int ) : Point
		{
			var point : Point = new Point();

			point.x = int( (mX - my) * tileHeight );
			point.y = int( (mX + my) * tileHeight * 0.5 );

			return point;
		}

		public static function getTilePos( mX : int, my : int, tileHeight : int ) : Point
		{
			var point : Point = new Point();

			point.x = ( (mX / tileHeight + my / (tileHeight * 0.5)) * 0.5 );
			point.y = ( (my / (tileHeight * 0.5) - mX / tileHeight) * 0.5 );

			return (point.x > 0 && point.y > 0) ? new Point( int( point.x ), int( point.y ) ) : null;
		}
	}
}
