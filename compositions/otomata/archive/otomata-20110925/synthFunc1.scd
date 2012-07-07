{|note=1|
  var s = Synth("oto-sine"), h=[1,3,5,7,9,11];  
  s.setn(\harm,h);
  s.setn(\phase,Array.fill(12, {|i|(1024+[i,0].wrapAt(i))/1024 })); 
  s.set(\freq, 96 * [1/2,3/4,2,9/4,5/2,3,27/8,15/4].permute(~age).wrapAt(note));
  s.set(\atk, 0.01);
  s.set(\rel,1);
  s.set(\gate,1);
  s.set(\amp,1/(~a.size+2).log2);
  note;
}
