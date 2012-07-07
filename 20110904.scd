(
var x,p,
a=[1,3/8,441/512,8/7],
e=1.exp,
o=(1323 / 1024) * (49/32),
b=SinOsc;a=a*.x a*.x (o**[1,2]);
x=(b.ar(a/(3**7),0,2.exp,2.exp).log**e).tan;
p =PinkNoise.ar(x,128*.x a);
{Mix.ar(Pan2.ar(b.ar(p *.x [1,SinOsc.kr(1/((3**7)*[1,3/8,441/512,8/7]),0,2-o,1)],b.ar(p,0,((pi**(e/x)).sin)**x)*pi,0.05/a),[-1,1]/(1..4)))}.scope;

)
(
  ~f = {|rMod,rAdd,rRate|
    var x,p,
    a=[1,3/8,441/512,8/7],h,
    e=1.exp,
    b=SinOsc;a=a*.x a*2;
    x=(b.ar(a/3600,a*pi,6.sqrt,3.sqrt)**e).tan;
    p =PinkNoise.ar(x,[128,1.5**12]*.x a);
    h = a *.x [128,129];
    {Mix.ar(Pan2.ar(b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h),[-1,1]/(1..4)))}.scope;
  }.value;
  
)
(
  ~allServers = [Server.local,Server.internal];
  ~allServers.collect({|serv|  

    ~synthFactory.("anatolian_grains",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar(a * xRate,0,xAdd,xMod)**e).tan;
      p =BrownNoise.ar(x,t *.x a);
      h = a *.x t;
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,6/h);
    },{[-1,1]/(1..4)},serv);
  });
  ~h=Synth("anatolian_grains");
  ~h.setn(\a,[1,3/8,441/512,8/7]);
  ~h.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~h.set(\xRate,1/(3**8));
  ~h.set(\xAdd,1.exp);
  ~h.set(\xMod,2.exp);
  ~h.set(\gate,1);

  ~f.set(\gate,0);



  ~f=Synth("anatolian_grains");
  ~f.setn(\a,[1,16/21,8/7,9/8]);
  ~f.setn(\t,[128,128 * (441/512) * (8/7)]);
  ~f.set(\xRate,1/81);
  ~f.set(\xAdd,5/8);
  ~f.set(\xMod,5/8);
  ~f.set(\gate,1);



  ~g=Synth("anatolian_grains");
  ~g.setn(\a,[1,2/3,8/7,9/8]);
  ~g.setn(\t,[128,1.5**12]);
  ~g.set(\xRate,1/81);
  ~g.set(\xAdd,5/8);
  ~g.set(\xMod,5/8);
  ~g.set(\gate,1);

  ~f.set(\gate,0);
  ~g.set(\gate,0);
  ~h.set(\gate,0);


(
 Routine {
  ~f=Synth("anatolian_grains");
  ~f.setn(\a,[1,3/8,441/512,8/7]);
  ~f.setn(\t,[128,1.5**12]);
  ~f.set(\xRate,1/(3**8));
  ~f.set(\xAdd,3.sqrt);
  ~f.set(\xMod,6.sqrt);
  ~f.set(\amp,1);

  ~f.set(\gate,1);

  ~g=Synth("anatolian_grains");
  ~g.setn(\a,[21/16,4/3,3/7,1]);
  ~g.setn(\t,[1.5**12,128]);
  ~g.set(\xRate,1/(3**8));
  ~g.set(\xAdd,81/441);
  ~g.set(\xMod,1);
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

//big drone
  ~synthFactory.("blob",{|freq=120,rs =1, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4,5,6],x=3,of=4,ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c = Blip,
  	r=b.ar(1/f,b.ar(tt,0,of,of)/a,b.ar(1/f.reverse,0,x,x)),
  	q=rs * r.sum;
	b.ar(f,c.ar(f,x,pi*b.ar(q/f,q,r)),(c.ar( (r+q).abs/ra,2+r,64,64)/(f*f.log2))*b.ar(a,b.ar(a,q,pi*b.ar(1/a,q,b.ar(1/a,q,a))),r,0))},{[-1,1]/(1..8)},serv);});


[ 3/2, 12/7, 1.483772277832, 	1,	9/8, 	8/7, 	1323/1024, 64/49,							c 	d    	d#   	e#         e##	
441**2, 3/2 ,12/7 , 441/256, 63/32, ]
f## 	   g    a#     a##        b#       


(1323 / 1024) * (49/64)
120*9/8

128/120