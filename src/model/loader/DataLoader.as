/**
 * Created by Dryaglin on 15.10.2015.
 */
package model.loader
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class DataLoader extends EventDispatcher
	{

		public static const DATA_LOADED : String = "data_loaded";

		private var _data : Object;
		private var _url : String;

		private var _loader : URLLoader;

		public function DataLoader()
		{

		}

		public function load( url : String ) : void
		{
			_url = url;

			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener( Event.COMPLETE, loader_completeHandler, false, 0, true );

			_loader.load( new URLRequest( _url ) );

		}

		public function get data() : Object
		{
			return _data;
		}

		protected function loader_completeHandler( event : Event ) : void
		{
			_loader.removeEventListener( Event.COMPLETE, loader_completeHandler );

			_data = _loader.data;

			this.dispatchEvent( new Event( DataLoader.DATA_LOADED ) );
		}
	}
}
