/**
 * Created by Dryaglin on 15.10.2015.
 */
package
{

	import controller.DataLoadController;
	import controller.IController;

	import flash.display.Stage;

	import flash.events.Event;

	import flash.events.IEventDispatcher;

	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	import model.*;

	import view.IsoField;

	public class Game
	{
		private static var _instance : Game;
		public static function get instance() : Game
		{
			if ( !_instance ) _instance = new Game();
			return _instance;
		}

		public var display : Stage;

		public var controllers : Dictionary;
		public var dataProxy : Dictionary;
		public var mediators : Dictionary;

		public function Game()
		{

		}

		public function init( stage : Stage ) : void
		{
			display = stage;
			initControllers();
			initData();
			initMediators();

			loadData();
		}

		private function initMediators() : void
		{
			mediators = new Dictionary();

			mediators[IsoField.NAME] = new IsoField();
		}

		private function initData() : void
		{
			dataProxy = new Dictionary();

			dataProxy[TilesDataXML.NAME] = new TilesDataXML();
			dataProxy[ImagesData.NAME] = new ImagesData();
			dataProxy[IsoFieldData.NAME] = new IsoFieldData();
		}

		private function initControllers() : void
		{
			controllers = new Dictionary();
			controllers[DataLoadController.NAME] = new DataLoadController();
		}

		private function loadData() : void
		{
			(controllers[DataLoadController.NAME] as IEventDispatcher).addEventListener( DataLoadController.All_DATA_LOADED, allDataLoadedHandler );
			(controllers[DataLoadController.NAME] as IController).init();
		}

		private function allDataLoadedHandler( event : Event ) : void
		{
			(mediators[IsoField.NAME] as IsoField).init();

			(dataProxy[IsoFieldData.NAME] as IsoFieldData).initTilesList( (dataProxy[TilesDataXML.NAME] as TilesDataXML).data );
		}
	}
}
