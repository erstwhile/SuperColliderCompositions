~ikatOrange ={ |freq=72,n=([1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256]),name="ikat-orange"|
  Server.all.collect({|serv|
    (0..3).do({|i|
    		var p = (freq *.x (n) *.x (((16*i)+1)..(16 * (i+1))));
    		var t = (p / (freq*8)).reverse;
    		~synthFactory.(name++i,{|f=1,a=64,m=0.125,ss=1,sm=0.5,sa=0.5,r=1,w=0.5|
    		Splay.ar(SinOsc.ar(p*f,0,(1/((p+32)))*(LFPulse.kr(t*r,0,  SinOsc.kr(ss,0,sm,sa) +SinOsc.kr((m)/t,0,w,0),1,0) * a)),1,1,0)};
    		,[-1,1],serv)
      })
  })
};
~ikatOrange.(60,[1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256],"ikat-orange");

(
Routine {
	~s.collect({|i,j|~s[j].set(\gate,0);});
	~s = Array.fill(4);
	~s.collect({|i,j|
		~s[j]=Synth("ikat-orange"++j,nil,Server.internal);
		~s[j].set(\gate,1);
		~s[j].set(\atk,1,\rel,1);
		~s[j].set(\f,1);
	});
	~s.collect({|i,j|~s[j].set(\f,16/16);});
	~s.collect({|i,j|~s[j].set(\r,1/1);});
	~s.collect({|i,j|~s[j].set(\ss,1/288);});
	~s.collect({|i,j|~s[j].set(\sa,-0.4);});
	~s.collect({|i,j|~s[j].set(\sm,1.0);});
	~s.collect({|i,j|~s[j].set(\m,4);});
	~s.collect({|i,j|~s[j].set(\a,180);});
}.play;
)
