//Rugs not drugs, #1
(
~synthFactory.("simple-phase2-1",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,pr=0,pm=0|
var a=(1..2)*.x n,
f=a*freq,
b=SinOsc,
r=b.ar(1/f,0,b.ar(pr,0,pm,p));
b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1] /.x (1..2)},Server.internal);

~synthFactory.("simple-phase4-1",{|freq = 128,n=#[1,2,3,4],p=4,pr=0,pm=0|
	var a=(1..4)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,0,b.ar(pr,0,pm,p));
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))  },
{[1,-1] /.x (1..4)},Server.internal);

~synthFactory.("simple-phase2",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
	var a=(1..2)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f* b.ar(f*fm,0,fa),0,pi*b.ar(1/f,r,r)),(96/(f*f.log2))*b.ar(m*a.reverse,b.ar(a.reverse,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa));},{[1,-1]/.x(1..2)},Server.internal);

~synthFactory.("simple-phase4",{|freq=96, n=#[1,2,3,4],p=4,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
var	a=(1..4) *.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f * b.ar(f*fm,0,fa),0,pi*b.ar(1/f,r,r)),(64/(f*f.log2))*b.ar(m*a.reverse,b.ar(a.reverse,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa))},{[-1,1]/.x(1..4)},Server.internal);


~synthFactory.("simple-phase8",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,of=1,m=1,am=2,aa=(-1)|
	var a=(1..8)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(m*a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),am,aa));},
{[1,-1] /.x(1..8)}, Server.internal);

~synthFactory.("base-drone",{|freq = 128,m=1|
	var a=[(1..64)].flat,
	f=a*freq,
	b=SinOsc;
	b.ar(f,0,b.ar((m)/a,0,2)/(f*f.log2));},
{[-1,1]/.x(1..16)},Server.internal);


)

(
//1,1,2,3,5,8,13,8,5,3,2,1,1
Routine {
	//1
	"1".postln;
	~a = Synth("base-drone");
	~a.set(\freq,60);
	~a.set(\atk,60); 
	~a.set(\m,15/16);
	~a.set(\gate,1);
	~a.set(\amp,9);
	(64*16/15).wait;
	//1
	"1".postln;
	~b = Synth("base-drone");
	~b.set(\freq,30);
	~b.set(\atk,60);
	~b.set(\m,15/16);
	~b.set(\gate,1);
	~b.set(\amp,4);
	
	~c = Synth("base-drone");
	~c.set(\freq,90);
	~c.set(\atk,60);
	~c.set(\gate,1);
	~c.set(\amp,4);
	~b.set(\m,15/16);
	
	(64*16/15).wait;
	//2
	"2".postln;

	~s2 = Synth("simple-phase2");
	~s2.set(\of,1);
	~s2.set(\m,1/32);
	~s2.set(\atk,60);
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	~s4.set(\atk,60);
	~s2.set(\p,3);
	~s4.set(\p,4);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	
	~s2.setn(\n,1/16*[1,2,3,4,5,6,7]*15/16);
	~s4.setn(\n,1/16*[1,2,3,4]*15/32);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);
	
	~s2.set(\rel,120);
	~s4.set(\rel,120);
	(128 *16/15).wait;
	//3
	"3".postln;

	~s2.set(\gate,0);
	~s4.set(\gate,0);
	~s2 = Synth("simple-phase2");
	~s2.set(\of,1);
	~s2.set(\m,1/32);
	~s2.set(\atk,20);
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	~s4.set(\atk,20);
	~s2.set(\p,4);
	~s4.set(\p,6);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	
	~s2.setn(\n,1/16*[1,2,3,4,5,6,7]*15/16);
	~s4.setn(\n,1/16*[1,2,3,4]*15/32);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);
	
	(192*16/15).wait;
	//5
	"5".postln;

	~s2.set(\rel,180);
	~s4.set(\rel,180);
	
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	
	~s2 = Synth("simple-phase2");
	~s2.setn(\n,[1,3/2,5/8,3,5/2,3/8,15/8]*15/16);
	~s2.set(\of,1);
	~s2.set(\m,1/16);
	
	~s2.set(\atk,30);
	~s2.set(\gate,1);
	
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.setn(\n,[1/2,3/2,10/4,1/2]*15/16);
	~s4.set(\atk,30);
	~s4.set(\gate,1);
	~s4.set(\m,1/16);
	
	~s2.set(\p,6);
	~s4.set(\p,8);
	
	~s2.setn(\n,1/16*[1,3/2,9/4,27/16,81/16,243/128,729/64]*15/16);
	~s4.setn(\n,1/16*[1,3/2,9/4,27/4]*15/32);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	(320* 16/15).wait;
	//8
	"8".postln;

	~s2.set(\gate,0);
	~s4.set(\gate,0);
	~s8.set(\gate,0);
	
	~s2 = Synth("simple-phase2");
	~s2.set(\of,1);
	~s2.set(\m,1/32);
	
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	
	~s2.set(\p,6);
	~s4.set(\p,8);
	
	~s2.setn(\n,1/128*[16,18,20,24,30,32,36]*15/16);
	~s2.set(\fm,2);
	~s4.set(\fm,1/2);
	~s2.set(\aa,-1);
	~s4.set(\aa,-1);
	
	~s4.set(\am,2);
	~s2.set(\am,2);
	
	~s2.set(\fa,1/4);
	~s4.set(\fa,1/4);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	
	~s4.setn(\n,1/64*[8,10,12,15]*15/32);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,256*8);
	~s4.set(\freq,256*8);
	
	
	~s8 =Synth("simple-phase8");
	~s8.set(\freq,256);
	~s8.setn(\n,1/64*[16,18,20,24,30,32,36]*15/16);
	~s8.set(\of,0);
	~s8.set(\p,3);
	~s8.set(\aa,1);
	~s8.set(\am,2);
	~s8.set(\amp,0.15);
	~s8.set(\gate,1);
	(512*(16/15)).wait;
	
	~s2.set(\rel,180);
	~s4.set(\rel,180);
	~s8.set(\rel,180);
	//13
	"13".postln;

	//then the first s2,s4 for 13 minutes
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	~s8.set(\gate,0);
	
	~s2 = Synth("simple-phase2");
	~s2.set(\of,1);
	~s2.set(\m,1/32);
	~s2.set(\atk,180);
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	~s4.set(\atk,180);
	~s2.set(\p,3);
	~s4.set(\p,4);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	
	~s2.setn(\n,1/16*[1,2,3,4,5,6,7]*15/16);
	~s4.setn(\n,1/16*[1,2,3,4]*15/32);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);











	
	~s2.set(\rel,120);
	~s4.set(\rel,120);
	
	~ss2 = Synth("simple-phase2-1");
	~ss2.setn(\n,[1,3/2,5/8,3,5/2,3/4,15/8]*15/16);
	~ss2.set(\p,2);
	~ss2.set(\atk,1);
	~ss2.set(\gate,1);
	
	~ss4 = Synth("simple-phase4-1");
	~ss4.set(\freq,96);
	~ss4.setn(\n,[1/2,3/2,10/4,4]*15/16);
	~ss4.set(\p,4);
	~ss4.set(\atk,4);
	~ss4.set(\amp,3/3);
	~ss2.set(\amp,3/3);
	~ss4.set(\gate,1);
	~ss2.setn(\n,[1,3/2,27/16,2/3,9/4,3/2,5/4]*15/16);
	~ss4.setn(\n,[1/2,2/3,9/8,1/2]*15/16);

	

	(832*16/15).wait;
	
	
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	~ss2.set(\rel,832);
	~ss4.set(\rel,832);
	~ss2.set(\gate,0);
	~ss4.set(\gate,0);
	
	//8
	"8".postln;

	//silence here - let s2, s4 fade out
	(192*16/15).wait;
	//put synths here, 3 mins slow fade up
	~s8 =Synth("simple-phase8");
	~s8.set(\freq,64);
	~s8.setn(\n,[1,3/2,5/8,3,5/2,3/4,15/8]*15/16);
	~s8.set(\of,0);
	~s8.set(\p,3);
	~s8.set(\aa,0);
	~s8.set(\am,2);
	~s8.set(\atk,180);
	~s8.set(\amp,0.15);
	~s8.set(\gate,1);
	(320*16/15).wait;
	~s8.set(\rel,180);
	~s8.set(\gate,0);
	
	//5
	"5".postln;

	//put synths here
	~s2 = Synth("simple-phase2");
	~s2.setn(\n,[1,3/2,5/8,3,5/2,3/8,15/8]*15/16);
	~s2.set(\of,1);
	~s2.set(\m,1/16);
	
	~s2.set(\atk,30);
	~s2.set(\gate,1);
	
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.setn(\n,[1/2,3/2,10/4,1/2]*15/16);
	~s4.set(\atk,30);
	~s4.set(\gate,1);
	~s4.set(\m,1/16);
	
	~s2.set(\p,6);
	~s4.set(\p,8);
	
	~s2.setn(\n,1/16*[1,3/2,9/4,27/16,81/16,243/128,729/64]*15/16);
	~s4.setn(\n,1/16*[1,3/2,9/4,27/4]*15/32);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	~s2.set(\rel,128);
	~s4.set(\rel,128);
	
	(320*16/15).wait;
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	
	//3
	"3".postln;
	(192*(16/15)).wait;
	
	//2
	"2".postln;
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	
	~s2 = Synth("simple-phase2");
	~s2.set(\of,1);
	~s2.set(\m,1/32);
	~s2.set(\atk,20);
	~s4 = Synth("simple-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	~s4.set(\atk,20);
	~s2.set(\p,3);
	~s4.set(\p,4);
	~s2.set(\amp,2/4);
	~s4.set(\amp,2/4);
	
	~s2.setn(\n,1/16*[1,2,3,4,5,6,7]*15/16);
	~s4.setn(\n,1/16*[1,2,3,4]*15/32);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,128*16);
	~s4.set(\freq,128*16);
	~s2.set(\rel,120);
	~s4.set(\rel,120);
	
	(128*16/15).wait;
	~s2.set(\gate,0);
	~s4.set(\gate,0);
	
	//1
	"1".postln;
	~b.set(\rel,60);
	~c.set(\rel,60);
	~b.set(\gate,0);
	~c.set(\gate,0);
	(64*16/15).wait;
	//1
	"1".postln;
	~a.set(\rel,60);
	~a.set(\gate,0);
	(64*16/15).wait;
}.play;


)


