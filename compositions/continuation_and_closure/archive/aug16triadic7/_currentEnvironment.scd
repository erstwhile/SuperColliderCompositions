Environment[ ('iB' -> SCTextField.new), ('iFils' -> SCTextField.new), ('iFac' -> SCTextField.new), ('mylib' -> SynthDescLib.new), ('iT' -> SCTextField.new), 
  ('iI' -> SCTextField.new), ('iCPU' -> SCTextField.new), ('iIll' -> SCTextField.new), ('iX' -> SCTextField.new), ('iF' -> SCTextField.new), 
  ('archive' -> {|f|
var path,a;
path = "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"++f.asString;
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

}.play;
}), ('panel' -> SCWindow("Values", Rect(128.0, 64.0, 420.0, 420.0)).front;) ]