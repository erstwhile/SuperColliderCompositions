{|note,inval|
  var p;
  p = Synth("oto-pulse",nil, ~g2);
  p.set(\amp,(1/(~o.a.size.log+3)));
  p.set(\atk, note.log2/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note) * (2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,2)));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+10).log10)).clip(0,1));
  p.set(\a,1.25/12);
  p.set(\gate,1);
  p.set(\bus,4);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo*2);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2  *~tempo*2 ).wait;
    p.set(\gate,0);
  }.play;
}
