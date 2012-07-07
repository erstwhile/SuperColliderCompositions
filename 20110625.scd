~synthFactory = {|name, func, pan =({[-1,1]}),l=(Server.internal)|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(l)
};

s = Server.internal;
o = s.options;
o.numBuffers_(8192);
~synthFactory.("phase-quant",{|freq=256,n=#[1,1,1,1,1,1,1],amp=192|
var a=(1..8)*.x n, 
	f=a*freq,
	b=SinOsc,r=b.ar(1/a,0,a).floor;
	Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),192/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]/r.clip(1,128)))},{[-1,1]},Server.internal);

~synthFactory.("sine-phase",{|freq=64,n=#[1,1,1,1,1,1,1],amp=64,p=6|
var a=(1..6)*.x n,
	f=a*freq,
	b=SinOsc,
	r=b.ar(1/f,0,p);
	Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]));
},{[-1,1]},Server.internal);

~synthFactory.("pulse-drum",{|freq=64,n=#[1,2,3,4,5,6,7],amp=2|
	var a = n,
	b = Pulse,
	c = SinOsc,
	f = a * freq;
	b.ar(f*a * b.ar(a,1/a,[0,1/a],1),c.ar(1/f,c.ar(1/f,0,a,a),1/2,1/2)/2,b.ar(a,1/a,2,2)/(f*f.log2))},{[-1,1]},Server.internal);


Server.internal.scope;
(
Routine {
~t = Synth("sine-phase");
~t.setn(\n,[1,3/2,10/4,27/8,9/4,3/4,15/8]);
~t.set(\amp,0.775);
~t.set(\freq,75);
~t.set(\p,3);
~t.set(\gate, 1);
~d = Synth("pulse-drum");
~d.setn(\n,[2,3,5,27/4,9/2,6,15/4]);
~d.set(\freq,75/2);
~d.set(\atk,64);
~d.set(\gate,1);
~d.set(\amp,6);

((64/75)*96).wait;

~u = Synth("sine-phase");
~u.setn(\n,[1,3/2,10/4,15/4,9/4,9/8,9/2]);
~u.set(\amp,0.675);
~u.set(\freq,75);
~u.set(\p,6);
~u.set(\gate, 1);

((64/75)*128).wait;
((64/75)*64).wait;

~s = Synth("phase-quant");
~s.set(\atk,128);
~s.setn(\n,[1/4,3/2,10/4,27/8,9/4,3/8,15/8]);
~s.set(\amp,0.65);
~s.set(\freq,300);
~s.set(\gate,1);
"q start".postln;
((64/75)*128).wait;

~t.set(\rel, 48);
~t.set(\gate,0);

~u.set(\rel,64);
~u.set(\gate,0);
~d.set(\gate,0);
"d out".postln;
((64/75)*64).wait;
~s.set(\rel,64);
~s.set(\gate,0);
~s = Synth("phase-quant");
"q2 start".postln;
~s.set(\atk,128);
~s.setn(\n,[1/4,3/2,10/4,27/8,9/4,3/8,15/8]);
~s.set(\amp,0.55);
~s.set(\freq,256);
~s.set(\gate,1);
~t = Synth("sine-phase");
~t.setn(\n,[1,3/2,10/4,27/8,9/4,3/4,15/8]);
~t.set(\amp,0.675);
~t.set(\freq,64);
~t.set(\p,6);
~t.set(\gate, 1);
256.wait;
~s.set(\rel,64);
~s.set(\gate,0);
~t.set(\rel,64);
~t.set(\gate,0);
"done 64".postln;
}.play;

)

//start


 (a=(1..2)*.x[1,3/2,5/8,3,5/2,3/4,15/8];f=a*128;b=SinOsc;r=b.ar(1/f,0,2);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,         
 0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play);


//32
(a=(1..4)*.x[1,3/2,10/4,4];f=a*96;b=SinOsc;r=b.ar(1/f,0,4);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);

//128 - then start above


//fade out these 2
(a=(1..2)*.x[1,3/2,5/4,3,5/2,2,8];f=a*128;b=SinOsc;r=b.ar(1/f,b.ar(1/f,1/a,1/a),2);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);

(a=(1..4)*.x[1/2,3/2,10/4,1/2];f=a*96;b=SinOsc;r=b.ar(1/f,b.ar(1/f,1/a,1/a),4);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);



(a=[2/3,(1..8)].flat*.x[13,17,19,23,29,31,37]/16;f=a*128;b=SinOsc;r={Mix.ar(Pan2.ar(b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);

