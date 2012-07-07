{|note=1|
    var s=Synth("oto-phase"),p=192,octave=1, freq;
    freq = p * octave * [5/8,15/16,1,9/8,5/4,45/32,3/2,5/3].wrapAt(note);
    s.set(\freq,freq * (2**~dSum.().clip(-4,4)));
    s.set(\amp,(1.5/(~a.size+2).log2));
    s.set(\atk,0.01/(1+~xySum.().log2));
    s.set(\rel, (1/~xySum.().factors.size));
    s.set(\w,(2**(~dSum.().clip(-6,6)* (-1))));
    s.set(\b,2**(~dSum.()));
    s.set(\sus,-1 * ~a.size);
    s.set(\gate,1);
    s.set(\a,0.1/~xySum.().abs);
    note;
  }
