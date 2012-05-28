package com.tonybeltramelli.airkinect.userAction.event {
	import flash.events.Event;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KinectMovementEvent extends Event {
		public static const BEND_DOWN_MOVEMENT : String = "bend_down_movement";
		public static const JUMP_MOVEMENT : String = "jump_movement";
		
		public function KinectMovementEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
