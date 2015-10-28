/**
 * Created by Dryaglin on 20.10.2015.
 */
package model
{

	public class TileSimpleData
	{
		public var tileX : int;
		public var tileY : int;
		public var tileType : uint;

		public function TileSimpleData( x : int, y : int, type : int )
		{
			tileX = x;
			tileY = y;
			tileType = type;
		}
	}
}
