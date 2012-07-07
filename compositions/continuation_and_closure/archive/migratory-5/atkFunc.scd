{|i, ill, k, j,l, pp|
  (1/(2**ill.permute(i.asInt).wrapAt(k+l+j).asInt))*((1/(2**j)) * (i.factors[j].sqrt*pp.log) * (1/(i.log*2)));
}
