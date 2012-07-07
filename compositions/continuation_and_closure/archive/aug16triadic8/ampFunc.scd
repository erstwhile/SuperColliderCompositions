{|i,p,pp,l,k|
      var c1, c2;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      ((c1/((p+c2).log10))
      *((1/((p+(10)).log10)) )
      * 6  * (1/(l+1)) * (1/(k+3).log)
      *(p.sqrt 
      * (c1/(pp+c2).log10)))
    }
