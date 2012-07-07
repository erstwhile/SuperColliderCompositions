{|note,i|
  var p;
  p= Synth("oto-phase",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,6)));
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (1/~o.a.collect({|i|i.xy.sum}).sum.factors.size) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\sus,-1 * ~o.a.size);

  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
}
