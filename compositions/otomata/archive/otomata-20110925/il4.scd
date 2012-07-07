{|x|
		var t = x / 512, out;
		out = (t%pi).abs**((t*pi).tan%t) * (t.tan %t)* ~notes.size;
		(out.isFloat).if({out},{0});
	}
