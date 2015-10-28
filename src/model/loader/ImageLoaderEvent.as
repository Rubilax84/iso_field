/**
 * Created by Dryaglin on 15.10.2015.
 */
package model.loader
{

	import flash.display.LoaderInfo;
	import flash.events.Event;

	public class ImageLoaderEvent extends Event
	{
		public var loaderInfo : LoaderInfo;

		public function ImageLoaderEvent( data : LoaderInfo, type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			loaderInfo = data;
			super( type, bubbles, cancelable );
		}

		override public function clone() : Event
		{
			return new ImageLoaderEvent( loaderInfo, type, bubbles, cancelable );
		}
	}
}
