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
