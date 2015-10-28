/**
 * Created by Dryaglin on 15.10.2015.
 */
package model
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	public class ImagesData
	{
		public static const NAME : String = 'ImagesData';
		private var _imagesList : Dictionary;

		public function ImagesData()
		{
			_imagesList = new Dictionary();
		}

		public function setImage( imageName : String, image : Bitmap ) : void
		{
			_imagesList[imageName] = image.bitmapData.clone();
		}

		public function getBitmapByFileName( imageName : String ) : Bitmap
		{
			if ( _imagesList[imageName] )
			{
				var bd : BitmapData = _imagesList[imageName];
				var bitmap : Bitmap = new Bitmap( bd, 'auto', true );

				return bitmap;
			}

			return null;
		}

		public function get imagesList() : Dictionary
		{
			return _imagesList;
		}

		public static function getRightFileName( tileType : int ) : String
		{
			return (tileType == 0) ? GlobalConstants.GRASS : tileType + '.png';
		}
	}
}
