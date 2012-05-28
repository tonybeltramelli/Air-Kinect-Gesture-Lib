package com.tonybeltramelli.airkinect.userAction.gesture {
	import com.tonybeltramelli.airkinect.userAction.dispatcher.ActionSignalDispatcher;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectGestureEvent;
	import com.tonybeltramelli.airkinect.userAction.gesture.abstract.AGesture;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.GestureSettings;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.direction.GestureDirection;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class HorizontalSwipe extends AGesture {
		
		public function HorizontalSwipe(part : String, dispatcher : IActionOccurationDispatcher = null, ignoreGestureBack : Boolean = false) {
			super(new GestureSettings(part, GestureDirection.SWIPE_HORIZONTAL, ignoreGestureBack), dispatcher);
		}
			
		override protected function _gestureDetected(direction : Number) : void {
			direction > 0 ? _dispatcher.dispatch(new KinectGestureEvent(KinectGestureEvent.LEFT_SWIPE)) : _dispatcher is ActionSignalDispatcher ? ActionSignalDispatcher(_dispatcher).dispatchSecond() : _dispatcher.dispatch(new KinectGestureEvent(KinectGestureEvent.RIGHT_SWIPE));
		}
	}
}