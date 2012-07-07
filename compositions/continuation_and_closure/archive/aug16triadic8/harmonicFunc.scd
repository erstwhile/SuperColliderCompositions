{|i, il, j, freq, hf,x,mod,k|
  
   freq * ((hf + (k * ([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(j+i.factors.size))))/(hf));
}
