{
  ~synthFactoryPerc.("oto-sine",{|freq=128,harm=#[1,3,5,7,9,11],phase=#[1,2,3,4,5,6,7,8,9,10,11,12], amp = 1, gate=0|
    var src, env, pitches,b=SinOsc;
    pitches = harm * freq *.x [1,1] * phase;
    src = b.ar(pitches,0,(amp * 1/((pitches/freq)+32)));
  },{[-1,1]/(2..7)},Server.default);


  ~synthFactoryPerc.("oto-saw",{|freq=128, amp = 1,d=4|
    RLPF.ar(Saw.ar(PinkNoise.ar([freq.sqrt/2,freq.sqrt/2],freq) ,amp/(freq+2).log2), freq * XLine.ar(d,2,1/freq.log2),0.5,1);
  },{[-1,1]},Server.default);



  ~synthFactory.("oto-pulse",{|freq=512,w=0.5,a=0.1|
    Pulse.ar(SinOsc.kr(a,0,[w,0],1) *.x  SinOsc.kr(1/a,0,[0,w],1) *.x freq *.x [1,81/80] ,w*XLine.ar(1/128,1,1/a),192/(freq+256))},[-1,1],Server.default);



  ~synthFactoryPerc.("oto-bass",{|freq=512,w=0.5,a=0.1,b=1,k=1|
    var src;
    freq = freq /[8,2,2,8];
     src = SinOsc.ar(WhiteNoise.ar(2**(freq/128).floor,freq),Pulse.ar(freq, 1/2   * XLine.kr(0,1,1/k).cos * SinOsc.kr(k,0,1,1),freq),(SinOsc.ar(k,0,2,2)**3)/(freq+64));
    src;
    },[-1,1],Server.default);

  ~synthFactoryPerc.("oto-phase",{|freq=512,w=0.5,a=0.1,b=4|
    SinOsc.ar(freq*[1,1]*XLine.ar(b,1,a),SinOsc.ar(PinkNoise.ar(freq,1), 0, w*pi*XLine.ar(b,1,a)),4/(freq.log2+4));
  },{[-1,1]},Server.default);




  // now make a wah
  ~makeEffect.value(\wah, {|in, env, rate = 1, ffreq = 1200, depth = 0.8, rq = 0.1|
  	// in and env come from the wrapper. The rest are controls
   	var lfo;
  	lfo =SinOsc.kr(rate, 0, ffreq*depth,ffreq);
  	RLPF.ar(in, lfo, rq, 10) * 0.15; },
  	[0.1, 0.1, 0.1, 0.1],  // lags for rate ffreq, depth and rq
  	2);

  ~makeEffect.value(\echo, {|in, env, maxlength=1, length=0.125, decay=3|
  	AllpassC.ar(in,maxlength,length,decay);
  },
  	[0.1],  
  2);

  SynthDef("all", {|in_bus=2,master=1|
  	var in = In.ar(in_bus, 16);
  	Out.ar(0, Mix.ar(Pan2.ar(in,[-1,1])*master));
  }).send(Server.default);

  
}
