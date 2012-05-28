package com.tonybeltramelli.airkinect.userAction.event {
	import flash.events.Event;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KinectGestureEvent extends Event {
		public static const BACKWARD_SWIPE : String = "backward_swipe";
		public static const DOWN_SWIPE : String = "down_swipe";
		public static const FORWARD_SWIPE : String = "forward_swipe";
		public static const LEFT_SWIPE : String = "left_swipe";
		public static const RIGHT_SWIPE : String = "right_swipe";
		public static const UP_SWIPE : String = "up_swipe";
		
		public function KinectGestureEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
