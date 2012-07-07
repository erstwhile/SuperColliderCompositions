{|note,i|
  var p;
  p= Synth("oto-bass",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
  ~echoPhase.set(\length,1/(note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,4))));
  ~echoPulse.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (8/~o.a.collect({|i|i.xy.sum}).sum.log2) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\k,[3,6].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/1.25);
  ~wah2.set(\rate,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/2.5);
  p.set(\sus,(-1)  );
  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
}
