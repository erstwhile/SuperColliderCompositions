{ |i,il,ill|      var n = 16*[1,2,3,4,5,7,8,9,11,16,25,27,32,49,64,81,121,125,128].collect({|x|2*x/x.nextPowerOfTwo}).permute(il.sort.reverse.wrapAt(i.factors.wrapAt(i)).asInt);      n    }
