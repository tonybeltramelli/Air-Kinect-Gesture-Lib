package com.tonybeltramelli.airkinect.userAction.dispatcher {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ActionEventDispatcher extends EventDispatcher implements IActionOccurationDispatcher {
		public function ActionEventDispatcher(target : IEventDispatcher = null) {
			super(target);
		}
		
		public override function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function addSignalListener(listener : Function) : void
		{
			throw new Error("--> Error : addSignalListener can not be use with ActionEventDispatcher, use addEventListener instead.");
		}
		
		public override function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			super.removeEventListener(type, listener, useCapture);
		}
		
		public function removeSignalListener(listener : Function) : void
		{
			throw new Error("--> Error : removeSignalListener can not be use with ActionEventDispatcher, use removeEventListener instead.");
		}
		
		public function dispatch(event : Event) : void
		{
			super.dispatchEvent(event);
		}
	}
}
