(
  ~allServers = [Server.local,Server.internal];
  ~allServers.collect({|serv|  

    ~synthFactory.("anatolian_grains",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar(a * xRate,0,xAdd,xMod)**e).tanh;
      p =BrownNoise.ar(x,t *.x a);
      h = a *.x t;
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h);
    },{[-1,1]/(1..4)},serv);
  });

(
 Routine {

   ~f.set(\gate,0);
   ~g.set(\gate,0);  

  ~f=Synth("anatolian_grains");
  ~f.setn(\a,[1,3/8,441/512,8/7]);
  ~f.setn(\t,[128,1.5**12]);
  ~f.set(\xRate,1/(3**8));
  ~f.set(\xAdd,1.exp);
  ~f.set(\xMod,2.exp);
  ~f.set(\amp,1);

  ~f.set(\gate,1);

  ~g=Synth("anatolian_grains");
  ~g.setn(\a,[21/16,4/3,3/7,1]);
  ~g.setn(\t,[1.5**12,128]);
  ~g.set(\xRate,1/(3**8));
  ~g.set(\xAdd,1.exp);
  ~g.set(\xMod,2.exp);
  ~g.set(\amp,1);

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



  
  ~h=Synth("anatolian_grains");
  ~h.setn(\a,[1,3/4,441/512,6/7]);
  ~h.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~h.set(\xRate,1/(3**8));
  ~h.set(\xAdd,1.exp);
  ~h.set(\xMod,2.exp);
  ~h.set(\gate,1);

  ~f.set(\gate,0);
  
  



)
