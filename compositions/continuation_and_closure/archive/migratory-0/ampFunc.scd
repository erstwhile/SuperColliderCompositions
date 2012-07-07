{|i,p,pp,l,k|
      var c1, c2,out;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      out = ((c1/((p+c2).log10))
      *((1/((p+(3)).log)))
      * 4  * (1/(l+2).log2) * (1/(k+3).log)
      *(p.sqrt 
      * (c1/(pp+c2).log10)));
      out.clip(0.01,32);
}
