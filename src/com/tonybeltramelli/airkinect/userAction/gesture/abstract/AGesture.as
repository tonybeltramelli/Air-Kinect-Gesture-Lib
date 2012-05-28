package com.tonybeltramelli.airkinect.userAction.gesture.abstract {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.tonybeltramelli.airkinect.userAction.AUserAction;
	import com.tonybeltramelli.airkinect.userAction.IUserAction;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.IActionOccurationDispatcher;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.GestureSettings;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.JointSettings;
	import com.tonybeltramelli.lib.utils.math.UMath;
	import com.tonybeltramelli.lib.utils.math.UMathResult;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AGesture extends AUserAction implements IUserAction {
		protected var _gestureSettings : GestureSettings;
		protected var _jointSettings : JointSettings;
		//
		private var _bodyPosX : Vector.<Number>;
		private var _bodyPosY : Vector.<Number>;
		private var _bodyPosZ : Vector.<Number>;
		private var _wait : Boolean = false;
		//
		private const _BODY_LIMIT_X : int = 30;
		private const _BODY_LIMIT_Y : int = 20;
		private const _BODY_LIMIT_Z : int = 60;
		
		public function AGesture(settings : GestureSettings, dispatcher : IActionOccurationDispatcher = null) {
			super(dispatcher);
			_gestureSettings = settings;
			_jointSettings = new JointSettings(settings.part, settings.axis);
			
			_allPos = new Vector.<Number>();
			_gaps = new Vector.<Number>();
			_bodyPosX = new Vector.<Number>();
			_bodyPosY = new Vector.<Number>();
			_bodyPosZ = new Vector.<Number>();
		}
		
		public function compute(user : User) : void
		{
			_jointSettings.setJoint(user);
			
			_increment++;
			
			_gaps.push(user.getJointByName("waist").depthPosition.y - user.head.depthPosition.y);
			_bodyPosX.push(user.torso.depthPosition.x);
			_bodyPosY.push(user.torso.depthPosition.y);
			_bodyPosZ.push(user.torso.position.z);
			
			if(!_wait || _gestureSettings.ignoreGestureBack) _allPos.push(_jointSettings.jointProperty);
			if(!_wait && _increment == _speed)
			{
				var max : UMathResult = UMath.getMaxValueAndIndexV(_allPos);
				var min : UMathResult = UMath.getMinValueAndIndexV(_allPos);
				var gap : Number = max.value - min.value;
				var gapReference : Number =  UMath.average(_gaps);
				var bodyXRef : Number = UMath.getMaxValueAndIndexV(_bodyPosX).value - UMath.getMinValueAndIndexV(_bodyPosX).value;
				var bodyYRef : Number = UMath.getMaxValueAndIndexV(_bodyPosY).value - UMath.getMinValueAndIndexV(_bodyPosY).value;
				var bodyZRef : Number = UMath.getMaxValueAndIndexV(_bodyPosZ).value - UMath.getMinValueAndIndexV(_bodyPosZ).value;
				
				if(gap > gapReference*_jointSettings.gapRatio && user.position.z > _LIMIT && bodyXRef < _BODY_LIMIT_X*_jointSettings.gapRatio && bodyYRef < _BODY_LIMIT_Y*_jointSettings.gapRatio && bodyZRef < _BODY_LIMIT_Z)
				{
					_gestureSettings.ignoreGestureBack ? _wait = true : _wait = false;
					max.i < min.i ? _gestureDetected(1) : _gestureDetected(-1);
				}
				_cleanLoop();
			}else if(_gestureSettings.ignoreGestureBack && _wait && _increment == _jointSettings.waitRatio*_speed)
			{
				_wait = false;
				_cleanLoop();
			}
		}
			
		override protected function _cleanLoop() : void {
			_bodyPosX = null;
			_bodyPosX = new Vector.<Number>();
			_bodyPosY = null;
			_bodyPosY = new Vector.<Number>();
			_bodyPosZ = null;
			_bodyPosZ = new Vector.<Number>();
			super._cleanLoop();
		}
		
		public function clean() : void
		{
			_cleanLoop();
			_gestureSettings = null;
			_jointSettings =  null;
		}	
	}
}
