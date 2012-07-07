~synthFactory.("pitch-pendulum-64-4", {|f=72,p=#[1,1,1,1],a=12,t=512,w=0.5,m=1,mr=1,mm=4,ma=(2)|
  var tRate,mRate;
  p=p*.x(1..16) * f;
  tRate = p/t;
  mRate = (2**SinOsc.kr(mr,0,mm,ma));

  (SinOsc.ar(p * m,0,(1/((p+4)*p.log))*(LFPulse.kr(tRate  * mRate *SinOsc.kr(mRate/p,0,1,0).abs,0, w+SinOsc.kr((1/tRate)*mRate ,0,1-(1/(2..25).log2),1/(2..25).log2) ,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]
},Server.internal);

//square wave variant
~synthFactory.("pitch-pendulum-64-4", {|f=72,p=#[1,1,1,1],a=12,t=512,w=0.5,m=1,mr=1,mm=4,ma=(2)|
  	var tRate,mRate,dRate;
  	dRate = p;
  	p=p*.x(0.5*((1..16).nthPrime)-1) * f;
	
  	tRate = p/t;
  	mRate = (2**SinOsc.kr(mr,0,mm,ma));
  	(SinOsc.ar((p * m),0,(1/((p+4)*p.log))*(LFPulse.kr(tRate  * mRate *SinOsc.kr(mRate/p,0,1,0).abs ,0, w+SinOsc.kr((1/tRate)*mRate ,0,1-(1/(2..25).log2),1/(2..25).log2) ,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]
  }, Server.internal);

