(
  ~allServers = [Server.local,Server.internal];
  ~allServers.collect({|serv|  

    ~synthFactory.("ikat_yellow",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =BrownNoise.ar(x.abs.log / base.log,t *.x a);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h);
    },{[-1,1]/(1..4)},serv);

    ~synthFactory.("ikat_yellow_lower",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =BrownNoise.ar(x.abs.log / base.log,h);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h);
    },{[-1,1]/(1..4)},serv);
    

    //log(abs(tan(sin(x)*x)))
    ~synthFactory.("test",{|xHeight = 20, xRate = 1,freq=32|
      var b = SinOsc, x = LFTri.ar(xRate,0,xHeight),
      r = ((x.sin)*x).tan.abs.log;
      p = PinkNoise.ar(r,freq);
      b.ar(freq, b.ar(p,0,r), 1 / freq);
    },{[-1,1]},serv);

  });

//{(SinOsc.ar(100,0,15).sin * SinOsc.ar(100,0,15)).tan.abs.log}.plot


(
  Server.internal.freeAll;

  ~a = [1,3/8,8/7,441/512];
  ~a = ~a *.x ~a *2;
  Routine {
    ~a.collect({|f|
    	var x;
    	x = Synth("test");
    	x.set(\freq,128 * f);
    	x.set(\amp,16);
    	x.set(\xRate,1/2048);
    	x.set(\xHeight,8);
    	x.set(\gate,1);
    });  
  }.play;


  ~a = [1,3/8,8/7,441/512];
  ~a = ~a *.x ~a *2;
  Routine {
    ~a.collect({|f|
    	var x;
    	x = Synth("test");
    	x.set(\freq,128 * f);
    	x.set(\amp,16);
    	x.set(\xRate,1/2048);
    	x.set(\xHeight,2);
    	x.set(\gate,1);
    });  
  }.play;


)

(
 Routine {

   ~f.set(\gate,0);
   ~g.set(\gate,0);  

  ~f=Synth("ikat_yellow");
  ~f.setn(\a,[1,3/8,441/512,8/7]);
  ~f.setn(\t,[128,1.5**12]);
  ~f.set(\xRate,1/(3**8));
  ~f.set(\aExp,0);
  ~f.set(\xAdd,1.exp);
  ~f.set(\xMod,1.exp);
  ~f.set(\base,9);
  ~f.set(\amp,1);
  ~f.set(\gate,1);

  ~g=Synth("ikat_yellow_lower");
  ~g.setn(\a,[21/16,4/3,3/7,1]);
  ~g.setn(\t,[128 * (441/512) * (8/7),128]);
  ~g.set(\xRate,1/(3**8));
  ~g.set(\aExp,2);
  
  ~g.set(\xAdd,1);
  ~g.set(\xMod,14/49);
  ~g.set(\base,9);
  ~g.set(\amp,1.25);
  ~g.set(\gate,1);


  Routine {
    5.do({|x|
      var z = [8,7,9,7,8].wrapAt(x),
      w = [6,4,5,4,6].wrapAt(x);
      x.postln;
      [~f,~g].collect({|d|d.set(\xRate,(1/3**z))});  
      (3**w).wait;
    })
  }.play;

  ((3**[6,4,5,4,6]).sum).wait;
  ~f.set(\gate,0);
  ~g.set(\gate,0);  

}.play;
)
9/49

441/9

441*9



  
  ~h=Synth("ikat_yellow");
  ~h.setn(\a,[1,3/8,441/512,8/7]);
  ~h.setn(\t,[128,1.5**12]);
  ~h.set(\xRate,1/(3**7));
  ~h.set(\xAdd,3.sqrt);
  ~h.set(\xMod,6.sqrt);
  ~h.set(\gate,1);

  ~g=Synth("ikat_yellow");
  ~g.setn(\a,[1,3/7,21/16,4/3]);
  ~g.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~g.set(\xRate,1/(3**7));
  ~g.set(\xAdd,3.sqrt);
  ~g.set(\xMod,6.sqrt);
  ~g.set(\gate,1);


  ~h.set(\gate,0);
  ~g.set(\gate,0);
  
  



)
