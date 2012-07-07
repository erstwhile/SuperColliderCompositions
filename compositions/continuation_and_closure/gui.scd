~path ="/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/";

~archive = {|f,completeAction=({"done".postln;})|
var path,a;
path = ~path++f.asString;
//create the temp dir
Routine {
Pipe.new("mkdir "++path,"w");
0.1.wait;

Pipe.new("chmod -R 777 "++path,"w");
0.1.wait;

a=File(path++"/_keys.scd","w");
a.write(currentEnvironment.keys.asCompileString.asString);
a.close;
0.1.wait;
{a=File(path++"/_currentEnvironment.scd","w");
a.write(currentEnvironment.asCompileString.asString);
a.close;}.defer;
0.1.wait;

currentEnvironment.keys.do({|x|
  (currentEnvironment.at(x).isFunction).if({
    currentEnvironment.at(x).writeArchive(path++"/"++x.asString++".scd");
    0.1.wait;
  })
});
completeAction.();
}.play;
};

//~archive.("migratory-0");


~restore = {|f|
  var path = ~path ++f, keys,file;
  keys = Object.readArchive(path++"/_keys.scd");
  keys.postln;
  keys.asArray.do({|key|
    file = path++"/"++key++".scd";
    (File.exists(file)).if({currentEnvironment.put(key.asSymbol,Object.readArchive(file));
    });
  })
};
//~restore.("migratory-0");

~refresh = {|f|
  ~archive.(f,~restore.(f));
};
//~refresh.("aug16triadic3-3");




~restoreFull = {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
};
//~restoreFull.("aug16triadic6");
//new integer method - 
//replace a factor with the nearest composite which is smooth for some value x
//[2,5,7] = 70  := [2,[2,3],[2,3]] = 72;  do this to change harmony of existing scale
//same goes for the other way around: imperfect 5ths, or replacing a composite w/ nearest prime

//polynomial gates - the zero crossings of a  polynomial function along a bitmap
~initGui.();

~run = {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
};



/*

todo 
  gui for save / restore (with filesystem browser?)
    Super-functions to interpolate 2 functions
      linear average
      oscillating average (with period)
      the returned function should be connected to the original...one changes and the other changes too
      a = blend({|x|x.nthPrime},{|x|2**x},{|f|f})
      where f as the blend frac is the logDistance of some int
*/