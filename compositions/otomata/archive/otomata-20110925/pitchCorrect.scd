{|freq,k,i,p,j|
	freq = (freq > (2**15)).if({(freq / (2**((freq.log2.floor-(((i.factors.reverse[0].log.ceil))))))) },{freq});
	5.do({|x| (freq > (2**15)).if({freq = freq / (2**( i.factors.size.clip(2,i.log.ceil.asInt)))});});

	freq = (freq > (2**14)).if({(freq / (2**((freq.log2.floor-(((i.factors.reverse[0].log10.ceil))+2))))) },{freq});
	freq = (freq > (2**14)).if({(freq / (2**((freq.log2.floor-(((i.factors.reverse[0].log10.ceil))+2))))) },{freq});

	5.do({|x| (freq < (21)).if({freq = freq * (2**(i.factors.size))});});
	freq;
}
