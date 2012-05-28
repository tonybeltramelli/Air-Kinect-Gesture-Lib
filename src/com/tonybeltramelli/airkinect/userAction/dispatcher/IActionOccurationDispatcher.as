package com.tonybeltramelli.airkinect.userAction.dispatcher {
	import flash.events.Event;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public interface IActionOccurationDispatcher {
		function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void;
		function addSignalListener(listener : Function) : void
		function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		function removeSignalListener(listener : Function) : void
		function dispatch(event : Event) : void;
	}
}