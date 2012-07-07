~superInt = Proto({
    ~step = {|x|
      (x==nil).if({~i},{~i = x.asInt; x.asInt})
    };
    ~i = 1;
    ~il = {
      ({|x|((2**x)*(~i/(2**x)%2).floor)}!~i.log2.ceil.asInt).asInt;
    };
    
    /*the log of a product is the sum of its factors;
    [2,3].product.log;
    (2.log + 3.log).exp;
    
    Change of base
    The logarithm logb(x) can be computed from the logarithms of x and b with respect to an arbitrary base k using the following formula:
    log(b,x) = (x.log/b.log)
    27.log / 3.log = 3;
    */
    ~iln = {|b=2|
      ({|x|((b**x)*(~i/(b**x)%b).floor).asInt}!(~i.log/b.log).ceil.asInt).asInt;
    };
    ~illn = {|b=3|
      (~iln.(b).log / b.log).floor.asInt;
    };
    ~ill = {
      (1+~il.()).log2.floor.asInt;
    };
    ~logDistance = {|b=2|
      var log = ~i.log/b.log;
      log - log.floor;
    };

    /*
    ill.addUniqueMethod(\orderFunc,{|to,i|
      var x = to.sort, il2 = i.log2 - i.log2.floor;
      x =x.permute((i**il2).asInt);
      to = (x.reverse[0]==0).if({x.sort;},{x;});
      to;
    });
    il.addUniqueMethod(\orderFunc,{|to,i|
      var x = to.sort, il2 = i.log2 - i.log2.floor;
      x =x.permute((i**il2).asInt);
      to = (x.reverse[0]==0).if({x.sort;},{x;});
      to;
    });
    */

    ~orderFunc = {|x|
      x.sort;
    };
    /*ratio r - can be a Float or Rational
    lower bound - make a new ratio of primes where numerator and denominator have no factor < lower
    but are closest to ~i / d
    ~i = 3
    ~imperfect.(3/2,31)
    (lower * (~i*r)).asInt.nextPrime
    returns 47/31
    */
    ~imperfect = {|r,lower|
      Rational(lower * (~i * r)).asInt.nextPrime/lower.asInt;
    };
    
    //factors-related
    //closest equivalent 
    ~roughen = {|lower|
      var x = ~i.factors;
    };
    //for an integer i, change all factors k where k is > upper, such that new k's factors are < upper
    //returns a new composite integer i where no factor is > upper
    ~smoothen = {|upper|
      var f = ~i.factors;
      f.collect({|x|
        (x < upper).if ({x},{
          (~logDistance.() < 0.5).if({
            x.nextPowerOfTwo /2;
          },{x.nextPowerOfTwo});
        });
      }).product;      
    };
});
~superInt.isPrototype = true;
~superInt.dump;

/*
the inner life of numbers
an integer is a collection of factors

63.smoothen(3) = 72
[3,3,7]
7 goes up 1 to 8
[3,3,2,2,2]
harmonically, 72/63 (8/7) is closer (more consonant) than 64/63, even though 64 satisfies the conditions and is numerically closer

63.smoothen(5)
[3,3,7];
[3,3,2,5] = 90 /63 = 10/7

an imperfect fifth method
next prime is also important
imperfect octave = next power of two, next prime, or *2, next prime
harmonically rough integer (prime limit)
81/16 instead of 5
21/16 instead of 5

*/
//unit tests
~a = ~superInt.copy;
//i equals step
~a.step(63);
(~a.i ===  ~a.step).if ({"i==step passed".postln},{"FAILED: i==step"});
(~a.il==[ 1, 2, 4, 8, 16, 32 ]).if ({"il passed".postln},{"FAILED: il"+~a.il.asString});
(~a.ill==[1,1,2,3,4,5]).if({"ill passed".postln},{"FAILED: ill"});
(~a.iln(3)==[0,0,9,54]).if({"iln(3) passed".postln},{"FAILED: iln(3)"});
(~a.iln==~a.il);
~a.iln.collect(_.class);
~a.il.collect(_.class);
~a.illn(5);
(~a.logDistance===(~a.step.log2 - ~a.step.log2.floor));
~a.logDistance(3);
~a.logDistance(5);
(~a.smoothen(2)===128);



~superFunc = Proto({
  ~func = {};
  ~average = {};
  ~interpolate = {};
  //blend that works with value envir
});