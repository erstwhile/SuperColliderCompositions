{|i, j, ii,k,l|
  ((1/(i.factors.size)) * (-1**(ii+j)) + (((2+k.log2)-1)**(-1**(k+l))) - (((2+l.log2)-1)**(-1**(k+l)))).clip(-1,1)
}
