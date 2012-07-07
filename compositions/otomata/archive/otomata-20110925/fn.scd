{|m,n|
		{|x|		
			var t = x / 512, out;
			out = m.(t) * n;
			((out >= 0 or: {out <= 0}).not).if({1},{out});
		}
	}
