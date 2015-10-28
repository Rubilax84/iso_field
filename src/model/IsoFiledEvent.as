/**
 * Created by Dryaglin on 20.10.2015.
 */
package model
{

	import flash.events.Event;

	public class IsoFiledEvent extends Event
	{
		public static const TILE_UPDATE : String = 'tileUpdate';
		public var data : TileSimpleData;

		public function IsoFiledEvent( data : TileSimpleData, type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			this.data = data;
			super( type, bubbles, cancelable );
		}

		override public function clone() : Event
		{
			return new IsoFiledEvent( data, type, bubbles, cancelable );
		}
	}
}
