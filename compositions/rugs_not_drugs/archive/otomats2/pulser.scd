{|note,inval|
  var p;
  p = Synth("oto-pulse");
  p.set(\amp,(0.6/(~o.a.size.log2+2)));
  p.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+2).log2)).clip(0,1));
  p.set(\gate,1);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2).wait;
    p.set(\gate,0);
  }.play;
}
