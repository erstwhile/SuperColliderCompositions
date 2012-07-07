
~droneMaker = {|name, func|
	SynthDef(name, {|gate =0, atk=10, rel=10,amp =1|
	var out, pan = ([-1,1] /.x (1..9)).sort;
	out = SynthDef.wrap(func);
	
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(Server.internal)
};

~pulseMaker = {|name, func, pan = ({([-1,1] /.x (1..9)).sort})|
	SynthDef(name, {|gate =0, atk=10, rel=10|
	var out;
	out = SynthDef.wrap(func);
	
		Out.ar(0,Mix.ar(Pan2.ar(out,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(Server.internal)
};


Routine {
	16.do({|x|	
			var f = [{|n|{|i|i.nthPrime}!n},{|n|{|i|(i+1)*2}!n},{|n|(1..n)}].wrapAt(x);
			[1,5/4,3/2,5/3,4/3].collect({|item,i|
				var ss,t,m;
				f.(x+i+1).postln;		
				t = {|p|
					var a = f.(x+i+1);
					SinOsc.ar(p*[63+x,64+x]*.x SinOsc.kr(1/64,0,[0,1/64],1) *.x a ,0,[1,1,1,1] *.x (1/a) * 0.25 );
				};
				m = ~droneMaker.("test",t);
				8.wait;
				ss = Synth("test");
				ss.set(\p,item );
				ss.set(\atk,16);
				ss.set(\gate,1);	
				(24 + x.factors[0]).asInt.wait;
				ss.set(\rel,128);
				ss.set(\gate,0);		
			});
		})
}.play;


~f = [{|n|{|i|i.nthPrime}!n},{|n|{|i|(i+1)*2}!n},{|n|{|i|(i*2)+1}!n},{|n|(1..(2*n))}];

~f = [{|n|(1..n)}];

~f = [{|n|((0..n)*2)+1}];

~f = [{|n|(1..n)},{|n|2**(0..n)}];

~f = [{|n|2**(0..n)}];

~f = [{|n|(1..n)}];


~play = {|x|
		var f =~f.wrapAt(x),ss,s1,s2,t,m;
		t = {|p|
			var a = f.(x+1),lf,l,ls;
			l = a.reverse[0];
			lf = LFPulse.kr(1/l,0,1/l,1,2);
			a.reverse.collect({|o|
				var k;
				k = LFPulse.kr(o/o.nextPowerOfTwo,(1/lf),1/lf,1,o);
				lf = LFPulse.kr(k,(1/k),1/k,k,k);
			});
			ls=LFSaw.kr(1/2**l,lf.abs *2,1/l,1/2);
			Pulse.ar([31,32] *.x lf ,ls, 1/16);
		};
		~droneMaker.("test2",{
			var a = f.(x+1);
			Pulse.ar([127,128] *.x a *.x LFSaw.kr(1/2**x,0,1/a.reverse[0],1),1/a.reverse[0],0.125/a.size);
		});
	~droneMaker.("test3",{
			var a = f.(x+1);
			Pulse.ar([127,128] *.x a ,1/a.reverse[0],0.125/a.size);
		});

		m = ~droneMaker.("test",t);
		ss = Synth("test");
		ss.set(\atk,0.001);
		ss.set(\gate,1);	
		s1 = Synth("test2");
		s1.set(\atk,1);
		s1.set(\gate,0);
		s2 = Synth("test3");
		s2.set(\atk,1);
		s2.set(\gate,0);

		(2**x).wait;
		ss.set(\rel,0.1);
		s1.set(\rel,2);
		s2.set(\rel,2);

		ss.set(\gate,0);
		s1.set(\gate,0);
		s2.set(\gate,0);

};
~routine1.stop;
~routine1 = Routine {
		~play.(0);
	16.do({|x|	
		~play.(x);
	})
};
~routine1.play;

~pulseMaker.("pulse1",{|freq = 200|
	Pulse.ar(freq * LFPulse.kr(1/2,0,1/2,1/2,1) * LFPulse.kr(1/3,0,1/3,1/3,1) * LFPulse.kr (1/4,0,1/4,1/4,1) ,0.5,0.05)},[-1,1]);

~x = Synth("pulse2");
~x.set(\gate,2);


~pulseMaker.("pulse2",{|freq = 100|
	var f,x;
	f =(1..32);
	f.postln;
	x.postln;
	Pulse.ar(freq *.x f.collect ({|i|  LFPulse.kr(f.size/(1+i),1/(i+i),1/(i+2),1/(i+1),1); }),0.5,0.05)});



~y = [1,4/3] *.x [1,45/32];
~y.collect({|p,i|
	~y[i] = Synth("pulse2");
	~y[i].set(\freq,128 * p);
	~y[i].set(\gate,1);
});


~pulseMaker.("pulse2",{|freq = 100,m=0.01,r=0,s=2|
	var f,x;
	f =(1..16);
	f.postln;
	x.postln;
	Pulse.ar(freq * f.collect ({|i|  LFPulse.kr(s/(1+i),1/(i+1),1/(i+2),i,1)}) ,1/2,0.02)});


~pulseMaker.("pulse2",{|freq = 100,m=0.01,r=0,s=2|
	var f,x;
	f =(1..16);
	f.postln;
	x.postln;
	x = f.collect ({|i|  LFPulse.kr(s/(1+i),1/(i+1),1/(i+2),i,1)});
	Pulse.ar(freq *.x x ,1/2,0.02)});





~pulseMaker.("pulse2",{|freq = 100,m=0.01,r=0,s=2,p=0.5,q=0.5,fr=1,fade=0.1|
	var f,x;
	f =(1..4);
	f.postln;
	x.postln; 
	x = LFPulse.kr(s,0,1/2,0,1);
	f.collect({|i,j|  
		x = LFPulse.kr(x/(2**(i))*s,x/i,1/x,1/2**x,x);
	});
	RLPF.ar(Pulse.ar(freq *.x x,1 /.x x,0.2), (freq  * x *fr),q,(1/(freq+32))*(1 / x))});

~y.collect({|p,i|	~y[i].set(\gate,0);});

~y = [1,5/3] *.x [1,9/4] *.x [1,8/3];

Routine {
~y.collect({|p,i|
	~y[i] = Synth("pulse2");
	~y[i].set(\freq,32 * p);
	~y[i].set(\gate,1);
	~y[i].set(\s,1);
	~y[i].set(\p,1/(i+2));
	~y[i].set(\fr,2);
	~y[i].set(\q,0.9);
	~y[i].set(\fade,0);
	0.wait;
});
	//~y.collect({|p,i|~y[i].set(\s,1/1024)})
}.play;

~y;
~y.collect({|p,i|~y[i].set(\s,1/32)})
~y.collect({|p,i|~y[i].set(\fr,4)})
~y.collect({|p,i|~y[i].set(\q,0.3)})





Server.internal.scope;







~pulseMaker.("pulse2",{|freq = 100,m=0.01,r=0,s=2,p=0.5,q=0.5,fr=1,fade=0.1|
	var f,x;
	f =(1..6);
	f.postln;
	x.postln; 
	x = LFPulse.kr(s,0,1/2,0,1);
	f.collect({|i|  
		x= LFPulse.kr((x/2**(i))*s,x/(i+1).nextPowerOfTwo,1/x,i,x)}
	);
	RLPF.ar(Pulse.ar(freq * x ,p *.x SinOsc.kr([0,1]/x,0,1/2,1),0.2), freq  * x *fr * SinOsc.kr(fade * (1/x),0,1,1),q,(1/freq)*(1 / x) * SinOsc.kr(fade * (1/x),0,1,1) )});


~y.collect({|p,i|	~y[i].set(\gate,0);});

~y = [1,5/3] *.x [1,9/4] *.x [1,4/3];

Routine {
~y.collect({|p,i|
	~y[i] = Synth("pulse2");
	~y[i].set(\freq,32 * p);
	~y[i].set(\gate,1);
	~y[i].set(\s,1/32);
	~y[i].set(\p,1/(i+2));
	~y[i].set(\fr,2);
	~y[i].set(\q,0.3);
	~y[i].set(\fade,1/12);
	8.wait;
});
}.play;




~pulseMaker.("pulse2",{|freq = 100,m=0.01,r=0,s=2,p=0.5,q=0.5,fr=1,fade=0.1|
	var f,x;
	f =(1..6);
	f.postln;
	x.postln; 
	x = LFPulse.kr(s,0,1/2,0,1);
	f.collect({|i|  
		x= LFPulse.kr((x/2**(i))*s,x/(i+1),1/x,i,x)}

	);
	RLPF.ar(Pulse.ar(freq * x ,p *.x SinOsc.kr([0,1]/x,0,1/2,1),0.2), freq  * x *fr ,q,(1/freq)*(1 / x) )});

~pulseMaker.("pulse3",{|freq = 100,m=0.01,r=0,s=2,p=0.5,q=0.5,fr=1,fade=0.1|
	var f,x;
	f =(1..6);
	f.postln;
	x.postln; 
	x = LFPulse.kr(s,0,1/2,0,1);
	f.collect({|i|  
		x= LFPulse.kr((x/2**(i))*s,x/(i+1),1/x,1/(i/2)**x,x)}
	);
	RLPF.ar(Pulse.ar(freq * x ,p *.x SinOsc.kr([0,1]/x,0,1/2,1),0.2), freq  * x *fr ,q,(1/freq)*(1 / x) )});



~y.collect({|p,i|	~y[i].set(\gate,0);});
~z.collect({|p,i|	~y[i].set(\gate,0);});

~y = [1,5/3] *.x [1,9/4] *.x [1,4/3];
~z = [1,5/3] *.x [1,9/4] *.x [1,4/3];
~a=[~y,~z];
Routine {
~a.collect({|k,j|
	k.collect({|p,i|
		~a[j][i] = Synth(["pulse2","pulse3"].wrapAt(j));
		~a[j][i].set(\freq,32 * p);
		~a[j][i].set(\gate,1);
		~a[j][i].set(\s,1/256);
		~a[j][i].set(\p,1/(i+2));
		~a[j][i].set(\fr,2);
		~a[j][i].set(\q,0.3);
		~a[j][i].set(\fade,1/8);
		0.wait;
	});
})
}.play;

~y.collect({|p,i|~y[i].set(\s,1/64)})





//SynthDef factory methods are explained in the SynthDef help file.


Wrapping Example: 'factory' production of effects defs

// The makeEffect function below wraps a simpler function within itself and provides
// a crossfade into the effect (so you can add it without clicks), control over wet
// and dry mix, etc.
// Such functionality is useful for a variety of effects, and SynthDef-wrap
// lets you reuse the common code.
(
// the basic wrapper
~makeEffect = {| name, func, lags, numChannels = 2 |

	SynthDef(name, {| i_bus = 0, gate = 1, wet = 1|
		var in, out, env, lfo;
		in = In.ar(i_bus, numChannels);
		env = Linen.kr(gate, 2, 1, 2, 2); // fade in the effect
		
		// call the wrapped function. The in and env arguments are passed to the function
		// as the first two arguments (prependArgs). 
		// Any other arguments of the wrapped function will be Controls.
		out = SynthDef.wrap(func, lags, [in, env]);
		
		XOut.ar(i_bus, wet * env, out);
	}, [0, 0, 0.1] ).send(s);

};
)
XOut.browse
// now make a wah
(
~makeEffect.value(\wah, {|in, env, rate = 0.7, ffreq = 1200, depth = 0.8, rq = 0.1|
	// in and env come from the wrapper. The rest are controls
 	var lfo;
	lfo = LFNoise1.kr(rate, depth * ffreq, ffreq);
	RLPF.ar(in, lfo, rq, 10).distort * 0.15; },
	[0.1, 0.1, 0.1, 0.1],  // lags for rate ffreq, depth and rq
	2	// numChannels
);
)

// now make a simple reverb
(
~makeEffect.value(\reverb, {|in, env|
	// in and env come from the wrapper.
	var input;
	input = in;
	16.do({ input = AllpassC.ar(input, 0.04, Rand(0.001,0.04), 3)});
	input; },
	nil,  // no lags
	2	// numChannels
);
)

// something to process
x = { {Decay2.ar(Dust2.ar(3), mul: PinkNoise.ar(0.2))} ! 2}.play;

y = Synth.tail(s, \wah);
z = Synth.tail(s, \reverb, [\wet, 0.5]);

// we used an arg named gate, so Node-release can crossfade out the effects
y.release; 

// setting gate to zero has the same result
z.set(\gate, 0);

x.free;


common argument names: out and gate

// arguments named 'out' and 'gate' are commonly used to specify an output bus and
// EnvGen gate respectively. Although not required, using them can help with consistency
// and interchangeability. 'gate' is particularly useful, as it allows for Node's release
// method.
(
SynthDef(\synthDefTest, {|out, gate=1, freq=440|
	// doneAction: 2 frees the synth when EnvGen is done
	Out.ar(out, SinOsc.ar(freq) * EnvGen.kr(Env.asr(0.1, 0.3, 1.3), gate, doneAction:2));
}).store; // use store for compatibility with pattern example below
)

x = Synth(\synthDefTest, [\out, 0]); // play out through hardware output bus 0 (see Out.help)
x.release; // releases and frees the synth (if doneAction is > 2; see EnvGen)

//equivalent:

x = Synth(\synthDefTest); // out defaults to zero, if no default arg is given.
x.set(\gate, 0);

// if value is negative, it overrides the release time, to -1 - gate
x = Synth(\synthDefTest);
x.set(\gate, -5); // 4 second release

//equivalent:
x = Synth(\synthDefTest);
x.release(4);

// if the out arg is used in a standard way, it can always be changed without knowing the synth def
x = Synth(\synthDefTest, [\out, 0]);
x.set(\out, 1); //play through channel 1
x.release;

// Another good example of this is with patterns, which can use gate to release notes
(
Pbind(
	\instrument, \synthDefTest,
	\freq, Pseq([500, 600, Prand([200, 456, 345],1)], inf),
	\legato, Pseq([1.5, 0.2], inf),
	\dur, 0.4,
	\out, Pseq([0, 1], inf)
).play;
)



{Mix.ar(Pan2.ar(Blip.ar([1/2,1,2,8/3,5,27/8,8]*.x[81,80]*.x Blip.kr(0.0001/(99..96),3,1/2**(8..13),1),9,0.05),[-1,1]/.x(1..9)))}.play;
1/64

{Mix.ar(Pan2.ar(Blip.ar([1,3/4,9/4,5/4,10/3]*.x(120 +((0..4)/64))*.x Blip.kr(0.0001/(99..95),8,1/2**(6..10),1),(8..3),0.03),[-1,1]/.x(1..9)))}.play;

{Mix.ar(Pan2.ar(Blip.ar([2,1,3/2,5/4,4/3,5/3] *.x ([120,121] +.x((0..7)/64))*.x Blip.kr((0..3)/(10**4),32,1/2**(6..10),1),16,0.03),[-1,1]/.x(1..16)))}.play;



{Mix.ar(Pan2.ar(Blip.ar([1/2,1,3/2,5/4,4/3,5/3] *.x ([120,121] +.x((0..3)/16))*.x Blip.kr((2**(0..3))/(10**5),3,1/2**(6..10),1),6,0.03),[-1,1]/.x(1..16)))}.play;

SynthDef("just-sine",{|freq=100,atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0, mr=1, ma=1, mm=1|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] *.x freq,0,2 *amp/(freq+192)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).send(Server.internal)