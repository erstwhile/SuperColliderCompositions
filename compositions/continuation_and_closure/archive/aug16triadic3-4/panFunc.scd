{|i, j, ii,k,l,x|
     ((1/(i.factors.size)) * (-1**(i.factors.size+i+j+k+x)) + (((2+k.log2)-1)**(-1**(k+l)))).clip(-1,1)
    }
