{
~allServers = [Server.local,Server.internal];	

~allServers.collect({|x|  
  ~synthFactory.("big-drone1",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4],x=3,of=4, ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c=FSinOsc,
  	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x));
	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(r.sum**(f.log2 / 8192.log2),f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/ra,r,2,2)**3)/f)*b.ar(a,b.ar(r.sum,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..6)},x);


  ~synthFactory.("big-drone",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4],x=3,of=4, ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c=FSinOsc,
  	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x));
	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(f.log2,f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/ra,r,2,2)**3)/f)*b.ar(a/p,b.ar(a,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..6)},x);


    ~synthFactory.("big-drone2",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4],x=3,of=4, ra=3,tt=1|
  	  var a=p *.x n,
    	f=a*freq,
    	b=SinOsc,
    	c=FSinOsc,
    	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x)),
    	t = c.ar(tt,pi/2,1/2,1/2);
  	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(r.sum**(f.log2 / 8192.log2),f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/ra,r,2,2)**3)/f)*b.ar(a/(p**t) ,b.ar(a+(r.sum)**t,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..6)},x);

});


}
