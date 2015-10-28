package
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(frameRate=60, width=1024, height=768)]
	public class Main extends Sprite
	{

		public function Main()
		{
			if ( stage ) init();
			else
			{
				addEventListener( Event.ADDED_TO_STAGE, init, false, 0, true );
			}
		}

		private function init( e : Event = null ) : void
		{
			if ( e ) removeEventListener( Event.ADDED_TO_STAGE, init );

			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;

			Game.instance.init( this.stage );

			//this.addChild( new Stats() );
		}
	}
}
