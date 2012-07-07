{|i, il, j, freq, hf,x,mod,k,l|
   freq * (((1024..1040) / 1024).permute(i).wrapAt(k+l) + (((1..8)*2)-1).permute(i).wrapAt(j));
}
