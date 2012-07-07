{|note, i|
  var s  = Synth("oto-sine", nil,~g1);
  ~allvals = ~allvals + 1;
  h = [[1,[({|i|i.nthPrime}!16).permute(~o.a.collect({|i|i.xy.sum;}).sum+(~allvals/~o.a.size**2).asInt)[0..4]]].flat, [1,(~o.a.collect({|i|i.xy.sum})[0..4] * [1,1,1,1,1]).clip(1,32)].flat].wrapAt((~o.a.collect({|i|i.d.sum;}).sum/2));
  s.setn(\harm,h);
  ~wah.set(\rate,5/(~o.a.size**2).nextPowerOfTwo);
  ~echo.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
  s.set(\bus,6);
  s.setn(\phase,Array.fill(12, {|i|(1024+i)/1024 })); 
  s.set(\freq, note);
  s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
  s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
  s.set(\rel, 3/4* ~tempo);
  s.set(\gate,1); 
  s.set(\amp, (1/(~o.a.size.log2+2)));
}
