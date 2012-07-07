{|i, ill, p, pp,l| 
    [
      {((4/(4+(i.log/16).floor))*((24+l)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.6+l)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}
