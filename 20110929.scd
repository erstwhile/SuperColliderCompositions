~synthFactory.("peaks1",{
  var a =[1,8/7,3/2,3/7] *.x [1,8/7,3/2,3/7] *.x [121,120]*4,p=BrownNoise, b=SinOsc, x =LFSaw.kr(1/3600,0,32,0), r=(x.sin * x).tan.abs.log;b.ar(a,b.ar(a,0,r),8/a) },{[-1,1]/(2..9)},Server.internal);

~synthFactory.("peaks2", {
  var a =[9/8,8/7,4/3,6/7] *.x [1,8/7,3/2,3/7]*.x [121,120]*4,p=BrownNoise, b=SinOsc, x =LFSaw.kr(1/3600,0,32,0),  z=(x/(x.tan)).sin.tan; b.ar(a,b.ar(a,0,z),8/a)},{[-1,1]/(2..9)},Server.internal);

~p = Synth("peaks1");
~p.set(\gate,1);

~q = Synth("peaks2");
~q.set(\gate,1);

~q.set(\gate,0);
~p.set(\gate,0);