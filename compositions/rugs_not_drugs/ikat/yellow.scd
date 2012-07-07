  ~allServers = [Server.local,Server.internal];
  ~allServers.collect({|serv|  
  ~synthFactory.("ikat-yellow",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =BrownNoise.ar(x.abs.log / base.log,t *.x a);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h);
    },{[-1,1]/(1..4)},serv);

    ~synthFactory.("ikat-yellow-lower",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =PinkNoise.ar(x.abs.log / base.log,h);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,1/64);
    },{[-1,1]/(1..4)},serv);
    

    ~synthFactory.("ikat-yellow-lower-woven",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =PinkNoise.ar(x.abs.log / base.log,h);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,1/64);
    },{[-1,1]/(1..4)},serv);


    //log(abs(tan(sin(x)*x)))
    ~synthFactory.("ikat-yellow-darker",{|xHeight = 20, xRate = 1,freq=32|
      var b = SinOsc, x = LFTri.ar(xRate,0,xHeight),
      r = ((x.sin)*x).tan.abs.log;
      p = PinkNoise.ar(r,freq);
      
      Pan2.ar(b.ar(freq, b.ar(p,0,r), 1 / 64),(freq.log2*pi).sin);
    },{[-1,1]},serv);

  });



  ~h=Synth("ikat-yellow");
  ~h.setn(\a,[1,3/8,441/512,8/7]);
  ~h.setn(\t,[128,1.5**12]);
  ~h.set(\xRate,1/(3**6));
  ~h.set(\xAdd,1/2);
  ~h.set(\xMod,3/2);
  ~h.set(\gate,1);

  ~g=Synth("ikat-yellow");
  ~g.setn(\a,[1,3/7,21/32,2/3]);
  ~g.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~g.set(\xRate,1/(3**6));
  ~g.set(\xAdd,1/2);
  ~g.set(\xMod,3/2);
  ~g.set(\gate,1);

  ~h.set(\gate,0);
  ~g.set(\gate,0);
  
  
  
  
  ~g.set(\aExp,1);
  ~g.set(\aExp,1);
  ~h.set(\xRate,1/(3**9));//+hour.log.floor
  ~g.set(\xRate,1/(3**9));//+hour.log.floor
  
  ~g.set(\xAdd,3.sqrt);
  ~h.set(\xAdd,3.sqrt);
  ~g.set(\xMod,6.sqrt);
  ~h.set(\xMod,6.sqrt);
  ~h.set(\xRate,1/(3**8));
  ~g.set(\xRate,1/(3**8));
  
  ~h=Synth("ikat-yellow-lower-woven");
  ~h.setn(\a,[1,3/8,441/512,8/7]);
  ~h.setn(\t,[128,1.5**12]);
  ~h.set(\xRate,1/(3**7));//+hour.log.floor
  ~h.set(\xAdd,1.exp);//[1/2,3.sqrt,1.exp]
  ~h.set(\aExp,0);//[0,2]
  ~h.set(\xMod,2.exp);//[3/2,6.sqrt,2.exp]
  ~h.set(\gate,1);

  ~g=Synth("ikat-yellow-lower-woven");
  ~g.setn(\a,[1,3/7,21/16,4/3]);
  ~g.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~g.set(\xRate,1/(3**7));
  ~g.set(\xAdd,1.exp);
  ~g.set(\aExp,0);
  ~g.set(\xMod,2.exp);
  ~g.set(\gate,1);
  
  
  
  ~i=Synth("ikat-yellow-lower-woven");
  ~i.setn(\a,[3/7,21/8,2/3,16/7]);
  
  ~i.setn(\t,[120,120*513/512]);
  ~i.set(\xRate,1/(3**9));
  ~i.set(\xAdd,1.exp);
  ~i.set(\aExp,1/2);
  ~i.set(\xMod,2.exp);
  ~i.set(\gate,1);
  ~i.set(\base,9);

  ~h=Synth("ikat-yellow-lower-woven");
  ~h.setn(\a,[147/128,7/4,16/7,441/256]);
  ~h.setn(\t,[120*513/512,120]);
  ~h.set(\xRate,1/(3**9));
  ~h.set(\xAdd,1);
  ~h.set(\aExp,1/2);
  ~h.set(\xMod,9/49);
  ~h.set(\gate,1);
  ~h.set(\base,9);

  