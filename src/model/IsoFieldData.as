/**
 * Created by Dryaglin on 20.10.2015.
 */
package model
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class IsoFieldData extends EventDispatcher
	{
		public static const NAME : String = 'IsoFieldData';

		public static const TILES_DATA_UPDATE : String = 'tilesDataUpdate';

		private var _tilesList : Array;

		public function IsoFieldData()
		{
			_tilesList = [];
		}

		public function initTilesList( data : XML ) : void
		{
			var rows : XMLList = data.row;
			var colls : XMLList = data.row.tile;
			var maxRowsCount : int = rows.length();
			var maxCollsCount : int = colls.length() / rows.length();

			var xShift : uint = 0;
			var yShift : uint = 0;

			for each ( var xml : XML in data.row )
			{
				_tilesList.push( [] );

				for each ( var tile : XML in xml.tile )
				{
					_tilesList[yShift].push( tile.@type );

					xShift++;
				}

				yShift++;

				if ( xShift >= maxRowsCount ) xShift = 0;
				if ( yShift >= maxCollsCount ) yShift = 0;
			}

			this.dispatchEvent( new Event( IsoFieldData.TILES_DATA_UPDATE ) );
		}

		public function setTileType( x : int, y : int, tileType : uint ) : void
		{
			tilesList[y][x] = tileType;
			this.dispatchEvent( new IsoFiledEvent( new TileSimpleData( x, y, tileType ), IsoFiledEvent.TILE_UPDATE ) );
		}

		public function getFieldSize() : Point
		{
			var size : Point = new Point();
			size.x = _tilesList[0].length;
			size.y = _tilesList.length;

			return size;
		}

		public function get tilesList() : Array
		{
			return _tilesList;
		}

		public function set tilesList( value : Array ) : void
		{
			_tilesList = value;
		}
	}
}
