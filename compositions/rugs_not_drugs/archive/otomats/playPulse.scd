{|note,inval|
  var p;
  p = Synth("oto-pulse",nil, ~g2);
  p.set(\amp,(1/(~o.a.size.log+3)));
  p.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+10).log10)).clip(0,1));
  p.set(\gate,1);
  p.set(\bus,4);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo*2);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2  *~tempo).wait;
    p.set(\gate,0);
  }.play;
}
