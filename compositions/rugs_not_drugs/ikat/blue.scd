//posted on soundcloud as "pythagorean clouds"

~synthFactory = {|name, func, pan =({[-1,1]})|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(Server.internal)
};
(
(0..3).do({|i|
		var n = [1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256];
		var p = (72 *.x (n) *.x (((16*i)+1)..(16 * (i+1))));
		var t = p / (512);
		~synthFactory.("pythagorean"++i,{|f=1,a=64|
		SinOsc.ar(p*f,0,(1/((p+32)*p.log2))*(LFPulse.kr(t,0,0.33+ (1/p.log10) +SinOsc.kr((1/(n/3))/t,0,0.5,0),1,0) * a))};
		,{SinOsc.kr(t,0,1,-0.5)})
})

)

(
(0..3).do({|i|
		var n = [1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256];
		var p = (72 *.x (n) *.x (((16*i)+1)..(16 * (i+1))));
		var t = p / (512);
		~synthFactory.("pythagorean-up"++i,{|f=1,a=64|
		SinOsc.ar(p*f,0,(1/((p+32)*p.log2))*(LFPulse.kr(t,0,0.5 +SinOsc.kr((1/9)/t,0,0.5,0),1,0) * a))};
		,{SinOsc.kr(t,0,1,-0.5)})
})
)
~s.collect({|i,j|~s[j].set(\gate,0);});
~t.set(\gate,0)
(
Routine {
~s = Array.fill(4);
~s.collect({|i,j|
	~s[j]=Synth("pythagorean"++j);
	~s[j].set(\gate,1);
	~s[j].set(\f,1);

});

~s.collect({|i,j|
	~s[j].set(\f,25/24);
});

(72 * 3/2).wait;
~t = Synth("pythagorean0");
~t.set(\gate,1);
//comma sharp
~t.set(\f,(25/24)*((1.5**12)/128),\a,64);

(72*(81/32)).wait;
~s.collect({|i|i.set(\rel,72); i.set(\gate,0)});
(120).wait;
~s.collect({|i,j|
	~s[j]=Synth("pythagorean-up"++j);
	~s[j].set(\gate,1);
	~s[j].set(\f,25/24);
});
72.wait;
(72 * 81/32).wait;
~t.set(\rel,72); ~t.set(\gate,0);
~s.collect({|i|i.set(\rel,72); i.set(\gate,0)});
}.play;
)
