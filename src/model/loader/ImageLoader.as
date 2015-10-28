/**
 * Created by Dryaglin on 15.10.2015.
 */
package model.loader
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class ImageLoader extends DataLoader
	{
		public static const ALL_IMAGES_LOADED : String = 'allImagesLoaded';
		public static const IMAGE_LOADED : String = 'imageLoaded';
		private var _imageLoader : Loader;
		private var _loadsInStack : uint;

		private var _imagesDataList : Vector.<BitmapData>;

		public function ImageLoader()
		{
			super();

			_imagesDataList = new <BitmapData>[];
		}

		override public function load( url : String ) : void
		{
			_loadsInStack++;

			_imageLoader = new Loader();
			_imageLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, loader_completeHandler, false, 0, true );
			_imageLoader.load( new URLRequest( url ), new LoaderContext() );
		}

		public function loadFiles( value : Array ) : void
		{
			for ( var i : int = 0; i < value.length; i++ )
			{
				var url : String = value[i];
				this.load( url );
			}
		}

		override protected function loader_completeHandler( event : Event ) : void
		{
			var loaderInfo : LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener( Event.COMPLETE, loader_completeHandler );

			var imageData : Bitmap = loaderInfo.content as Bitmap;
			_imagesDataList.push( imageData.bitmapData.clone() );

			_loadsInStack--;

			if ( !_loadsInStack )
			{
				dispatchEvent( new ImageLoaderEvent(loaderInfo, ImageLoader.IMAGE_LOADED) );
				dispatchEvent( new Event( ImageLoader.ALL_IMAGES_LOADED ) );
			}
			else
			{
				dispatchEvent( new ImageLoaderEvent(loaderInfo, ImageLoader.IMAGE_LOADED) );
			}

			loaderInfo.loader.unloadAndStop();
		}

		public function get imagesDataList() : Vector.<BitmapData>
		{
			return _imagesDataList;
		}
	}
}
