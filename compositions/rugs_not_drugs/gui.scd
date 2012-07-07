~path ="/Users/thomasgillis/dev/supercollider/sc/scd/compositions/rugs_not_drugs/archive/";

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
~initGui.();

~run = {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
};



