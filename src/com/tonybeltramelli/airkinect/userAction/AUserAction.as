package com.tonybeltramelli.airkinect.userAction {
	import com.tonybeltramelli.airkinect.userAction.dispatcher.ActionEventDispatcher;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AUserAction {
		protected var _speed : int = 0;
		protected var _dispatcher : IActionOccurationDispatcher;
		protected var _increment : int = 0;
		protected var _gaps : Vector.<Number>;
		protected var _allPos : Vector.<Number>;
		//
		protected const _LIMIT : int = 1000;

		public function AUserAction(dispatcher : IActionOccurationDispatcher = null) {
			dispatcher == null ? _dispatcher = new ActionEventDispatcher() : _dispatcher = dispatcher;
		}
				
		protected function _gestureDetected(direction : Number) : void {
		}
		
		protected function _cleanLoop() : void
		{
			_allPos = null;
			_allPos = new Vector.<Number>();
			_gaps = null;
			_gaps = new Vector.<Number>();
			_increment = 0;
		}
		
		public function set speed(speed : int) : void {
			_speed = speed;
		}

		public function get dispatcher() : IActionOccurationDispatcher {
			return _dispatcher;
		}	
	}
}
