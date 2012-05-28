package com.tonybeltramelli.airkinect.debug {
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.tonybeltramelli.lib.debug.AppPerf;
	import com.tonybeltramelli.lib.display.ASprite;
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Shape;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KinectDebugger extends ASprite {
		private const _WIDTH : int = 320;
		private const _HEIGHT : int = 240;
		//
		private var _kinect : Kinect;
		private var _depthBitmap : Bitmap;
		private var _rgbBitmap : Bitmap;
		private var _skeleton : Shape;
		private var _mask : Shape;
		private var _appPerf : AppPerf;
		//
		private var _displayRGB : Boolean;
		private var _displayDepth : Boolean;
		private var _displayJoints : Boolean;
		private var _displaySkeleton : Boolean;
		private var _displayPerf : Boolean;

		public function KinectDebugger(kinect : Kinect, displaySkeleton : Boolean = true, displayJoints : Boolean = true, displayDepth : Boolean = true, displayRGB : Boolean = true, displayPerf : Boolean = true) {
			_kinect = kinect;
			_displaySkeleton = displaySkeleton;
			_displayJoints = displayJoints;
			_displayDepth = displayDepth;
			_displayRGB = displayRGB;
			_displayPerf = displayPerf;
			super(true);
		}

		override protected function _onStage() : void {
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, _WIDTH, _HEIGHT);
			graphics.endFill();
			
			if(_displayDepth)
			{
				_depthBitmap = new Bitmap();
				addChild(_depthBitmap);
				_kinect.addEventListener(CameraImageEvent.DEPTH_IMAGE_UPDATE, _drawDepthBitmap);
			}
			
			if(_displayRGB)
			{
				_rgbBitmap = new Bitmap();
				if(_displayDepth) 
				{
					_rgbBitmap.alpha = 0.5;
					_rgbBitmap.blendMode = BlendMode.OVERLAY;
				}
				addChild(_rgbBitmap);
				_kinect.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, _drawRGBBitmap);
			}
				
			_skeleton = new Shape();
			addChild(_skeleton);
			_mask = new Shape();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRect(0, 0, _WIDTH, _HEIGHT);
			_mask.graphics.endFill();
			addChild(_mask);
			_skeleton.mask = _mask;
			
			if(_displayPerf)
			{
				_appPerf = new AppPerf();
				addChild(_appPerf);
			}
			
			_positioning();
		}

		private function _drawDepthBitmap(event : CameraImageEvent) : void {
			_depthBitmap.bitmapData = event.imageData;
			_positioning();
		}

		private function _drawRGBBitmap(event : CameraImageEvent) : void {
			_rgbBitmap.bitmapData = event.imageData;
			_positioning();
		}

		override protected function _onResize() : void {
			_positioning();
		}

		public function draw(user : User) : void {
			_skeleton.graphics.clear();

			if(_displaySkeleton)
			{
				_skeleton.graphics.lineStyle(2, 0x50ae64);
				_drawLineBetweenJoints(user, "head", "neck");
				_drawLineBetweenJoints(user, "neck", "torso");
				_drawLineBetweenJoints(user, "torso", "waist");
	
				_drawLineBetweenJoints(user, "left_shoulder", "right_shoulder");
	
				_drawLineBetweenJoints(user, "left_shoulder", "left_elbow");
				_drawLineBetweenJoints(user, "left_elbow", "left_wrist");
				_drawLineBetweenJoints(user, "left_wrist", "left_hand");
				_drawLineBetweenJoints(user, "left_hand", "left_fingertip");
	
				_drawLineBetweenJoints(user, "right_shoulder", "right_elbow");
				_drawLineBetweenJoints(user, "right_elbow", "right_wrist");
				_drawLineBetweenJoints(user, "right_wrist", "right_hand");
				_drawLineBetweenJoints(user, "right_hand", "right_fingertip");
	
				_drawLineBetweenJoints(user, "waist", "left_hip");
				_drawLineBetweenJoints(user, "waist", "right_hip");
	
				_drawLineBetweenJoints(user, "left_hip", "left_knee");
				_drawLineBetweenJoints(user, "left_knee", "left_ankle");
				_drawLineBetweenJoints(user, "left_ankle", "left_foot");
	
				_drawLineBetweenJoints(user, "right_hip", "right_knee");
				_drawLineBetweenJoints(user, "right_knee", "right_ankle");
				_drawLineBetweenJoints(user, "right_ankle", "right_foot");
			}
			
			if(_displayJoints)
			{
				for each (var joint : SkeletonJoint in user.skeletonJoints) {
					_skeleton.graphics.beginFill(0xd11df2);
					_skeleton.graphics.drawCircle(joint.depthPosition.x, joint.depthPosition.y, 4);
					_skeleton.graphics.endFill();
				}
			}
			
			_positioning();
		}

		private function _drawLineBetweenJoints(user : User, from : String, to : String) : void {
			_skeleton.graphics.moveTo(user.getJointByName(from).depthPosition.x, user.getJointByName(from).depthPosition.y);
			_skeleton.graphics.lineTo(user.getJointByName(to).depthPosition.x, user.getJointByName(to).depthPosition.y);
		}

		private function _positioning() : void {
			if(_displayRGB)
			{
				_rgbBitmap.width = _WIDTH;
				_rgbBitmap.height = _HEIGHT;
			}

			x = stage.stageWidth - _WIDTH - 20;
			y = stage.stageHeight - _HEIGHT - 20;
			
			if(_displayPerf) _appPerf.x = _WIDTH - _appPerf.width;
		}

		override protected function _outStage() : void {
			if(_displayDepth) _kinect.removeEventListener(CameraImageEvent.DEPTH_IMAGE_UPDATE, _drawDepthBitmap);
			if(_displayRGB) _kinect.removeEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, _drawRGBBitmap);
		}
	}
}
