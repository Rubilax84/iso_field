/**
 * Created by Dryaglin on 15.10.2015.
 */
package controller
{

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import model.GlobalConstants;
	import model.ImagesData;
	import model.TilesDataXML;

	import model.loader.DataLoader;
	import model.loader.ImageLoader;
	import model.loader.ImageLoaderEvent;

	public class DataLoadController extends EventDispatcher implements IController
	{
		public static const All_DATA_LOADED : String = "allDataLoaded";

		public static const NAME : String = "DataLoadController";

		private var dataLoader : DataLoader;
		private var imageLoader : ImageLoader;

		public function DataLoadController()
		{

		}

		public function init() : void
		{
			dataLoader = new DataLoader();
			dataLoader.addEventListener( DataLoader.DATA_LOADED, onData_loaded, false, 0, true );
			dataLoader.load( GlobalConstants.TILE_DATA_URL );
		}

		private function onData_loaded( event : Event ) : void
		{
			Game.instance.dataProxy[TilesDataXML.NAME].data = new XML( dataLoader.data );
			dataLoader.removeEventListener( DataLoader.DATA_LOADED, onData_loaded );

			loadAssetsImages();
		}

		private function loadAssetsImages() : void
		{
			imageLoader = new ImageLoader();
			var filesList : Array = [];

			for ( var i : int = 1; i <= 5; i++ )
			{
				filesList.push( GlobalConstants.IMAGE_FOLDER + i + ".png" );
			}

			filesList.push( GlobalConstants.IMAGE_FOLDER + GlobalConstants.GRASS );

			imageLoader.addEventListener( ImageLoader.IMAGE_LOADED, onImagesLoaded_Handler, false, 0, true );
			imageLoader.addEventListener( ImageLoader.ALL_IMAGES_LOADED, onAllImagesLoaded, false, 0, true );
			imageLoader.loadFiles( filesList );
		}

		private function onImagesLoaded_Handler( event : ImageLoaderEvent ) : void
		{
			var imagesData : ImagesData = Game.instance.dataProxy[ImagesData.NAME];
			var url : String = event.loaderInfo.url;
			var fileName : String = url.match( GlobalConstants.FILE_WITH_EXTENSION )[0];

			imagesData.setImage( fileName, event.loaderInfo.content as Bitmap );
		}

		private function onAllImagesLoaded( event : Event ) : void
		{
			imageLoader.removeEventListener( ImageLoader.IMAGE_LOADED, onImagesLoaded_Handler );
			imageLoader.removeEventListener( ImageLoader.ALL_IMAGES_LOADED, onAllImagesLoaded );

			dispatchEvent( new Event( DataLoadController.All_DATA_LOADED ) );
		}
	}
}
