package com.tonybeltramelli.lib.utils.math {
	import flash.geom.Point;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class UMath {
		public static function percent(current : Number, total : Number) : Number {
			return (current * 100) / total;
		}
		
		public static function getLineEquation(p0 : Point, p1 : Point) : Object {
			var a : Number = (p1.y - p0.y) / (p1.x - p0.x);
			var b : Number = p1.y - a * p1.x;

			var o : Object = new Object();
			o.a = a;
			o.b = b;

			return o;
		}

		public static function boundaryRestrict(n : Number, min : Number, max : Number) : Number {
			if (n < min) {
				n = min;
			} else if (n > max) {
				n = max;
			}
			return n;
		}
		
		public static function accurateRound(n : Number, i : int) : Number
		{
			return Math.round(n*Math.pow(10,i))/Math.pow(10,i);
		}
		
		public static function getMaxValue(numbersToSort : Array) : Number {
			return Math.max.apply(null, numbersToSort);
		}

		public static function getMinValue(numbersToSort : Array) : Number {
			return Math.min.apply(null, numbersToSort);
		}
		
		public static function getMaxValueAndIndexV(numbersToSort : Vector.<Number>) : UMathResult
		{
			const VECTOR: Vector.<Number> = numbersToSort;
			var i: int = VECTOR.length;
			var maxValue : Number = 0;
			var maxI : int = 0;
			while( --i != -1 )
			{
				if(VECTOR[i] > maxValue)
				{
					maxValue = VECTOR[i];
					maxI = i;
				}
			}
			return new UMathResult(maxValue, maxI);
		}
		
		public static function getMinValueAndIndexV(numbersToSort : Vector.<Number>) : UMathResult
		{
			const VECTOR: Vector.<Number> = numbersToSort;
			var i: int = VECTOR.length;
			var minValue : Number = 2147483647;
			var minI : int = 0;
			while( --i != -1 )
			{
				if(VECTOR[i] < minValue)
				{
					minValue = VECTOR[i];
					minI = i;
				}
			}
			return new UMathResult(minValue, minI);
		}
		
		public static function average(values : Vector.<Number>) : Number
		{
			var i: int = values.length;
			var n : int = values.length;
			var total : int = 0;
			while( --i != -1 ) total += values[i];
			return total / n;
		}
	}
}
