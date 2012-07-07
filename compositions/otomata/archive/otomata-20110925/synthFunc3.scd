{|note=1|
  var s = Synth("oto-saw"), p = 192 * 5/6, octave=1;   
  s.set(\freq, p * octave * [3/5,8/9,1,9/8,6/5,4/3,3/2,8/5].wrapAt(note));
  s.set(\atk, 1/~xySum.()**2);
  s.set(\rel,(1/(~xySum+10).log10)+0.25);
  s.set(\sus,-1 * ~dSum.().abs);
  s.set(\d,(2*~dSum.().abs)+1);
  s.set(\gate,1);
  s.set(\amp,2/(~a.size+2).log2);
  note;
}
