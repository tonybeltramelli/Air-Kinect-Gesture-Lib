package com.tonybeltramelli.airkinect.userAction {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public interface IUserAction {
		function compute(user : User) : void
		function clean() : void
	}
}
