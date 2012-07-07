//this is the piano/clarinet hybrid
//2 is the loudest, busiest
(
~ikatWhite1 = {|freq=120,n=([1,3,5,7,9]*3/4)|
  (0..3).do({|i|
      var p = (freq *.x (n) *.x ((1..16)* i.nthPrime).collect({|i|((2**14)+i)/(2**14)}));
      var t = ((freq/2)/ ((((16*i)+(0..15)).nthPrime)-1)).sort;
      p = p * (((1..8)*2)-1)/4;
      Server.all.collect({|serv|
           ~synthFactory.("ikat-white-1"++i,{|f=1,a=64,m=0.125,ss=0.125,sm=0.5,sa=0.5,r=1,w=0.5,v=16|

        SinOsc.ar(p*f * ((LFPulse.kr(m/(t*r*v),0,0.5,1,8))/8),0,(1/((p+8)*p.log2))*(LFPulse.kr(t*r,0,  SinOsc.kr(ss,0,sm,sa) +SinOsc.kr((m)/t,0,w,0),1,0) * a))};
        ,{({|i|1/(1+1)}!16)*.x[-1,1]},serv);

      })
  })
};
~ikatWhite1.(120,[1,3,5,7,9]*3/4);
)


(
~t.collect({|i,j|~t[j].set(\gate,0);});
~s.collect({|i,j|~s[j].set(\gate,0);});
~u.collect({|i,j|~u[j].set(\gate,0);});


~s.collect({|i,j|~s[j].set(\gate,0);});
~s = Array.fill(4);
~s.collect({|i,j|
  ~s[j]=Synth("ikat-white-1"++j);
  ~s[j].set(\gate,1);
  ~s[j].set(\atk,1,\rel,1);
});
~s.collect({|i,j|  ~s[j].set(\f,24/6);});
~s.collect({|i,j|~s[j].set(\amp,2/8);});


~u = Array.fill(4);
~u.collect({|i,j|
  ~u[j]=Synth("ikat-white-1"++j);
  ~u[j].set(\gate,1);
  ~u[j].set(\atk,1,\rel,1);
});
~u.collect({|i,j|  ~u[j].set(\f,(2401/2400)*24/6);});
~u.collect({|i,j|~u[j].set(\amp,2/8);});

~s.collect({|i,j|~s[j].set(\m,1/8);});
~u.collect({|i,j|~u[j].set(\m,1/4);});

~s.collect({|i,j|~s[j].set(\ss,3/512,\sa,0.0,\sm,0.5);});
~u.collect({|i,j|~u[j].set(\ss,2/512,\sa,0.25,\sm,0.25);});

~s.collect({|i,j|~s[j].set(\w,1/2);});
~u.collect({|i,j|~u[j].set(\w,1/2);});


~s.collect({|i,j|~s[j].set(\r,1/4);});
~u.collect({|i,j|~u[j].set(\r,1/4);});
~s.collect({|i,j|~s[j].set(\v,32);});
~u.collect({|i,j|~u[j].set(\v,32);});


//as t
~t = Array.fill(4);
~t.collect({|i,j|
  ~t[j]=Synth("ikat-white-1"++j);
  ~t[j].set(\gate,1);
  ~t[j].set(\atk,1,\rel,1);
});
~t.collect({|i,j|  ~t[j].set(\f,24/9);});
~t.collect({|i,j|~t[j].set(\amp,1.5/8);});

~t.collect({|i,j|~t[j].set(\ss,4/512,\sa,0.25,\sm,0.25);});
~t.collect({|i,j|~t[j].set(\m,1/8);});
~t.collect({|i,j|~t[j].set(\r,1/4);});
~t.collect({|i,j|~t[j].set(\w,1/4);});
~t.collect({|i,j|~t[j].set(\v,32);});

)





~ikatWhite2 = {|freq=128,n=([1/2,3/2,5/2,7/2,9/2] * 1.5)|
  (0..3).do({|i|
      var t,p = (((1..16)* i.nthPrime).collect({|i|((2**14)+i)/(2**14)}));
      p = p * (((1..8)*2)-1)/4;
      p= p *freq *.x (n);
      t = ((freq/2)/((0..p.size).nthPrime)).sort;
      Server.all.collect({|serv|
           ~synthFactory.("ikat-white-2"++i,{|f=1,a=64,m=0.125,ss=0.125,sm=0.5,sa=0.5,r=1,w=0.5,v=16|

        SinOsc.ar(p*f * ((LFPulse.kr(m/(t*r*v),0,0.5,1,8))/8),0,(1/((p+32)*p.log10))*(LFPulse.kr(t*r,0,  SinOsc.kr(ss,0,sm,sa) +SinOsc.kr((m)/t,0,w,0),1,0) * a * [1/2,2/3,1,1,1,1,1,1]))};
        ,{({|i|1/(1+1)}!16)*.x[-1,1]},serv);
      })
  })
};
~ikatWhite2.(128,[1/2,3/2,5/2,7/2,9/2] * 1.5);

//init function
{  
  ~t.collect({|i,j|~t[j].set(\gate,0);});
  ~s.collect({|i,j|~s[j].set(\gate,0);});
  ~u.collect({|i,j|~u[j].set(\gate,0);});


  ~s.collect({|i,j|~s[j].set(\gate,0);});
  ~s = Array.fill(4);
  ~s.collect({|i,j|
    ~s[j]=Synth("ikat-white-2"++j,nil,Server.local);
    ~s[j].set(\gate,1);
    ~s[j].set(\atk,1,\rel,1);
  });
  ~s.collect({|i,j|  ~s[j].set(\f,27/6);});
  ~s.collect({|i,j|~s[j].set(\amp,3/8);});


  ~u = Array.fill(4);
  ~u.collect({|i,j|
    ~u[j]=Synth("ikat-white-2"++j);
    ~u[j].set(\gate,1);
    ~u[j].set(\atk,1,\rel,1);
  });
  ~u.collect({|i,j|  ~u[j].set(\f,(2400/2400)*20/6);});
  ~u.collect({|i,j|~u[j].set(\amp,3/8);});

  ~s.collect({|i,j|~s[j].set(\m,1/8);});
  ~u.collect({|i,j|~u[j].set(\m,1/4);});

  ~s.collect({|i,j|~s[j].set(\ss,3/512,\sa,0.0,\sm,0.5);});
  ~u.collect({|i,j|~u[j].set(\ss,2/512,\sa,0.25,\sm,0.25);});

  ~s.collect({|i,j|~s[j].set(\w,1/2);});
  ~u.collect({|i,j|~u[j].set(\w,1/2);});


  ~s.collect({|i,j|~s[j].set(\r,1/4);});
  ~u.collect({|i,j|~u[j].set(\r,1/4);});
  ~s.collect({|i,j|~s[j].set(\v,64);});
  ~u.collect({|i,j|~u[j].set(\v,64);});


  //as t
  ~t = Array.fill(4);
  ~t.collect({|i,j|
    ~t[j]=Synth("ikat-white-2"++j);
    ~t[j].set(\gate,1);
    ~t[j].set(\atk,1,\rel,1);
  });
  ~t.collect({|i,j|  ~t[j].set(\f,27/9);});
  ~t.collect({|i,j|~t[j].set(\amp,2.5/8);});

  ~t.collect({|i,j|~t[j].set(\ss,4/512,\sa,0.5,\sm,0.25);});
  ~t.collect({|i,j|~t[j].set(\m,1/4);});
  ~t.collect({|i,j|~t[j].set(\r,1/4);});
  ~t.collect({|i,j|~t[j].set(\w,1/2);});
  ~t.collect({|i,j|~t[j].set(\v,32);});
}.value


~ikatWhite3 = {|freq=128,n=([1/2,3/2,5/2,7/2] * 1.5),name=("ikat-white-3")|
(0..3).do({|i|
    var p = (freq *.x (n) *.x ((1..16)* i.nthPrime).collect({|i|((2**14)+i)/(2**14)}));
    var t = ((freq/2)/((0..p.size).nthPrime)).sort;
    p = p * (((1..8)*2)-1)/4;
     Server.all.collect({|serv|
      ~synthFactory.(name++i,{|f=1,a=64,m=0.125,pm=1,pa=8, ss=0.125,sm=0.5,sa=0.5,r=1,w=0.5,v=16|

         SinOsc.ar(p*f * (((SinOsc.kr(m/(t*r*v),0,pm,pa).ceil*2)-1)/(pa*2)),0,(1/((p+8)*p.log2))*(LFPulse.kr(t*r,0,  SinOsc.kr(ss,0,sm,sa) +SinOsc.kr((m)/t,0,w,0),1,0) * a))};
         ,{({|i|1/(1+1)}!16)*.x[-1,1]},serv)
      })  
    })
};
~ikatWhite3.(128,[1/2,3/2,5/2,7/2] * 1.5);



(
~t.collect({|i,j|~t[j].set(\gate,0);});
~s.collect({|i,j|~s[j].set(\gate,0);});
~u.collect({|i,j|~u[j].set(\gate,0);});


~s.collect({|i,j|~s[j].set(\gate,0);});
~s = Array.fill(4);
~s.collect({|i,j|
  ~s[j]=Synth("ikat-white-3"++j,nil,Server.local);
  ~s[j].set(\gate,1);
  ~s[j].set(\atk,1,\rel,1);
});
~s.collect({|i,j|  ~s[j].set(\f,24/6);});
~s.collect({|i,j|~s[j].set(\amp,2/8);});


~u = Array.fill(4);
~u.collect({|i,j|
  ~u[j]=Synth("ikat-white-3"++j);
  ~u[j].set(\gate,1);
  ~u[j].set(\atk,1,\rel,1);
});
~u.collect({|i,j|  ~u[j].set(\f,(2401/2400)*24/6);});
~u.collect({|i,j|~u[j].set(\amp,2/8);});

~s.collect({|i,j|~s[j].set(\m,1/8);});
~u.collect({|i,j|~u[j].set(\m,1/4);});

~s.collect({|i,j|~s[j].set(\ss,3/256,\sa,0.0,\sm,0.5);});
~u.collect({|i,j|~u[j].set(\ss,2/256,\sa,0.25,\sm,0.25);});

~s.collect({|i,j|~s[j].set(\w,1/2);});
~u.collect({|i,j|~u[j].set(\w,1/2);});


~s.collect({|i,j|~s[j].set(\r,1/4);});
~u.collect({|i,j|~u[j].set(\r,1/4);});
~s.collect({|i,j|~s[j].set(\v,512);});
~u.collect({|i,j|~u[j].set(\v,512);});

~u.collect({|i,j|~u[j].set(\pa,4,\pm,4);});
~t.collect({|i,j|~t[j].set(\pa,4,\pm,4);});
~s.collect({|i,j|~s[j].set(\pa,4,\pm,4);});


//as t
~t = Array.fill(4);
~t.collect({|i,j|
  ~t[j]=Synth("ikat-white-3"++j);
  ~t[j].set(\gate,1);
  ~t[j].set(\atk,1,\rel,1);
});
~t.collect({|i,j|  ~t[j].set(\f,24/9);});
~t.collect({|i,j|~t[j].set(\amp,1.5/8);});

~t.collect({|i,j|~t[j].set(\ss,4/256,\sa,0.5,\sm,0.25);});
~t.collect({|i,j|~t[j].set(\m,1/4);});
~t.collect({|i,j|~t[j].set(\r,1/4);});
~t.collect({|i,j|~t[j].set(\w,1/2);});
~t.collect({|i,j|~t[j].set(\v,512);});

)
