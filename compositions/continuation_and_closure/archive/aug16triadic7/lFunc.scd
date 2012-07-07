{|i,il,ill,j,k,p|
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

}
