package com.tonybeltramelli.airkinect.userAction.dispatcher {
	import org.osflash.signals.Signal;

	import flash.events.Event;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ActionSignalDispatcher implements IActionOccurationDispatcher {
		private var _signal : Signal;
		private var _secondSignal : Signal;
		
		public function ActionSignalDispatcher()
		{
			_signal = new Signal();
		}
		
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			throw new Error("--> Error : addEventListener can not be use with ActionSignalDispatcher, use addSignalListener instead.");
		}
		
		public function addSignalListener(listener : Function) : void
		{
			_signal.add(listener);
		}
		
		public function addSecondSignalListener(listener : Function) : void
		{
			_secondSignal = new Signal();
			_secondSignal.add(listener);
		}
		
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			throw new Error("--> Error : removeEventListener can not be use with ActionSignalDispatcher, use removeSignalListener instead.");
		}
		
		public function removeSignalListener(listener : Function) : void
		{
			_signal.remove(listener);
		}
		
		public function removeSecondSignalListener(listener : Function) : void
		{
			_secondSignal.remove(listener);
		}
		
		public function dispatch(event : Event) : void
		{
			_signal.dispatch();
			event = null;
		}
		
		public function dispatchSecond() : void
		{
			_secondSignal.dispatch();
		}
	}
}
