package com.tonybeltramelli.airkinect.userAction.gesture {
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectGestureEvent;
	import com.tonybeltramelli.airkinect.userAction.gesture.abstract.AGesture;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.GestureSettings;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.direction.GestureDirection;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class UpSwipe extends AGesture {
		public function UpSwipe(part : String, dispatcher : IActionOccurationDispatcher = null) {
			super(new GestureSettings(part, GestureDirection.SWIPE_UP), dispatcher);
		}
			
		override protected function _gestureDetected(direction : Number) : void {
			if(direction > 0) _dispatcher.dispatch(new KinectGestureEvent(KinectGestureEvent.UP_SWIPE));
		}
	}
}
