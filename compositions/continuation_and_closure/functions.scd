~incrementFunc = {|i,d,n|
  (i+(2**n)).asInt;
};



~waitFunc = {|i,il,ill|{|pp,i|[pp.log2.ceil/3,pp.log2.ceil/2].wrapAt(i.factors.sum)/(2**i.factors.size)}};


~harmonicFunc = {|i, il, j, freq, hf,x,mod,k|
  
   freq * ((hf + (k * ([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(j+i.factors.size))))/(hf));
};


~notesFunc = { |i,il,ill|
  var n = [8,128/7,32/3,24,27,28,4,20,6,30,36,45,54].permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
  n
};


~countingFunc = {|i, il, ill|
  var ils = 2-(i.log2-i.log2.floor),fils,iFunc, il2 = (i.log2-i.log2.floor), lt,f=0;
  lt = ill.orderFunc(i).reverse[1].asInt.factors.reverse[0];
  {~iF.string = "il2"+il2; ~iFils.string = lt;  ~iB.string = ill.sum; ~iT.string = "test: "+((ill.sum**il2)*il2)}.defer;

  f=(((ill.sum**il2)*il2) > lt).if({0},{1});
  [
  {
    fils = {|ff,l|
      var r=ff;
      l.do({
      r=r**ff;
      });
      //clip r
      r.clip(0,i.log2.ceil.asInt).floor;
    };
  
      {((ill.orderFunc(i).reject(_==0).reverse[1].asInt.factors.reverse[0].collect({|x|i%  
        il.orderFunc(i).flat.reverse.wrapAt(fils.(ils,x))}).sum)).ceil.asInt}.value;
  }, 
  { 
    ( il.orderFunc(i).reverse[0] + il.reverse[1] + il.orderFunc(i).reverse.wrapAt(i.log10-1) 
    +(i%il.orderFunc(i).reverse.wrapAt(i.log10+1))+ (i%il.orderFunc(i).reverse.wrapAt(i.log10-2))).ceil.asInt;
  }].permute(ill.reverse[0].asInt).wrapAt(f).value.asInt;
  
};



~kFunc = {|i,il,ill,j,p|
  3;
};

~lFunc = {|i,il,ill,j,k,p|
  var z = Server.default.peakCPU, n,r,s;
  s=(Server.default.numSynths.asInt+2).log2.floor.asInt;
  (z > 80).if ({
    n = ~running.keys.asArray.at(0);
    ~running.removeAt(n);
    //query all nodes
    //kill the oldest
//    Server.default.sendMsg("/n_free", n);
    Server.default.sendMsg("/n_set", n, "gate",0);
  });
  r = (Server.default.numSynths < 800).if({(11 - (s)).clip(0,5);},{1});
  (Server.default.numSynths < 950).if({r},{0});

};

~relFunc = {|i, ill, p, pp| 
    [
      {((4/(4+(i.log/16).floor))*((26)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.7)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
};

~atkFunc = {|i, ill, k, j, pp|
  (1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
};

~susFunc = {|i,j,k,l|
  -1 * i.factors.wrapAt(j+k+l).log10;
};


~ampFunc = {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 3  * (1/(l+1)) * (1/(k+3).log)
    *(pp.log2 
    * (c1/(p+c2).log10)))
  };


  ~ampFunc = {|i,p,pp,l,k|
      var c1, c2,out;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      out = ((c1/((p+c2).log10))
      *((1/((p+(10)).log10)))
      * 3  * (1/(l+1)) * (1/(k+3).log)
      *(p.sqrt 
      * (c1/(pp+c2).log10)));
      out.clip(0.01,32);
    };
  



    ~notesFunc = 
    { |i,il,ill|
      var n = [1,2,3,4,5,7,8,9,11,16,25,27,32,49,64,81,121,125,128].permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
      n
    };


    ~notesFunc = 
   { |i,il,ill|
      var n = 16*[1,2,3,4,5,8,9,16,25,27,32,64,81,125,128].collect({|x|2*x/x.nextPowerOfTwo}).permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
      n
    };


    ~panFunc={|i, j, ii,k,l,x|
     ((1/(i.factors.size)) * (-1**(i.factors.size+i+j+k+x)) + (((2+k.log2)-1)**(-1**(k+l)))).clip(-1,1)
    }


~pitchFunc = {|i, il, ill, p, j, k, x, n, l|
  var qq, js;
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.orderFunc(i).reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.orderFunc(i).reverse[1]);
  qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
  js = j * [(1+(ill.orderFunc(i).reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* qq) * 
  [((2*l)+1),(l+1),2**l,1/2**l,(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.orderFunc(i).reverse[4].asInt.factors.reverse[0])  * 
  (1+(2*(k%ill.orderFunc(i).reverse[1].asInt.factors.reverse[0]))))
};

~panFunc = {|i, j, ii,k,l|
  ((1/(i.factors.size)) * (-1**(ii+j)) + (((2+k.log2)-1)**(-1**(k+l))) - (((2+l.log2)-1)**(-1**(k+l)))).clip(-0.5,0.25)
};
~pFunc = {|ill, ils, p|
    p=p.nextPowerOfTwo;
  (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
};