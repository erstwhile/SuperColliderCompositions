{|note, i|
  //real synth Func goes here
  ~playSine.(note,i);
  ~playPhase.(note,i);

  ((~allvals %(~o.a.size**2))==0).if({
    ~playPulse.(note,i);
  });
}
