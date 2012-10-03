package com.tonybeltramelli.airkinect.userAction.movement.abstract {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.tonybeltramelli.airkinect.userAction.AUserAction;
	import com.tonybeltramelli.airkinect.userAction.IUserAction;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.lib.utils.math.UMath;
	import com.tonybeltramelli.lib.utils.math.UMathResult;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AMovement extends AUserAction implements IUserAction {
		protected var _jointProperty : Number;
		protected var _gapRatio : Number;
		
		public function AMovement(dispatcher : IActionOccurationDispatcher = null) {
			super(dispatcher);
			_allPos = new Vector.<Number>();
			_gaps = new Vector.<Number>();
		}
		
		public function compute(user : User) : void {
			_increment++;
			
			_gaps.push(user.getJointByName("waist").position.depth.y - user.head.position.depth.y);
			_allPos.push(_jointProperty);
			
			if(_increment == _speed)
			{
				var max : UMathResult = UMath.getMaxValueAndIndexV(_allPos);
				var min : UMathResult = UMath.getMinValueAndIndexV(_allPos);
				var gap : Number = max.value - min.value;
				var gapReference : Number =  UMath.average(_gaps);
				
				if(gap > gapReference*_gapRatio && user.position.world.z > _LIMIT)
				{
					max.i < min.i ? _gestureDetected(1) : _gestureDetected(-1);
				}
				_cleanLoop();
			}
		}

		public function clean() : void {
			_cleanLoop();
		}
	}
}
