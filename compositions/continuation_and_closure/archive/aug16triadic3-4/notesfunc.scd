{ |i,il,ill|
      var n = 16*[1,2,3,4,5,8,9,16,25,27,32,64,81,125,128].collect({|x|2*x/x.nextPowerOfTwo}).permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
      n
    }
