/**
 * Created by Dryaglin on 15.10.2015.
 */
package model
{

	public class GlobalConstants
	{
		public static const TILE_DATA_URL : String = "tileset.xml";
		public static const IMAGE_FOLDER : String = 'images/';
		public static const GRASS : String = 'grass.png';

		public static const FOREST_TYPE_COUNT : uint = 5;

		public static const DEFAULT_TILE_WIDTH : uint = 120;
		public static const DEFAULT_TILE_HEIGHT : uint = 60;

		public static const FILE_WITH_EXTENSION : RegExp = /(?<=\/)(\w+)((\.\w+(?=\?))|(\.\w+)$)/g;
	}
}
