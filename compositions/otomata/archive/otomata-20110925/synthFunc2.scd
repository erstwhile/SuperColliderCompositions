{|note=1|
  //a different take on the oto-sine instrument.  this adds more high prime-number partials to the mix
  var s = Synth("oto-sine"), h=[1,3,11,17,29,47], p = 96, octave=1;   octave = 2**((~dSum.()/2).ceil.abs%6);
  s.setn(\harm,h);
  s.setn(\phase,Array.fill(12, {|i|(4096+[i,0].wrapAt(i))/4096 }).permute(~age)); 
  //note use of .permute here - every 256 ticks of the otomata routine, the ordering of the pitches along the edges changes
  s.set(\freq, p * octave * [5/8,15/16,1,9/8,5/4,45/32,3/2,5/3].permute((~age/256).ceil.asInt).wrapAt(note));
  s.set(\atk, 1/~xySum.()**2);
  s.set(\rel,~xySum.log10);
  s.set(\sus,-1 * ~dSum.().abs);
  s.set(\gate,1);
  s.set(\amp,1/(~a.size+2).log2);
  note;
}
