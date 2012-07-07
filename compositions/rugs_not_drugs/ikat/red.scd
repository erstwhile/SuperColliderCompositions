//20110531
~ikatRed = {|freq=60, n=([1,3/2,5/2,15/4]),name="ikat-red"|
(0..3).do({|i|
		var p = (freq *.x (n) *.x (((16*i)+1)..(16 * (i+1))));
		var t = (p / (freq));
		Server.all.collect({|serv|
  		~synthFactory.(name++i,{|f=1,a=64,m=0.125,r=1,w=0.5|
  		SinOsc.ar(p*f,0,(1/((p+16)*p.log2))*(LFPulse.kr(t*r,0,   w + SinOsc.kr((m)/t,0,0.5,0),1,0) * a))};
  		,{SinOsc.kr(t,0,1,-0.5)},serv)	  
		})
})
};
~ikatRed.(64,[1,3/8,8/7,441/512],"ikat-red-yellow");
~ikatRed.(60,[1,3/2,5/4,15/8],"ikat-red");

(
Routine {
	
	~z.collect({|i,j|~z[j].set(\gate,0);});
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-red"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\gate,1);
		~z[j].set(\atk,2,\rel,2);
		~z[j].set(\f,1);
	});
	~z.collect({|i,j|	~z[j].set(\f,20/16 * [1,(1.5**12)/128].wrapAt(j));});
	~z.collect({|i,j|	~z[j].set(\a,[40].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,24/[64,32].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,24/[48,32].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.5].wrapAt(j));});

}.play;
)
(
Routine {
	
	~z.collect({|i,j|~z[j].set(\gate,0);});
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-red-yellow"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,[Server.internal].wrapAt(j));
		~z[j].set(\gate,1);
		~z[j].set(\atk,2,\rel,2);
		~z[j].set(\f,1);
	});
	~z.collect({|i,j|	~z[j].set(\f,21/16 * [1,(1.5**12)/128].wrapAt(j));});
	~z.collect({|i,j|	~z[j].set(\a,[40].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,16/[48,64].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,32/[48,64].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.5].wrapAt(j));});

}.play;
)
