(
~ikatTurquoiseCloud = {|freq=60, n=([1,3/2,5/2,15/4,9/4,45/8]), name="ikat-turquoise-cloud"|
  Server.all.collect({|serv|
    (0..3).do({|i|
    		var p = (freq *.x (n) *.x (((16*i)+1)..(16 * (i+1)))).sort;
    		var x = (64*i);
    		var t = (((64+x)..(127+x)) / (freq*2));
    		~synthFactory.(name++i,{|f=1,a=40,m=0.125,r=1,w=0.5|
    		SinOsc.ar(p*f,0,(1/((p+16)*p.log2))*(LFPulse.kr(t*r,0,   w + SinOsc.kr((m*r)/t,0,0.5,0),1,0) * a))};
    		,{({|i|i=i+1; i/16}!16)*.x[-1,1]},serv)
    })
  });
});
~ikatTurquoiseCloud.();
~ikatTurquoise = {|freq=60, n=([1,3/2,5/2,15/4,9/4,45/8]), name="ikat-turquoise"|
Server.all.collect({|serv|
  (0..3).do({|i|
  		var p = (freq *.x (n) *.x (((16*i)+1)..(16 * (i+1)))).sort;
  		var t = (p / freq);
  		t = ((freq/2)/(1..16)).sort *.x [1,1,1,1,1,1];
  		~synthFactory.(name++i,{|f=1,a=40,m=0.125,r=1,w=0.5|
  		SinOsc.ar(p*f,0,(1/((p+16)*p.log2))*(LFPulse.kr(t*r,0,   w + SinOsc.kr((m*r)/t,0,0.5,0),1,0) * a))};
  		,{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal)
  })
})
};
//opening blue band
~ikatTurquoise.();

~z.collect({|i,j|~z[j].set(\gate,0);});
~z = Array.fill(8);
~z.collect({|i,j|
	~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
	~z[j].set(\atk,j+30/10,\rel,j+1);
	~z[j].set(\gate,1);
});
~z.collect({|i,j|	~z[j].set(\f,18/18 * [1,(1.5**12)/128].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\r,8/[32,24].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\m,32/[32,48].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\w,[0.75].wrapAt(j));});

//this is for the first blue flame (pointding downwards)
~ikatTurquoise.(60,[1,3/2,21/8,7/2,9/4,49/9],"ikat-turquoise-0");

~z.collect({|i,j|~z[j].set(\gate,0);});
~z = Array.fill(8);
~z.collect({|i,j|
	~z[j]=Synth("ikat-turquoise-0"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
	~z[j].set(\gate,1);
	~z[j].set(\atk,j+10/10,\rel,j+1);
});
~z.collect({|i,j|	~z[j].set(\f,24/20 * [1,64/63].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\r,64/[48,24].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\m,64/[24,32].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\w,[0.75,0.75].wrapAt(j));});




)
(
Routine {

	~z.collect({|i,j|~z[j].set(\gate,0);});
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("pythagorean-intro"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\atk,4+j,\rel,j+2);
		~z[j].set(\gate,1);
	});
	~z.collect({|i,j|	~z[j].set(\f,20/16 * [1,(1.5**12)/128].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,32/[24,48].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,32/[4,8].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.25].wrapAt(j));});

	(15/4).wait;
	Routine {
		[20/16,20/18,20/20,24/20,25/20,27/20,24/20,20/20,20/16].collect({|item,step|
		~z.collect({|i,j|	~z[j].set(\f,item * [1,2401/2400].wrapAt(j));});
		((step+2) * 15/8).wait;
		})		
	}.play;
	(({|i|i}!10).sum*15/8).wait;


	~z.collect({|i,j|~z[j].set(\gate,0);});
	(15/8).wait;
	(15/2).wait;
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\atk,1,\rel,j+1);
		~z[j].set(\gate,1);
	});
	~z.collect({|i,j|	~z[j].set(\f,20/16 * [1,2401/2400].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,32/[32,16].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,32/[32,32].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.25].wrapAt(j));});
	(96*15/12).wait;
	
	~z.collect({|i,j|~z[j].set(\gate,0);});
	(6*15/12).wait;
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\atk,j+30/10,\rel,j+1);
		~z[j].set(\gate,1);
	});
	~z.collect({|i,j|	~z[j].set(\f,20/18 * [1,(1.5**12)/128].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,32/[32,48].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,32/[32,32].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.5].wrapAt(j));});
	(128*15/12).wait;
	~z.collect({|i,j|~z[j].set(\gate,0);});
	(6*15/12).wait;
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\gate,1);
		~z[j].set(\atk,j+20/10,\rel,j+1);
	});
	~z.collect({|i,j|	~z[j].set(\f,20/20 * [1,64/63].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,24/[32,24].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,24/[32,24].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.75,0.25].wrapAt(j));});

	(64*15/12).wait;
	~z.collect({|i,j|~z[j].set(\gate,0);});
	(8*15/12).wait;
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\gate,1);
		~z[j].set(\atk,j+10/10,\rel,j+1);
	});
	~z.collect({|i,j|	~z[j].set(\f,24/20 * [1,64/63].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,24/[48,24].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,4/[24,32].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.75,0.75].wrapAt(j));});

	(64*15/12).wait;
	~z.collect({|i,j|~z[j].set(\gate,0);});
	(10*15/12).wait;
	~z = Array.fill(8);
	~z.collect({|i,j|
		~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
		~z[j].set(\gate,1);
		~z[j].set(\atk,2*j+1,\rel,2*j+1);
	});
	~z.collect({|i,j|	~z[j].set(\f,25/20 * [1,64/63].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\r,8/[48,24].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\m,128/[32,64].wrapAt(j));});
	~z.collect({|i,j|~z[j].set(\w,[0.075,0.075].wrapAt(j));});
	(96*15/12).wait;
	~z.collect({|i,j|~z[j].set(\gate,0);});

}.play;
)
