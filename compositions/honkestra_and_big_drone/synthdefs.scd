
s = Server.internal;
~z.collect({|z|
z.options.numBuffers_(8192);
});
(
~z.collect({|z|

~synthFactory.("pink-honk",{|freq=128, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4,5,6,7],x=3,of=1|  var a = n *.x p ,
	b=SinOsc,
	f=a*freq,
	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x)),
	pn = PinkNoise;
	b.ar(f*r.ceil,b.ar(pn.ar(f.log2,f),0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));
},{[-1,1]},z);

//recursive modulator honkestra
~synthFactory.("r-honkestra",{|freq=128, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4,5,6,7],x=3,of=1|	var a = n *.x p ,
	b=SinOsc,
	f=a*freq,
	y=b.ar(1/freq*p,0,x,0).abs,
	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,y,y)),
	pn = PinkNoise;
	b.ar(pn.ar(f.log2,f),b.ar(pn.ar(f.log2,f),0,pi*b.ar(1/f,r,r)),64/(f*f.log2+32)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));
},{[-1,1]},z);

  //honkestra
  ~synthFactory.("honkestra",{|freq=128, n=#[1,2,3,4,5,6,7,8,9], p=#[1,2,3,4,5,6,7],x=3,of=1|	var a = n *.x p ,
  	b=SinOsc,
  	f=a*freq,
  	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x));
  	b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2+32)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));

  },{([-1,1]/(1..9)).sort},z);


  //lo filtered

  ~synthFactory.("honkestra2",{|freq=128, n=#[1,2,3,4,5,6], p=#[1,2,3,4,5,6,7],x=3,of=1|
  	var a = n *.x p ,
  	b=SinOsc,
  	f=a*freq,
  	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x)),
  	z = b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f+64)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));
  	RLPF.ar(z,(freq *.x n *.x p ).reverse,1/2,1);
  },{[-1,1]},z);

  //hi filtered
  ~synthFactory.("honkestra3",{|freq=128, n=#[1,2,3,4,5,6], p=#[1,2,3,4,5,6,7],x=3,of=1|
  	var a = n *.x p ,
  	b=SinOsc,
  	f=a*freq,
  	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x)),
  	z = b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f+64)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));
  	RHPF.ar(z,(freq *.x n *.x p),1/(1+p),1);
  },{[-1,1]},z);


  //big drone
  ~synthFactory.("big-drone",{|freq=120, n=#[1,2,3,4,5,6,7], p=#[0.5,0.66,1,2,3,4,6,8],x=3,of=4|
  	var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	r=b.ar(1/f,of/(1..f.size),b.ar(1/f.reverse,0,x,x));
  	b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1]},z);


    //big drone
    ~synthFactory.("medium-drone",{|freq=120, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4],x=3,of=4,m=1|
    	var a=p *.x n,
    	f=a*freq,
    	b=SinOsc,
    	r=b.ar(m/f,of/(1..f.size),b.ar(m/f.reverse,0,x,x));
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),32/(f*f.log)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1]},z);

})
);

//standalone big drone
/*    (a=[(1..8)/2].flat*.x[16,20,24,30,36]/16;f=a*120;b=SinOsc;r=b.ar(1/f,2*pi/(1..f.size),b.ar(1/f,0,3,3));{Splay.ar(b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),256/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),1,1,0.5)}.play;);

*/