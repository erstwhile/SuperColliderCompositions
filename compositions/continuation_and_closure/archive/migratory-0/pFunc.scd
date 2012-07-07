{|ill, ils, p|
    p=p.nextPowerOfTwo;
  (p > (ils**ill.reverse[1])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
}
