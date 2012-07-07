s=Server.internal;
s.boot;

~synthFactory = {|name, func, pan =({[-1,1]}),l=(Server.internal)|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(l)
};

Routine {
  6.wait;
~synthFactory.("pitch-pendulum-64-4", {|f=72,p=#[1,1,1,1],a=12,t=512,w=0.5,m=1,mr=1,mm=4,ma=(2)|
	var tRate,mRate,b=SinOsc;
	p=p*.x(1..16) * f;
	tRate = p/t;
	mRate = (2**b.kr(mr,0,mm,ma));
	(b.ar((p * m),0,(1/((p+4)*p.log))*(LFPulse.kr(tRate  * mRate *b.kr(mRate/p,0,1,0).abs,0, w+b.kr((1/tRate)*mRate ,0,1-(1/(2..25).log2),1/(2..25).log2) ,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
}.play;

Routine {
var all = Array(2);
10.wait;
2.do({|x|
  var s,t,y,z;
  ~s = Synth("pitch-pendulum-64-4");
  ~s.set(\a,12);
  ~s.set(\atk,1);
  ~s.set(\t,160/64);
  ~s.set(\f,160);
  ~s.set(\mr,1/160);
  ~s.setn(\p,[3/4,9/4,45/8,243/32]/2);
  ~s.set(\gate,1);

  ~t = Synth("pitch-pendulum-64-4");
  ~t.set(\a,12);
  ~t.set(\atk,1);
  ~t.set(\t,160/64);

  ~t.set(\f,160);
  ~t.set(\m,157.5/160);
  ~t.set(\mr,1/160);

  ~t.setn(\p,[3/4,9/4,45/8,243/32]/2);

  ~t.set(\gate,1);

  ~z = Synth("pitch-pendulum-64-4");
  ~z.set(\a,12);
  ~z.set(\atk,1);
  ~z.set(\t,160/64);
  ~z.set(\f,160);
  ~z.set(\gate,1);

  ~y = Synth("pitch-pendulum-64-4");
  ~y.set(\a,12);
  ~y.set(\atk,1);
  ~y.set(\t,160/64);
  ~y.set(\f,160);
  ~y.set(\m,157.5/160);
  ~y.setn(\p,[1/2,15/8,81/16,729/64]/2);
  ~z.setn(\p,[1/2,15/8,81/16,729/64]/2);

  ~y.set(\gate,1);

  ~all = [~y,~z,~t,~s];
  ~all.collect({|i|i.set(\t,160)});
  ~all.collect({|i|i.set(\amp,2)});

  ~all.collect({|i|i.set(\mr,1/([3600,7200].wrapAt(x)))});

  ~all.collect({|i|i.set(\ma,2)});
  ~all.collect({|i|i.set(\mm,4)});


  ~all.collect({|i|i.set(\w,0.0)});

  });
  10.wait;
  ~rr = Routine {
    inf.do({|x|
      var p = ~pitches.permute(x.asInt).wrapAt(x);
      ~setPitch.(p[0],p[1],p[2]);
      3600.wait;
    })  
  };
  ~rr.play;
}.play;


~setPitch = {|p, pp, m| ~z.setn(\p,p); ~y.setn(\p,p); ~t.setn(\p,pp); ~s.setn(\p,pp); ~t.set(\m,m); ~y.set(\m,m);  };

~pitches = [[[1,3/2,5/4,7/4]/1.5,[9/4,21/8,27/8,63/8]/1.5,2401/2400], 
[[1,9/2,12/5,8/3]/1.5,[3,18/5,16/9,8]/1.5, 127/128],
[[11,13,17,19]/5,[11,13,17,19]/5,243/242],
[[1,3,5,7]/3,[9,11,13,15]/3,729/728],
[[2,4,6,8]/5,[10,12,14,16]/5,729/728],
[[1,4/3,6/5,16/7]/2,[24/11,24/13,64/17,128/19]/2,729/728],
[[1,3/2,9/4,27/8]/2,[81/16,243/32,729/64,2187/128]/2,81/80],
[[1,2,3,4]/3,[5,6,7,8]/3,81/80],
[[2,3,4,5]/3,[6,7,8,1]/3,240/241],
[[1,3/2,5/2,15/4]/3,[9/2,45/8,27/4,81/8]/3,240/241]];
