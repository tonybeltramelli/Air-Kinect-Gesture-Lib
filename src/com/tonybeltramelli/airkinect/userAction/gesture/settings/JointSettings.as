package com.tonybeltramelli.airkinect.userAction.gesture.settings {
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.part.GesturePart;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class JointSettings {
		private var _part : String;
		private var _axis : String;
		private var _jointProperty : Number;
		private var _gapRatio : Number;
		private var _waitRatio : Number;
		
		public function JointSettings(part : String, axis : String) {
			_part = part;
			_axis = axis;
		}
		
		public function setJoint(user : User) : void
		{
			var jointToTrack : SkeletonJoint;
						
			switch (_part)
			{
				case GesturePart.HEAD :
					jointToTrack = user.head;
					_gapRatio = 0.15;
					_waitRatio = 0.8;
					break;
				case GesturePart.RIGHT_HAND :
					jointToTrack = user.rightHand;
					_gapRatio = 0.3;
					_waitRatio = 0.1;
					break;
				case GesturePart.LEFT_HAND :
					jointToTrack = user.leftHand;
					_gapRatio = 0.3;
					_waitRatio = 0.1;
					break;
				case GesturePart.RIGHT_FOOT :
					jointToTrack = user.rightFoot;
					_gapRatio = 1.5;
					_waitRatio = 2;
					break;
				case GesturePart.LEFT_FOOT :
					jointToTrack = user.leftFoot;
					_gapRatio = 1.5;
					_waitRatio = 2;
					break;
				case GesturePart.RIGHT_ELBOW :
					jointToTrack = user.rightElbow;
					_gapRatio = 0.5;
					_waitRatio = 0.8;
					break;
				case GesturePart.LEFT_ELBOW :
					jointToTrack = user.leftElbow;
					_gapRatio = 0.5;
					_waitRatio = 0.8;
					break;
				case GesturePart.RIGHT_KNEE:
					jointToTrack = user.rightKnee;
					_gapRatio = 0.8;
					_waitRatio = 0.9;
					break;
				case GesturePart.LEFT_KNEE :
					jointToTrack = user.leftKnee;
					_gapRatio = 0.8;
					_waitRatio = 0.9;
					break;
				default :
					throw new Error("--> Error : the part '"+_part+"' is unknown.");
					break;
			}
			
			_setPropertie(jointToTrack);
		}
		
		private function _setPropertie(joint : SkeletonJoint) : void
		{
			switch (_axis)
			{
				case "x":
					_jointProperty = joint.position.depth.x;
					break;
				case "y":
					_jointProperty = joint.position.depth.y;
					break;
				case "z":
					_jointProperty = joint.position.world.z;
					_gapRatio = _gapRatio*7;
					break;
				default :
					throw new Error("--> Error : the axis '"+_axis+"' is unknown.");
					break;
			}
		}
		
		public function get jointProperty() : Number {
			return _jointProperty;
		}

		public function get gapRatio() : Number {
			return _gapRatio;
		}

		public function get waitRatio() : Number {
			return _waitRatio;
		}	
	}
}
