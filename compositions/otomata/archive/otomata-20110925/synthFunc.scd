{|note, inval|
  var i;
   i=inval;
   note = ~scales.wrapAt(~so.(i)).wrapAt(note) * ~pitch;
  ~askAgain.(note, i);//refresh synthFunc for instance;
}
