/**
 * Created by Dryaglin on 15.10.2015.
 */
package view
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import model.GlobalConstants;
	import model.ImagesData;
	import model.IsoFieldData;
	import model.IsoFiledEvent;

	import utils.IsoHelper;

	public class IsoField extends Sprite
	{
		public static const NAME : String = 'IsoField';

		private var fieldData : XML;
		private var display : Stage;
		private var tilesList : Array;
		private var fieldSprite : Sprite;
		private var isDrag : Boolean;
		private var imagesList : Dictionary;
		private var fieldBitmap : Bitmap;
		private var maxRowsCount : int;
		private var maxCollsCount : Number;
		private var tilePosPadding : int;

		public function IsoField()
		{
			display = Game.instance.display;

			tilesList = [];

			fieldSprite = new Sprite();
			fieldSprite.mouseChildren = false;

			display.addChild( fieldSprite );
		}

		public function init() : void
		{
			imagesList = (Game.instance.dataProxy[ImagesData.NAME] as ImagesData).imagesList;

			(Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).addEventListener( IsoFieldData.TILES_DATA_UPDATE, tilesDataUpdateHandler );
			(Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).addEventListener( IsoFiledEvent.TILE_UPDATE, tileUpdateHandler );

			//add click listener
			fieldSprite.addEventListener( MouseEvent.CLICK, fieldSprite_mouseClickHandler );
		}

		private function tilesDataUpdateHandler( event : Event ) : void
		{
			tilesList = (Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).tilesList;

			!fieldBitmap ? createField() : clearField();

			for ( var i : int = 0; i < tilesList.length; i++ )
			{
				for ( var j : int = 0; j < tilesList[i].length; j++ )
				{
					createTile( tilesList[i][j], j, i );
				}
			}

			//align to center
			fieldSprite.x = int( (display.stageWidth) * 0.5 );
			fieldSprite.y = int( (display.stageHeight - fieldSprite.height) * 0.5 );
		}

		private function tileUpdateHandler( event : IsoFiledEvent ) : void
		{
			tilesDataUpdateHandler( null );
		}

		private function createField() : void
		{
			var fieldSize : Point = (Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).getFieldSize();

			var fieldBitmapData : BitmapData = new BitmapData( fieldSize.x * GlobalConstants.DEFAULT_TILE_WIDTH, fieldSize.y * GlobalConstants.DEFAULT_TILE_HEIGHT );
			fieldBitmap = new Bitmap( fieldBitmapData );

			fieldBitmap.x = -int( (fieldBitmap.width * 0.5) );

			fieldSprite.addChild( fieldBitmap );

			tilePosPadding = ((fieldSize.x * (GlobalConstants.DEFAULT_TILE_WIDTH / 2)) - GlobalConstants.DEFAULT_TILE_WIDTH * 0.5);

			maxRowsCount = fieldSize.x;
			maxCollsCount = fieldSize.y;
		}

		private function clearField() : void
		{
			var fieldSize : Point = (Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).getFieldSize();

			fieldBitmap.bitmapData.dispose();
			fieldBitmap.bitmapData = new BitmapData( fieldSize.x * GlobalConstants.DEFAULT_TILE_WIDTH, fieldSize.y * GlobalConstants.DEFAULT_TILE_HEIGHT );
		}

		private function createTile( tileID : uint, r : uint, c : uint ) : void
		{
			var tilePos : Point;
			var bd : BitmapData;
			var matrix : Matrix = new Matrix();

			tilePos = IsoHelper.convertToIso( r, c, GlobalConstants.DEFAULT_TILE_HEIGHT );

			matrix.tx = tilePos.x + tilePosPadding;
			matrix.ty = tilePos.y;

			fieldBitmap.bitmapData.lock();

			bd = imagesList[ImagesData.getRightFileName( 0 )];

			// draw grass
			fieldBitmap.bitmapData.draw( bd, matrix, null, null, null, true );

			//draw forest
			if ( tileID > 0 )
			{
				var imageBitmapData : BitmapData = new BitmapData( GlobalConstants.DEFAULT_TILE_WIDTH, GlobalConstants.DEFAULT_TILE_HEIGHT, true, 0 );
				var imageMatrix : Matrix = new Matrix();

				bd = imagesList[ImagesData.getRightFileName( tileID )];

				imageMatrix.scale( 0.9, 0.9 );
				imageMatrix.translate( GlobalConstants.DEFAULT_TILE_WIDTH * 0.05, GlobalConstants.DEFAULT_TILE_HEIGHT * 0.05 );

				imageBitmapData.draw( bd, imageMatrix);

				//fieldBitmap.bitmapData.draw( imageBitmapData, matrix );
				//как альтернатива методу draw
				fieldBitmap.bitmapData.copyPixels( imageBitmapData, imageBitmapData.rect, new Point( matrix.tx, matrix.ty ), null, null, true );

				imageBitmapData.dispose();
				imageBitmapData = null;
				imageMatrix = null;
			}

			fieldBitmap.bitmapData.unlock();

			tilePos = null;
			bd = null;
			matrix = null;
		}

		private function fieldSprite_mouseClickHandler( event : MouseEvent ) : void
		{
			var pos : Point = IsoHelper.getTilePos( fieldSprite.mouseX, fieldSprite.mouseY, GlobalConstants.DEFAULT_TILE_HEIGHT );

			if ( !pos || pos.x > maxRowsCount - 1 || pos.y > maxCollsCount - 1 ) return;

			(Game.instance.dataProxy[IsoFieldData.NAME] as IsoFieldData).setTileType( pos.x, pos.y, event.ctrlKey ? 0 : Math.ceil( Math.random() * 5 ) );
		}

	}
}
