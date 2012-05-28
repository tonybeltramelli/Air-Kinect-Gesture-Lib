package com.tonybeltramelli.airkinect.userAction.gesture {
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectGestureEvent;
	import com.tonybeltramelli.airkinect.userAction.gesture.abstract.AGesture;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.GestureSettings;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.direction.GestureDirection;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ForwardSwipe extends AGesture {
		public function ForwardSwipe(part : String, dispatcher : IActionOccurationDispatcher = null) {
			super(new GestureSettings(part, GestureDirection.SWIPE_FORWARD), dispatcher);
		}
			
		override protected function _gestureDetected(direction : Number) : void {
			if(direction > 0) _dispatcher.dispatch(new KinectGestureEvent(KinectGestureEvent.FORWARD_SWIPE));
		}
	}
}
