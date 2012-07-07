~synthFactory.("base-drone",{|freq = 128,m=1|
	var a=[((1..32)*2)-1].flat,
	f=a*freq,
	b=SinOsc;
	b.ar(f,0,b.ar((m)/a,0,2)/(f*f.log2));},
{[-1,1]/.x(1..16)},Server.internal);

~synthFactory.("syncd-phase4",{|freq=96, ap = #[1,2,3,4],n=#[1,2,3,4],p=4,pp=0,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
var a =	ap *.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(m,b.ar(m,1/a,1/a)*of,p,pp);
	b.ar(f ,b.ar(f,0,pi*b.ar(m,r,r)),(64/(f*f.log2))*b.ar(m*a.reverse,b.ar(m,r,pi**b.ar(m,r,b.ar(1/a,r,a))),am,aa))},{[-1,1]/.x(1..4)},Server.internal);
	
~synthFactory.("simple-phase2-1",{|freq = 128,n=#[1,2,3,4,5,6,7],p=2,pr=0,pm=0|
var a=(1..2)*.x n,
f=a*freq,
b=SinOsc,
r=b.ar(1/f,0,b.ar(pr,0,pm,p));
b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi**b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1] /.x (1..2)},Server.internal);

~synthFactory.("simple-phase4-1",{|freq = 128,n=#[1,2,3,4],p=4,pr=0,pm=0|
	var a=(1..4)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,0,b.ar(pr,0,pm,p));
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi**b.ar(1/a,r,b.ar(1/a,r,a))),1))  },
{[1,-1] /.x (1..4)},Server.internal);



~synthFactory.("simple-phase8",{|freq = 128,ap = #[1,2,3,4,5,6,7,8],n=#[1,2,3,4,5,6,7],p=2,of=1,m=1,am=2,aa=(-1)|
	var a=ap*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,b.ar(1/f,1/a,1/a)*of,p);
	b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(m*a,b.ar(a,r,pi**b.ar(m,r,b.ar(1/a,r,a))),am,aa));},
{[1,-1] /.x(1..8)}, Server.internal);


(

~play = {|x|
	x.postln;
	"s4/5".postln;
	~s4 = Synth("syncd-phase4");
	~s4.set(\of,0);
	~s4.set(\m,2/3**x);
	~s4.set(\p,0/2);
	~s4.set(\aa,0);
	~s4.set(\am,4);
	~s4.set(\rel,(1.5**x));

	~s4.set(\amp,2/4);

	~s4.set(\gate,1);
	~s4.set(\freq,128*2);
	
	~s4.setn(\n,[1,(2*((3**x) / (3**x).nextPowerOfTwo)),9/4,3/4]);
	~s4.setn(\ap,[[1,3/2,9/8,27/16],[1,3/4,4,3]].wrapAt(x));

	~s5 = Synth("syncd-phase4");
	~s5.set(\of,1);
	~s5.set(\m,2/3**x);
	~s5.set(\p,1/2);
	~s5.set(\aa,0);
	~s5.set(\am,4);
	~s5.set(\rel,(1.5**x));
	~s5.set(\atk,((16)+(1.5**x)));
	~s5.set(\amp,2/4);
	~s5.set(\gate,1);
	~s5.set(\freq,128*2);
	
	~s4.setn(\n,[1,(2*((3**x) / (3**x).nextPowerOfTwo)),9/4,3/4]);
	~s5.setn(\ap,[[1,3/2,9/8,27/16],[1,3/4,4,3]].wrapAt(x));
	


	((16)+(1.5**x)).wait;
	~s4.set(\rel,	((16)+(1.5**x)));
	~s4.set(\gate,0);

	"s3".postln;
	~s3 = Synth("syncd-phase4");
	~s3.set(\of,1);
	~s3.set(\m,2/3**x);
	~s3.set(\p,1);
	~s3.set(\rel,(1.5**x));
	~s3.set(\aa,0);
	~s3.set(\am,4);
	~s3.set(\amp,2/4);

	~s3.set(\gate,1);
	~s3.set(\freq,128);
	
	~s3.setn(\n,[1,3/2,9/4,2/4]);
	~s3.setn(\ap,[1,3/2,9/4,27/8]);
	Routine {
		((16)+(1.5**x)).wait;
		~s3.setn(\ap,[1,3/2,10/4,27/8]);
	}.play;

	((16)+(1.5**x)).wait;
	((16)+(1.5**x)).wait;
	~s2 = Synth("syncd-phase4");
	x.postln;
	"s2".postln;
	
	~s2.set(\of,1);
	~s2.set(\m,2/3**(6+x));
	~s2.set(\p,(x+1).log2.ceil);
	~s2.set(\aa,0);
	~s2.set(\am,4);
	~s2.set(\amp,3/8);

	~s2.set(\gate,1);
	~s2.set(\freq,128/2);
	
	~s2.setn(\n,[8,10,12+x,15]/8);
	~s2.setn(\ap,[1,2,3,4]);


	((16)+(1.5**x)).wait;
	((16)+(1.5**x)).wait;
	~s2.set(\rel,((16)+(1.5**x)));
	~s2.set(\gate,0);
	~s5.set(\gate,0);
	~s3.set(\gate,0);
};

Routine {
	
12.do({|x|

	~play.(x);
});
}.play;
)

	~s4 = Synth("syncd-phase4");
	~s4.set(\of,1);
	~s4.set(\m,2/3**(5+x));
	~s4.set(\p,1);
	~s4.set(\aa,0);
	~s4.set(\am,4);
	~s4.set(\amp,3/8);

	~s4.set(\gate,1);
	~s4.set(\freq,128*3/2);
	
	~s4.setn(\n,[27/32,3/2,10/4,1]);
	~s4.setn(\ap,[1,3/4,4,3]);
	~s3 = Synth("syncd-phase4");
	~s3.set(\of,1);
	~s3.set(\m,2/3**(5+x));
	~s3.set(\p,2);
	~s3.set(\aa,0);
	~s3.set(\am,4);
	~s3.set(\amp,3/8);

	~s3.set(\gate,1);
	~s3.set(\freq,128*2);
	~s3.setn(\n,[1,3/2,10/4,27/32]);
	~s3.setn(\ap,[1,(1.5**x) / (1.5**x).nextPowerOfTwo,4,3/4]);

	((16)+(1.5**x)).wait;
	~s2.set(\rel,((16)+(1.5**x)));
	~s2.set(\gate,0);
	
	((16)+(1.5**x)).wait;
	((16)+(1.5**x)).wait;
	~s4.set(\gate,0);
	~s3.set(\gate,0);

)

	~ss2 = Synth("simple-phase2-1");
	~ss2.set(\p,2);
	~ss2.set(\atk,1);
	~ss2.set(\gate,1);
	
	~ss4 = Synth("simple-phase4-1");
	~ss4.set(\freq,96);
	~ss4.set(\p,4);
	~ss4.set(\atk,4);
	~ss4.set(\amp,2/3);
	~ss2.set(\amp,2/3);
	~ss4.set(\gate,1);
	~ss2.setn(\n,[1,3/2,27/16,2/3,9/4,3/2,5/4]*16/16);
	~ss4.setn(\n,[1/2,2/3,9/8,1/2]*16/16);



	128.wait;
	~s8 =Synth("simple-phase8");
	~s8.set(\freq,64);
	~s8.setn(\n,[1,3/2,5/8,3,5/2,3/4,15/8]);
	~s8.set(\of,0);
	~s8.set(\p,3);
	~s8.set(\aa,0);
	~s8.set(\am,2);
	~s8.set(\atk,180);
	~s8.set(\amp,2/3);
	~s8.set(\gate,1);


(
	~s4 = Synth("syncd-phase4");
	~s4.set(\of,1);
	~s4.set(\m,1/32);
	~s4.set(\pp,0);
	~s4.set(\p,2.25);
	~s4.set(\aa,0);
	~s4.set(\am,4);
	~s4.set(\amp,3/4);

	~s4.set(\gate,1);
	~s4.set(\freq,64*2);
	
	~s4.setn(\n,[1,27/8,10/4,2]);
	~s4.setn(\ap,[1,3/2,27/8,10/4]);
	~s4.set(\gate,1);

	~s3 = Synth("syncd-phase4");
	~s3.set(\of,1);
	~s3.set(\m,1/32);
	~s3.set(\p,2.5);
	~s3.set(\pp,0);

	~s3.set(\aa,0);
	~s3.set(\am,4);
	~s3.set(\amp,3/4);

	~s3.set(\gate,1);
	~s3.set(\freq,64*4/3);
	
	~s3.setn(\n,[1,3/2,10/4,27/8]);
	~s3.setn(\ap,[1,3/2,9/4,2]);
	~s3.set(\gate,1);



	~s3.setn(\n,[1,4/3,3,4]);
	~s3.setn(\ap,[1,4/3,6/5,9/4]);
	~s4.setn(\n,[1,4/3,2,4]);
	~s4.setn(\ap,[1,4/3,6/5,9/4]);





	~s2 = Synth("syncd-phase4");
	~s2.set(\of,1);
	~s2.set(\m,3/128);
	~s2.set(\p,1.5);
	~s2.set(\pp,0.5);
	~s2.set(\atk,32);

	~s2.set(\aa,0);
	~s2.set(\am,4);
	~s2.set(\amp,2/4);

	~s2.set(\gate,1);
	~s2.set(\freq,64);
	
	~s2.setn(\n,[1,2,3/2,3/4]);
	~s2.setn(\ap,[1,3/2,2,9/8]);
	~s2.set(\gate,1);
)



	~s8 =Synth("simple-phase8");
	~s8.set(\freq,64);
	~s8.setn(\n,[1,3/2,9/8,243/128,81/32,2/3,27/16]*15/16);
	~s8.setn(\ap,[1,2,3/2,4/3,4/3,3/2,2,1]);
	~s8.setn(\ap,(1..8));

	~s8.setn(\n,15/16*[16,18,20,24,30,32,36]/16);


//	~s8.setn(\n,15/16*[1,6/5,3/2,2,9/4,3,16/9]);

	~s8.set(\of,1);
	~s8.set(\m,1/3);
	~s8.set(\p,3);
	~s8.set(\aa,0);
	~s8.set(\am,2);
	~s8.set(\atk,32);
	~s8.set(\amp,2/3);
	~s8.set(\gate,1);