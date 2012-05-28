package com.tonybeltramelli.airkinect.userAction.gesture {
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectGestureEvent;
	import com.tonybeltramelli.airkinect.userAction.gesture.abstract.AGesture;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.GestureSettings;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.direction.GestureDirection;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class DownSwipe extends AGesture {
		public function DownSwipe(part : String, dispatcher : IActionOccurationDispatcher = null) {
			super(new GestureSettings(part, GestureDirection.SWIPE_DOWN), dispatcher);
		}
			
		override protected function _gestureDetected(direction : Number) : void {
			if(direction < 0) _dispatcher.dispatch(new KinectGestureEvent(KinectGestureEvent.DOWN_SWIPE));
		}
	}
}
