package com.tonybeltramelli.airkinect.userAction.gesture.settings {
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.direction.GestureDirection;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class GestureSettings {
		private var _part : String;
		private var _direction : String;
		private var _axis : String;
		private var _ignoreGestureBack : Boolean;

		public function GestureSettings(part : String, direction : String, ignoreGestureBack : Boolean = false) {
			_part = part;
			_direction = direction;
			_ignoreGestureBack = ignoreGestureBack;
			
		 	_setAxis();
		}
		
		private function _setAxis() : void
		{
			switch (_direction)
			{
				case GestureDirection.SWIPE_HORIZONTAL :
				case GestureDirection.SWIPE_LEFT :
				case GestureDirection.SWIPE_RIGHT :
					_axis = "x";
					break;
				case GestureDirection.SWIPE_VERTICAL :
				case GestureDirection.SWIPE_UP :
				case GestureDirection.SWIPE_DOWN :
					_axis = "y";
					break;
				case GestureDirection.SWIPE_DEPTH :
				case GestureDirection.SWIPE_FORWARD :
				case GestureDirection.SWIPE_BACKWARD :
					_axis = "z";
					break;
				default :
					throw new Error("--> Error : the direction '"+_direction+"' is unknown.");
			}
		}

		public function get part() : String {
			return _part;
		}

		public function get direction() : String {
			return _direction;
		}
		
		public function get axis() : String {
			return _axis;
		}

		public function get ignoreGestureBack() : Boolean {
			return _ignoreGestureBack;
		}
	}
}
