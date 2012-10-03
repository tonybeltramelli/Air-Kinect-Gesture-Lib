package com.tonybeltramelli.airkinect.userAction.movement {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectMovementEvent;
	import com.tonybeltramelli.airkinect.userAction.movement.abstract.AMovement;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class BendDownMovement extends AMovement {
		public function BendDownMovement(dispatcher : IActionOccurationDispatcher = null) {
			super(dispatcher);
			_gapRatio = 0.85;
		}
			
		override public function compute(user : User) : void {
			_jointProperty = user.torso.position.depth.y;
			super.compute(user);
		}
			
		override protected function _gestureDetected(direction : Number) : void {
			if(direction < 0) _dispatcher.dispatch(new KinectMovementEvent(KinectMovementEvent.BEND_DOWN_MOVEMENT));
		}
	}
}
