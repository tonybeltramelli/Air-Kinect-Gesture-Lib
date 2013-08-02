package com.tonybeltramelli.KinectGestureLibTest {
	import flashx.textLayout.formats.TextAlign;

	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;
	import com.tonybeltramelli.airkinect.ActionManager;
	import com.tonybeltramelli.airkinect.debug.KinectDebugger;
	import com.tonybeltramelli.airkinect.userAction.dispatcher.ActionSignalDispatcher;
	import com.tonybeltramelli.airkinect.userAction.event.KinectGestureEvent;
	import com.tonybeltramelli.airkinect.userAction.gesture.HorizontalSwipe;
	import com.tonybeltramelli.airkinect.userAction.gesture.LeftSwipe;
	import com.tonybeltramelli.airkinect.userAction.gesture.VerticalSwipe;
	import com.tonybeltramelli.airkinect.userAction.gesture.settings.part.GesturePart;
	import com.tonybeltramelli.airkinect.userAction.movement.JumpMovement;
	import com.tonybeltramelli.lib.text.TextStyle;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	
	[SWF(backgroundColor="0xcfcfcf")]
	public class KinectGestureLibTest extends Sprite {
		private var _kinect : Kinect;
		private var _debugger : KinectDebugger;
		private var _actionManager : ActionManager;
		private var _textField : TextField;
		
		public function KinectGestureLibTest() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.nativeWindow.visible = true;
			stage.frameRate = 60;
			
			if(Kinect.isSupported())
			{
				_build();
			}
		}
		
		private function _build() : void
		{
			//create a new textfield to display the actions detections
			_textField = new TextField();
			TextStyle.apply(_textField, "_sans", "", TextAlign.LEFT, 24, "#656565");
			addChild(_textField);
			
			_kinect = Kinect.getDevice();

			var settings : KinectSettings = new KinectSettings();
			settings.skeletonEnabled = true;
			//if you want to display RGB and depth layers, don't forget to set you Kinect settings this way 
			//settings.rgbEnabled = true;
			//settings.depthEnabled = true;

			_kinect.start(settings);
			_kinect.addEventListener(DeviceEvent.STARTED, _started);

			//kinect feedback to display skeleton and joints
			//if you want to enabled RGB and depth layers, don't forget to set you Kinect settings as line 55 
			_debugger = new KinectDebugger(_kinect, true, true, false, false);
			addChild(_debugger);
			
			//instantiation of our ActionManager with the stage frame rate in parameter in order to compute the gestures analysis
			_actionManager = new ActionManager(stage.frameRate);
			
			//creation of a gesture to track the left swipe with the left hand
			//the detection will dispatch a KinectGestureEvent.LEFT_SWIPE in this case
			var rightHandLeftSwipe : LeftSwipe = new LeftSwipe(GesturePart.RIGHT_HAND);
			rightHandLeftSwipe.dispatcher.addEventListener(KinectGestureEvent.LEFT_SWIPE, _leftSwipeWithRightHandOccured);
			//then, if you need to remove your event Listener, you can do it this way
			//rightHandLeftSwipe.dispatcher.removeEventListener(KinectGestureEvent.LEFT_SWIPE, _leftSwipeWithRightHandOccured);
			
			//by default, the dispatcher of all AUserAction will be an EventDispatcher but you can also use
			//the AS3 Signals by passing an instance of ActionSignalDispatcher to the AUserAction instance
			var jumpMovement : JumpMovement = new JumpMovement(new ActionSignalDispatcher());
			jumpMovement.dispatcher.addSignalListener(_jumpMovementOccured);
			//for a signal dispatcher, you can remove your listener this way
			//jumpMovement.dispatcher.removeSignalListener(_jumpMovementOccured);
			
			//rather than create two gestures (UpSwipe and DownSwipe for example) you can use
			//a VerticalSwipe to handle two gestures in only one instance
			var leftHandVerticalSwipe : VerticalSwipe = new VerticalSwipe(GesturePart.LEFT_HAND);
			leftHandVerticalSwipe.dispatcher.addEventListener(KinectGestureEvent.UP_SWIPE, _upSwipeWithLeftHandOccured);
			leftHandVerticalSwipe.dispatcher.addEventListener(KinectGestureEvent.DOWN_SWIPE, _downSwipeWithLeftHandOccured);
			//remove event listener like shown below
			//leftHandVerticalSwipe.dispatcher.removeEventListener(KinectGestureEvent.UP_SWIPE, _upSwipeWithLeftHandOccured);
			//leftHandVerticalSwipe.dispatcher.removeEventListener(KinectGestureEvent.DOWN_SWIPE, _downSwipeWithLeftHandOccured);
			
			//if you want to use Signal dispatcher with a two gestures handler (HorizontalSwipe, VerticalSwipe or DepthSwipe)
			//you can listen to your signal callback with the method below
			var leftFootHorizontalSwipe : HorizontalSwipe = new HorizontalSwipe(GesturePart.LEFT_FOOT, new ActionSignalDispatcher());
			leftFootHorizontalSwipe.dispatcher.addSignalListener(_horizontalLeftFootSwipeDirectionOne);
			ActionSignalDispatcher(leftFootHorizontalSwipe.dispatcher).addSecondSignalListener(_horizontalLeftFootSwipeDirectionTwo);
			//with the same logic, you can easily remove your signal listener
			leftFootHorizontalSwipe.dispatcher.removeSignalListener(_horizontalLeftFootSwipeDirectionOne);
			ActionSignalDispatcher(leftFootHorizontalSwipe.dispatcher).removeSecondSignalListener(_horizontalLeftFootSwipeDirectionTwo);
			
			//in order to works, don't forget to add your gestures and / or movements to your ActionManager instance
			_actionManager.add(rightHandLeftSwipe);
			_actionManager.add(jumpMovement);
			_actionManager.add(leftHandVerticalSwipe);
			_actionManager.add(leftFootHorizontalSwipe);	
		}
		
		private function _started(event : DeviceEvent) : void {
			_kinect.removeEventListener(DeviceEvent.STARTED, _started);
			addEventListener(Event.ENTER_FRAME, _enterFrame);
		}

		private function _enterFrame(event : Event) : void
		{
			//choose between 1 or 2
			
			//1 process every users
			for each(var user : User in _kinect.users)
			{
				//draw the kinect feedback in the debugger
				_debugger.draw(user);
				
				//ask your ActionManager to compute and analyze user's actions
				_actionManager.compute(user);	
			}
			
			//2 process only one user
			if(_kinect.users.length != 0)
			{
				//get the nearest user only
				var uniqueUser : User = _getUniqueUser(_kinect.users);
			
				//draw the kinect feedback in the debugger
				_debugger.draw(uniqueUser);
				
				//ask your ActionManager to compute and analyze user's actions
				_actionManager.compute(uniqueUser);
			}
			
			_positioning();
		}
		
		private function _getUniqueUser(usersWithSkeleton : Vector.<User>) : User {
			var i : int = 0;
			var userNumber : int = usersWithSkeleton.length;
			var user : User = usersWithSkeleton[i];

			if (userNumber > 1) {
				for (i = 0; i < userNumber; i++)
				{	
					if(usersWithSkeleton[i].position.world.z < user.position.world.z)
					{
						user = usersWithSkeleton[i];
					}
				}
			}
			
			return user;
		}
		
		private function _leftSwipeWithRightHandOccured(event : KinectGestureEvent) : void
		{
			_textField.text = "Left hand left swipe detected !";
		}
		
		private function _jumpMovementOccured() : void
		{
			_textField.text = "Jump movement detected !";
		}
		
		private function _upSwipeWithLeftHandOccured(event : KinectGestureEvent) : void
		{
			_textField.text = "Right hand up swipe detected !";
		}

		private function _downSwipeWithLeftHandOccured(event : KinectGestureEvent) : void
		{
			_textField.text = "Right hand down swipe detected !";
		}
		
		private function _horizontalLeftFootSwipeDirectionOne() : void
		{
			_textField.text = "Left foot vertical swipe direction one detected !";
		}

		private function _horizontalLeftFootSwipeDirectionTwo() : void
		{
			_textField.text = "Left foot vertical swipe direction two detected !";
		}
		
		private function _positioning() : void
		{
			_textField.x = stage.stageWidth/2 - _textField.width/2;
			_textField.y = 10;
		}
	}
}
