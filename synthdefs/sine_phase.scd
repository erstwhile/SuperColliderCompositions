
~synthFactory.("simple-phase2-1",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,pr=0,pm=0|
var a=(1..2)*.x n,
f=a*freq,
b=SinOsc,
r=b.ar(1/f,0,b.ar(pr,0,pm,p));
b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1] /.x (1..2)},Server.local);

~synthFactory.("simple-phase4-1",{|freq = 128,n=#[1,2,3,4],p=4,pr=0,pm=0|
	var a=(1..4)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,0,b.ar(pr,0,pm,p));
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))  },
{[1,-1] /.x (1..4)},Server.local);

~synthFactory.("simple-phase2",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
	var a=(1..2)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f* b.ar(f*fm,0,fa),0,pi*b.ar(1/f,r,r)),(96/(f*f.log2))*b.ar(m*a.reverse,b.ar(a.reverse,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa));},{[1,-1]/.x(1..2)},Server.local);

~synthFactory.("simple-phase4",{|freq=96, n=#[1,2,3,4],p=4,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
var	a=(1..4) *.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f * b.ar(f*fm,0,fa),0,pi*b.ar(1/f,r,r)),(64/(f*f.log2))*b.ar(m*a.reverse,b.ar(a.reverse,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa))},{[-1,1]/.x(1..4)},Server.local);


~synthFactory.("simple-phase8",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,of=1,m=1,am=2,aa=(-1)|
	var a=(1..8)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(m*a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa));},
{[1,-1] /.x(1..8)}, Server.local);

~synthFactory.("base-drone",{|freq = 128,m=1|
	var a=[(1..64)].flat,
	f=a*freq,
	b=SinOsc;
	b.ar(f,0,b.ar((m)/a,0,2)/(f*f.log2));},
{[-1,1]/.x(1..16)},Server.local);
