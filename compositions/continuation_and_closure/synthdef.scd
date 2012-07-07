z = Server.internal;
y =  Server.local;
~allServers = Server.all;
~allServers.collect({|x|x.boot});
~allServers.collect({|x|SynthDef("sine-phase",{|freq=100,bassCutoff=128,atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0, mr=1, ma=1, mm=1| Out.ar(0,Mix.ar(Pan2.ar(SinOsc.ar(  [1,1] *.x freq,SinOsc.ar(freq,0,SinOsc.kr(1/rel,0,rel.log2.abs),0),amp/(freq+bassCutoff)),pan)) * EnvGen.ar(Env.perc(atk,rel/2, 1, sus),gate, doneAction:2) );}).load(x)});


~allServers.collect({|x|SynthDef("just-sine",{|freq=100,bassCutoff=128,atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0, mr=1, ma=1, mm=1| Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] *.x freq,0,amp/(freq+bassCutoff)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(x)});

~allServers.collect({|x| ~synthFactory.("medium-drone",{|freq=120, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4],x=3,of=4,m=1|
  	var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	r=b.ar(m/f,of/(1..f.size),b.ar(m/f.reverse,0,x,x));
b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),32/(f*f.log)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1]},x);
});





//big drone
~allServers.collect({|x|  
  ~synthFactory.("big-drone",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4,],x=3,of=4, ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c=FSinOsc,
  	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x));
	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(f.log2,f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/(ra),r,2,2)**3)/(f))*b.ar(a/p,b.ar(a,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..8)},x);
});



~allServers = [Server.local,Server.internal];
//big drone
~allServers.collect({|serv|  
  ~synthFactory.("blob",{|freq=120,rs =1, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4,5,6],x=3,of=4,ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c = Blip,
  	r=b.ar(1/f,b.ar(tt,0,of,of)/a,b.ar(1/f.reverse,0,x,x)),
  	q=rs * r.sum;
	b.ar(f,c.ar(f,x,pi*b.ar(q/f,q,r)),(c.ar( (r+q).abs/ra,2+r,64,64)/(f*f.log2))*b.ar(a,b.ar(a,q,pi*b.ar(1/a,q,b.ar(1/a,q,a))),r,0))},{[-1,1]/(1..8)},serv);});

//alter the synthdef for phase - rel+atk = phase depth
z.freeAll;