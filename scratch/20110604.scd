
//pythagorean

var p = (72 *.x ([1,3/2,9/4,27/16,81/32,243/64,729/128,2187/256]) *.x(1..64));
var t;
t = p / (1024/2);

(
~synthFactory.("pitch-pendulum-64", {|f=72,a=12,p=#[1,1,1,1,1,1,1,1],t=512,w=0.5|
	var tRate;
	p=p*.x(1..64) * f;
	tRate = (p/t);
	(SinOsc.ar(p,0,(1/p)*(LFPulse.kr(tRate,0,w,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
)
~s = Synth("pitch-pendulum-64");
~s.set(\a,12);
~s.set(\gate,1);
~s.set(\t,64*4);
~s.set(\f,64*2);
~s.set(\w,1/2);
~s.setn(\p,[1/4,3/4,5/4,7/4,9/4,11/4,13/4,15/4]);


(
~synthFactory.("pitch-pendulum-64-4", {|f=72,a=12,p=#[1,1,1,1],t=512,w=0.5|
	var tRate;
	p=p*.x(1..64) * f;
	tRate = p/t;
	(SinOsc.ar(p,0,(1/((p+4)*p.log10))*(LFPulse.kr(tRate * SinOsc.kr(1/p,0,16,0).ceil/16,0,w,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
)
~s = Synth("pitch-pendulum-64-4");
~s.set(\a,30);
~s.set(\atk,1);
~s.set(\gate,1);
~s.set(\t,2520/16);
~s.set(\f,2520);
~s.setn(\p,[1,3/2,9/4,27/4].reverse/32);
~t = Synth("pitch-pendulum-64-4");
~t.set(\a,40);
~t.set(\atk,1);
~t.set(\gate,1);
~t.set(\t,2560/16);
~t.set(\f,2560);
~t.setn(\p,[1,3/2,9/4,27/4]/32);
[~t,~s].collect({|i|i.set(\w,1/2)});









(
~synthFactory.("pitch-pendulum-64-4", {|f=72,p=#[1,1,1,1],a=12,t=512,w=0.5|
	var tRate;
	p=p*.x(1..24) * f;
	tRate = p/t;
	(SinOsc.ar(p,0,(1/((p+4)*p.log2))*(LFPulse.kr(tRate * SinOsc.kr(1/p,0,1,0).abs,0,  SinOsc.kr(1/tRate,0,1-(1/(2..25).log2),1/(2..25).log2) ,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
)


~s = Synth("pitch-pendulum-64-4");
~s.set(\a,32);
~s.set(\atk,1);
~s.set(\t,160/64);
~s.set(\f,160);
~s.setn(\p,[3/4,9/4,45/8,243/32]/2);
~s.set(\gate,1);

~t = Synth("pitch-pendulum-64-4");
~t.set(\a,32);
~t.set(\atk,1);
~t.set(\t,157.5/64);

~t.set(\f,157.5);
~t.setn(\p,[3/4,9/4,45/8,243/32]/2);

~t.set(\gate,1);

~z = Synth("pitch-pendulum-64-4");
~z.set(\a,32);
~z.set(\atk,1);
~z.set(\t,160/64);
~z.set(\f,160);
~z.setn(\p,[3/4,9/4,45/8,243/32]/2);
~z.set(\gate,1);

~y = Synth("pitch-pendulum-64-4");
~y.set(\a,32);
~y.set(\atk,1);
~y.set(\t,157.5/64);
~y.set(\f,157.5);
~y.setn(\p,[1/2,15/8,81/16,729/64]/2);
~z.setn(\p,[1/2,15/8,81/16,729/64]/2);

~y.set(\gate,1);

~z.set(\t,1*160/1);
~y.set(\t,1*157.5/1);
~s.set(\t,1*160/1);
~t.set(\t,1*157.5/1);










(
~synthFactory.("pitch-pendulum-64-4", {|f=72,a=12,p=#[1,1,1,1],t=512,w=0.5|
	var tRate;
	p=p*.x(1..32) * f;
	tRate = p/t;
	(SinOsc.ar(p,0,(1/((p+4)*p.log))*(Pulse.kr(tRate * SinOsc.kr(1/p,0,1,0).abs * (SinOsc.kr(1/5).abs),  SinOsc.kr(1/tRate,0,1,0) ,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
)

~s = Synth("pitch-pendulum-64-4");
~s.set(\a,32);
~s.set(\atk,1);
~s.set(\t,160/64);
~s.set(\f,160);
~s.setn(\p,[1,3/2,9/4,27/4].reverse/2);
~s.set(\gate,1);

~t = Synth("pitch-pendulum-64-4");
~t.set(\a,32);
~t.set(\atk,1);
~t.set(\t,157.5/64);
~t.set(\f,157.5);
~t.setn(\p,[1,3/2,9/4,27/4]/2);
~t.set(\gate,1);


~s.set(\t,160/512);
~t.set(\t,157.5/512);

~s.set(\t,160/128);
~t.set(\t,157.5/128);


~s.set(\t,160/32);
~t.set(\t,157.5/32);

~s.set(\t,160/2);
~t.set(\t,157.5/2);


~s.set(\t,8*160/1);
~t.set(\t,8*157.5/1);
