{|i, il, ill, p, j, k, x, n, l|
  var qq, js;
//  ~p.set(\of,ill.reject(_==0).size);
//  ~p.set(\x,ill.reject(_==0).size);
k=1;
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
  qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
  
  js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/8)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* qq/qq) * 
   [(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.sort.reverse[4].asInt.factors.reverse[0])    );

}
