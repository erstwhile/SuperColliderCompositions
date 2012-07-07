~num = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
~products = Array.fill(1000);
Routine {
  Routine {
    1000.do({|x|
      var t,a = Array.fill(5);
          5.do({|i|
            var b =  ~num.wrapAt(x+i).digit;
            a.put(i,b);
          });
          (a.product > 16).if ({ 
            t = Synth("just-sine");
            t.set(\freq,a.product);
            t.set(\rel,a.product.log2);
            t.set(\sus,-6);
            t.set(\amp,32);
            t.set(\atk,1/a.product);
            t.set(\gate,1);
          });
          ~products.put(x,a.product);
      (1/8).wait;
    });
      ~products.sort.reverse[0].postln;
  //the leap between any 2 notes in this sequence will always a melodic interval (greater than a 2nd) in a 7 limit scale

  ~synthFactory.("euler-8",{|freq=32,i=1,next|
    var b = SinOsc,p = PinkNoise.ar((freq+32).log2/i,freq),x;
    b.ar(freq,b.ar(p,0,i*pi,0),1/(freq+256));
  }, {[-1,1]},Server.internal);

  //~bum = ~num.split($0).join;
  ~bum = ~num;
  ~products = Array.fill(~bum.size);
    ~products.size.do({|x|
      var a = Array.fill(5);
          5.do({|i|
            var b =  ~bum.wrapAt(x+i).digit;
            a.put(i,b);
          });
          Routine {
          5.do({|r|
            r=r+2;
            (a.product>24).if({
            a.collect({|b,i|
              var t,s;
                 t = Synth("euler-8");
                 t.set(\i,1/b);
                 t.set(\freq,(a.product < (2**13)).if({a.product / b}),{a.product.log2 * 32 /b});
                 t.set(\next,~bum.wrapAt(x+i+1).digit.nextPowerOfTwo/~bum.wrapAt(x+i+1).digit);
                 t.set(\rel,r/a.product.log10);
                 t.set(\sus,1);
                 t.set(\pan,[-1,-0.5,0,0.5,1].wrapAt(i+r));
                 t.set(\amp,32* 2/((i+2).factors[0]) * (1/r.log2));
                 t.set(\atk,r/(a.product.log10));
                 t.set(\gate,1);
                 Routine {
                    (r/(a.product.log10)).wait;
                    t.set(\gate,0);
                 }.play;

                 s = Synth("just-sine");
                 s.set(\i,1/b);
                s.set(\freq,(a.product < (2**13)).if({a.product * (b.nextPowerOfTwo/b)}),{a.product.log2 * 32 * (b.nextPowerOfTwo/b)});
                 s.set(\rel,r/a.product.log10);
                 s.set(\sus,-6 + b.log2);
                 s.set(\pan,[-1,-0.5,0,0.5,1].wrapAt(i+r));
                 s.set(\amp,32* 2/((i+2).factors[0]) * (1/r.log2));
                 s.set(\atk,1/(a.product.log2**r));
                 s.set(\gate,1);
                 (1/6).wait;
              });
            })
          });
        }.play;
          ~products.put(x,a.product);
      (1).wait;
    });
      ~products.sort.reverse[0].postln;
  }.play;
  
}.play;