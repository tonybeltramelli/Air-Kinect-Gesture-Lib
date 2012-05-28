package com.tonybeltramelli.lib.utils.color {

	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Color
	{
		public static function fix(xmlColor : String) : String
		{
			var submittedColor : String = xmlColor;
			var validColor : String;
			var pattern : RegExp = /#/;

			submittedColor = xmlColor.replace(pattern, "");

			pattern = /0x/;
			if (submittedColor.substring(0, 2) != "0x")
			{
				validColor = "0x" + submittedColor;
			} else {
				validColor = submittedColor;
			}

			return validColor;
		}

		public static function convertIt(c : uint) : Object
		{
			var hsvColor : Object;
			var rgb : Array;
			var hexColor : String;

			hsvColor = {};
			rgb = [0, 0, 0];
			hexColor = c.toString(16);

			if (hexColor.length == 1)
			{
				hexColor = "000000";
			} else if (hexColor.length == 4)
			{
				hexColor = "00" + hexColor;
			}

			rgb[0] = parseInt(hexColor.substr(0, 2), 16) / 255;
			rgb[1] = parseInt(hexColor.substr(2, 2), 16) / 255;
			rgb[2] = parseInt(hexColor.substr(4, 2), 16) / 255;

			var min : Number = rgb[0];
			if (rgb[1] < min)
			{
				min = rgb[1];
			}
			if (rgb[2] < min)
			{
				min = rgb[2];
			}

			var max : Number = rgb[0];
			if (rgb[1] > max)
			{
				max = rgb[1];
			}
			if (rgb[2] > max)
			{
				max = rgb[2];
			}

			hsvColor.v = max * 100;

			var deltaColor : Number = max - min;

			if (max != 0)
			{
				hsvColor.s = deltaColor / max * 100;
			} else {
				hsvColor.s = 0;
				hsvColor.h = -1;
			}

			if ( rgb[0] == max )
			{
				hsvColor.h = ( rgb[1] - rgb[2] ) / deltaColor;
			} else if ( rgb[1] == max )
			{
				hsvColor.h = 2 + ( rgb[2] - rgb[0] ) / deltaColor;
			} else {
				hsvColor.h = 4 + ( rgb[0] - rgb[1] ) / deltaColor;
			}
			hsvColor.h *= 60;

			if ( hsvColor.h < 0 )
			{
				hsvColor.h += 360;
			}

			return hsvColor;
		}

		public static function getColorMatrix(mc : DisplayObject) : Array
		{
			var f : Array = mc.filters, i : uint;
			for (i = 0; i < f.length; i++) {
				if (f[i] is ColorMatrixFilter)
				{
					return f[i].matrix;
				}
			}
			return null;
		}
	}
}
