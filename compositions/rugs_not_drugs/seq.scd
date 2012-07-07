//band 1, orange, tourquoise, with some yellow.  
~ikatTurquoiseCloud.(60,[1,3/2,5/2,15/4,9/4,10/4],"ikat-turquoise-cloud");
~ikatTurquoise.(60,[1,3/2,5/2,15/4,9/4,45/8],"ikat-turquoise");

~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(1);

~r = Routine {
  
  ~clock.tempo_(10/9);

  ~zc = Array.fill(8);
  ~zc.collect({|i,j|
  	~zc[j]=Synth("ikat-turquoise-cloud"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
  	~zc[j].set(\atk,16+j,\rel,j+2);
  	~zc[j].set(\gate,1);
  });
  ~zc.collect({|i,j|	~zc[j].set(\f,10/9 * [1,(1.5**12)/128].wrapAt(j));});
  ~zc.collect({|i,j|~zc[j].set(\r,32/[24,48].wrapAt(j));});
  ~zc.collect({|i,j|~zc[j].set(\m,32/[4,8].wrapAt(j));});
  ~zc.collect({|i,j|~zc[j].set(\w,[0.5].wrapAt(j));});

  ~zc.collect({|i,j|	~zc[j].set(\f,10/9* [1,(1.5**12)/128].wrapAt(j));});

80.wait;  
  
~z.collect({|i,j|~z[j].set(\gate,0);});
~z = Array.fill(8);
~z.collect({|i,j|
	~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
	~z[j].set(\atk,(j*8)+8,\rel,32);
	~z[j].set(\gate,1);
});
~z.collect({|i,j|	~z[j].set(\f,[1,(1.5**12)/128].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\r,16/[32,24].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\m,32/[32,48].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\w,[0.5].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\a,[40].wrapAt(j));});

~clock.play(Routine {
  8.wait;
  ~z.collect({|i,j|	~z[j].set(\f,10/9 * [1,(1.5**12)/128].wrapAt(j));});
16.wait;
  ~z.collect({|i,j|	~z[j].set(\f,10/8 * [1,(1.5**12)/128].wrapAt(j));});
4.wait;
~z.collect({|i,j|	~z[j].set(\f,10/9 * [1,(1.5**12)/128].wrapAt(j));});
},0);


256.wait;

~z.collect({|i,j|~z[j].set(\gate,0);});
~z = Array.fill(8);
~z.collect({|i,j|
	~z[j]=Synth("ikat-turquoise"++([0,0,1,1,2,2,3,3].wrapAt(j)) ,nil,Server.internal);
	~z[j].set(\atk,(j*4)+4,\rel,32);
	~z[j].set(\gate,1);
});
~z.collect({|i,j|	~z[j].set(\f,10/9 * [1,(1.5**12)/128].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\r,16/[32,24].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\m,32/[32,48].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\w,[0.5].wrapAt(j));});
~z.collect({|i,j|~z[j].set(\a,[40].wrapAt(j));});

  ~clock.play(Routine {
  16.wait;
    ~z.collect({|i,j|	~z[j].set(\f,10/8 * [1,(1.5**12)/128].wrapAt(j));});
  4.wait;
  ~z.collect({|i,j|	~z[j].set(\f,10/9 * [1,(1.5**12)/128].wrapAt(j));});

  },0);

};

~clock.play(~r,0);



64.wait;
~s = Array.fill(4);
~s.collect({|i,j|
	~s[j]=Synth("ikat-orange"++j,nil,Server.internal);
	~s[j].set(\gate,1);
	~s[j].set(\atk,1,\rel,1);
	~s[j].set(\f,1);
});
~s.collect({|i,j|~s[j].set(\f,16/16);});
~s.collect({|i,j|~s[j].set(\r,1/2);});
~s.collect({|i,j|~s[j].set(\ss,1/288);});
~s.collect({|i,j|~s[j].set(\sa,-0.4);});
~s.collect({|i,j|~s[j].set(\sm,1.0);});
~s.collect({|i,j|~s[j].set(\m,4);});
~s.collect({|i,j|~s[j].set(\w,0.5);});

~s.collect({|i,j|~s[j].set(\a,60);});
32.wait;
~s.collect({|i,j|~s[j].set(\gate,0);});

32.wait;



}.play;

~band1Orange = {|f=1.25,r=0.5,m=8,w=0.5,a=60,atk=8,rel=8,dur=32,name="ikat-orange"|
  var s;
  s = Array.fill(4);
  s.collect({|i,j|
  	s[j]=Synth(name++j,nil,Server.internal);
  	s[j].set(\gate,1);
  	s[j].set(\atk,atk,\rel,rel);
  });
  s.collect({|i,j|s[j].set(\f,f);});
  s.collect({|i,j|s[j].set(\r,r);});
  s.collect({|i,j|s[j].set(\ss,1/64);});
  s.collect({|i,j|s[j].set(\sa,-0.4);});
  s.collect({|i,j|s[j].set(\sm,1.0);});
  s.collect({|i,j|s[j].set(\m,m);});
  s.collect({|i,j|s[j].set(\w,w);});

  s.collect({|i,j|s[j].set(\a,a);});
//  dur.wait;
//  s.collect({|i,j|s[j].set(\gate,0);});
  s;
};

~ikatOrange.(60,[1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256],"ikat-orange");
~ikatOrange.(60,[1,3/4,5/2,15/4,1,9/16,25/4,15/8],"ikat-orange1");
~ikatOrange.(60,[1,3/4,5/2,15/4,45/8,9/16,25/4,15/8],"ikat-orange2");
~ikatOrange.(60,[1,3/2,5/2,15/4,45/8,9/8,25/4,75/8],"ikat-orange3");

~s =~band1Orange.(dur: 256,f:8/7,a:120, w:0.25,name:"ikat-orange");
~s.collect (_.set(\a,192));
~s.collect (_.set(\r,1));
~s.collect (_.set(\m,1));
~s.collect (_.set(\w,0.5));
~s.collect (_.set(\ss,1/64));
~s.collect (_.set(\sa,1/4));
~s.collect (_.set(\sm,1/2));

~s.collect (_.set(\gate,0));

Routine {~band1Yellow.(8/7,60,1/72,1.5,256)}.play;

~clock.play(Routine{~s =~band1Orange.(dur: 256,f:8/7)},0);
~s.collect {|i|i.set(\f,1)};
~band1Yellow = {|f=1,freq=60,xr=1,xh=1,dur=32|
  ~clock.play(Routine {
    ~y = Array.fill(32);
    ~a = [1,3/4,5/2,15/4];
    ~a = ~a *.x ~a *2 *.x [1,(1.5**12)/128];
    ~a.collect({|f,i|
    	~y[i] = Synth("ikat-yellow-darker");
    	~y[i].set(\atk,2);
    	~y[i].set(\rel,12);
    	~y[i].set(\gate,1);
    });  
    ~y.collect({|d,i|d.set(\freq,freq *  ~a[i] * f);});
    ~y.collect({|d|d.set(\amp,16);});
    ~y.collect({|d|d.set(\xHeight,xh);});
    ~y.collect({|d|d.set(\xRate,f * (xr));});
    dur.wait;
    ~y.collect({|d|d.set(\gate,0);})
  },0);
};
~clock.play(Routine{
  ~band1Yellow.(10/9,60,1/128,2,32);
    48.wait;
  ~band1Yellow.(5/4,60,1/32,3,16);
    24.wait;
  ~band1Yellow.(5/4,60,1/64,3,16);
    24.wait;
  ~band1Yellow.(1,60,1/64,1,48);
    64.wait;
  ~band1Yellow.(8/7,60,1/72,1.5,48);
    64.wait;
},0); 
