package com.tonybeltramelli.lib.debug {
	import com.tonybeltramelli.lib.display.ASprite;
	import com.tonybeltramelli.lib.text.TextStyle;
	import com.tonybeltramelli.lib.utils.math.UMath;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flashx.textLayout.formats.TextAlign;



	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AppPerf extends ASprite {
		private var _textFieldFPS : TextField;
		private var _maxFPSLine : Shape;
		private var _graphics : Shape;
		private var _last : uint;
		private var _increment : uint = 0;
		private var _bars : Vector.<Number>;
		private var _max : int;
		//
		private const _WIDTH : int = 100;
		private const _HEIGHT : int = 40;
		private const _LIMIT : int = 18;
		private const _MAX_POS : int = 20;

		public function AppPerf() {
			_last = getTimer();
			_bars = new Vector.<Number>();
			
			graphics.beginFill(0xc2c2c2);
			graphics.drawRect(0, 0, _WIDTH, _HEIGHT);
			graphics.endFill();
		}

		override protected function _onStage() : void {
			_max = stage.frameRate;
			
			_textFieldFPS = new TextField();
			TextStyle.apply(_textFieldFPS, "_sans", "", TextAlign.LEFT, 10, "#333333");
			_setText(0);
			addChild(_textFieldFPS);
			
			_graphics = new Shape();
			addChild(_graphics);
			
			_maxFPSLine = new Shape();
			_maxFPSLine.graphics.lineStyle(1, 0xe0e0e0);
			_maxFPSLine.graphics.moveTo(0, _HEIGHT-_MAX_POS);
			_maxFPSLine.graphics.lineTo(_WIDTH, _HEIGHT-_MAX_POS);
			addChild(_maxFPSLine);

			addEventListener(Event.ENTER_FRAME, _update);
		}

		private function _update(event : Event) : void {
			_increment ++;
			var now : uint = getTimer();
			var delta : uint = now - _last;
			if (delta >= 1000) {
				var currentFPSValue : Number = _increment / delta * 1000;
				const CURRENT_FPS : Number = UMath.accurateRound(currentFPSValue, 5);
				_setText(CURRENT_FPS);
				_increment = 0;
				_last = now;
				_bars.push((CURRENT_FPS*_MAX_POS)/_max);
			}
			
			_graphics.graphics.clear();
			
			var i : int;
			var n : int = _bars.length;
			
			for(i = 0; i < n; ++i)
			{
				_graphics.graphics.beginFill(0x0086ed);
				_graphics.graphics.drawRect((i*2), _HEIGHT, 1, -_bars[i]);
				_graphics.graphics.endFill();
			}
			
			if(_bars.length == _WIDTH/2)
			{
				_bars = null;
				_bars = new Vector.<Number>();
			}
		}
		
		private function _setText(currentFPSValue : Number) : void
		{
			if(currentFPSValue <= _LIMIT){
				TextStyle.apply(_textFieldFPS, "_sans", "", TextAlign.LEFT, 10, "#e53c3c");
			}else if(currentFPSValue >= stage.frameRate)
			{
				TextStyle.apply(_textFieldFPS, "_sans", "", TextAlign.LEFT, 10, "#0fa127");
			}else{
				TextStyle.apply(_textFieldFPS, "_sans", "", TextAlign.LEFT, 10, "#333333");
			}
			_textFieldFPS.text = currentFPSValue + " / "+stage.frameRate+" FPS";
		}

		override protected function _outStage() : void {
			removeEventListener(Event.ENTER_FRAME, _update);
		}
	}
}
