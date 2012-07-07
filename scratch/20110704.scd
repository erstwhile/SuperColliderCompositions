(
~synthFactory.("syncd-phase4",{|freq=96, ap = #[1,2,3,4],n=#[1,2,3,4],p=4,pp=0,of=1,m=1,am=2,aa=(-1),fm=4,fa=0.25|
var a =	ap *.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(m,b.ar(m,1/a,1/a)*of,p,pp);
	b.ar(f *b.ar(f * n,0,r),b.ar(f,0,pi**b.ar(m,r,r)),(64/(f*f.log2))*b.ar(m*a.reverse,b.ar(m,r,pi**b.ar(m,r,b.ar(1/a,r,a))),am,aa))},{[-1,1]/.x(1..4)},Server.internal);
)


(
Routine {
	inf.do({|x|
		~play.(x);
	});
}.play;

)
~xf = {|x|x=x+2;x=(16*x).asInt; x.factors.reject(_>x.log2.ceil).product.asInt};
(
~play = {|x|
		var s = Synth("syncd-phase4"),t;
	
	x=~xf.(x);
	s.set(\of,1);
	s.set(\m,(2/3**x.factors.size));

	s.set(\p,x.factors.size.log2.ceil);
	s.set(\rel,(x.factors.reverse[0]));
	s.set(\aa,0);
	s.set(\am,4);
	s.set(\amp,2/4);

	s.set(\gate,1);
	s.set(\freq,2**((x.factors.size%4)+5));
	
	s.setn(\n,[1,9/4,27/8,3/2]);
	s.setn(\n,x.factors.reverse[0..3].collect({|i|2*(i/i.nextPowerOfTwo)}));
	t = 2*(x.factors[0]/x.factors[0].nextPowerOfTwo);
	s.setn(\ap,[1,1/t,3/(2*t),(2*t)/3]);
	Routine {
		(x.factors[0] ** x.factors.size).wait;
		s.set(\gate,0);
	}.play;
	x.postln;
	x.factors.postln;
	(x.factors.reverse[0]*x.factors.size).wait;
};
)