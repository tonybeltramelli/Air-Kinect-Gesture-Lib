/* Copyright (c) 2012 Tony Beltramelli
 * 
 * Permission is hereby granted, free of charge, to any person 
 * obtaining a copy of this software and associated documentation 
 * files (the "Software"), to deal in the Software without 
 * restriction, including without limitation the rights to use, 
 * copy, modify, merge, publish, distribute, sublicense, and/or 
 * sell copies of the Software, and to permit persons to whom the 
 * Software is furnished to do so, subject to the following 
 * conditions:
 *	
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 *	
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
 * OTHER DEALINGS IN THE SOFTWARE.
*/
package com.tonybeltramelli.airkinect {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.tonybeltramelli.airkinect.userAction.AUserAction;
	import com.tonybeltramelli.airkinect.userAction.IUserAction;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ActionManager {
		private var _actions : Vector.<AUserAction>;
		private var _speed : int;

		public function ActionManager(speed : int) {
			_speed = speed;
			_actions = new Vector.<AUserAction>();
		}

		public function compute(user : User) : void {
			var i : int = _actions.length;
			while ( --i != -1 ) IUserAction(_actions[i]).compute(user);
		}

		public function add(action : AUserAction) : void {
			action.speed = _speed;
			_actions.push(action);
		}

		public function clean() : void {
			var i : int = _actions.length;
			while ( --i != -1 ) IUserAction(_actions[i]).clean();
			_actions = null;
		}
	}
}
