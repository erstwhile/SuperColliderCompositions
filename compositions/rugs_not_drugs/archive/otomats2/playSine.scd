{|note, i|
  [1,3/2,2/3,9/4].collect({|f|
    var s  = Synth("oto-sine", nil,~g1);
    ~allvals = ~allvals + 1;
    h = [1,3,5,7,9,11];
    s.setn(\harm,h);
    ~wah.set(\rate,9/4);
    ~wah.set(\ffreq,128 * (2**~o.a.collect({|i|i.d.sum;}).sum.abs.clip(0,8)));

//    ~echo.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
    s.set(\bus,6);
    s.setn(\phase,Array.fill(12, {|i|(1024+i)/1024 })); 
    s.set(\freq, note *f);
    s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
    s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
    s.set(\rel, 3/4* ~tempo);
    s.set(\gate,1); 
    s.set(\amp, (1/(~o.a.size.log2+2)));
  });
}
