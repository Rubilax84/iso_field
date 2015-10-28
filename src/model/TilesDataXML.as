/**
 * Created by Dryaglin on 15.10.2015.
 */
package model
{

	public class TilesDataXML
	{
		public static const NAME : String = 'TilesDataXML';
		private var _data : XML;

		public function TilesDataXML()
		{
		}

		public function get data() : XML
		{
			return _data;
		}

		public function set data( value : XML ) : void
		{
			_data = value.copy();
		}
	}
}
