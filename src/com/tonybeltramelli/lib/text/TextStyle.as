package com.tonybeltramelli.lib.text {
	import com.tonybeltramelli.lib.utils.color.Color;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class TextStyle
	{
		public static function apply(textField : TextField, fontName : String, content : String = "", align : String = "", size : Number = 0, color : String = "", antiAlias : String = "", filters : Array = null) : void
		{
			var tformat : TextFormat = textField.getTextFormat();
			tformat.font = fontName;
			
			if(align != "") textField.autoSize = align;
			if(size != 0) tformat.size = size;
			if(color != "") tformat.color = Color.fix(color);
			if(antiAlias != "") textField.antiAliasType = antiAlias;
			if(filters != null) textField.filters = filters;
			
			if(fontName.indexOf("pt_st") != -1)
			{
				var a : Array = fontName.split("_");
				var sizeTf : String = a[a.length - 2];
				var sizefinal : uint = uint(sizeTf.slice(0, sizeTf.length - 2));
				tformat.size = sizefinal;
			}

			if(content != "") textField.htmlText = content;
			
			textField.setTextFormat(tformat);
			textField.defaultTextFormat = tformat;
		}

		public static function traceFonts() : void
		{
			var embededFonts : Array = Font.enumerateFonts();

			trace("----- AVAILABLE INTEGRATED FONTS : " + embededFonts.length + " -----");

			for (var i : int = 0; i < embededFonts.length; i++) {
				trace("--------");
				trace("   font " + (i + 1));
				trace("   fontName: '" + embededFonts[i].fontName + "'");
				trace("   fontStyle: '" + embededFonts[i].fontStyle + "'");
			}
			trace("------------------------------");
		}
	}
}
