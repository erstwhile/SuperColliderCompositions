{|f|
var path,a;
path = "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"++f.asString;
//create the temp dir
Routine {
Pipe.new("mkdir "++path,"w");
0.1.wait;

Pipe.new("chmod -R 777 "++path,"w");
0.1.wait;
a=File(path++"/_keys","w");
a.write(currentEnvironment.keys.asCompileString.asString);
a.close;
0.1.wait;
{a=File(path++"/_currentEnvironment","w");
a.write(currentEnvironment.asCompileString.asString);
a.close;}.defer;
0.1.wait;

currentEnvironment.keys.do({|x|
  (currentEnvironment.at(x).isFunction).if({
    currentEnvironment.at(x).writeArchive(path++"/"++x.asString++".scd");
    0.1.wait;
  })
});

}.play;
}
