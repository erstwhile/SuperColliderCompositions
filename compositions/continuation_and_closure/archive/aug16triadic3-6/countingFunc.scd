{|i, il, ill|
  var d = Date.getDate, min, sec, hr, day, mt;
  hr = (2**d.format("%H").asInt);
  min = (d.format("%M").asInt.factors.wrapAt(i.factors.size)).clip(2,60);
  sec = (d.format("%s").asInt%3600);
  day = d.format("%d").asInt.factors.wrapAt(d.format("%M").asInt);
  ((i%(min+day))+ (sec * (2**sec.log.ceil)) + (2**(d.format("%M").asInt.factors.log2.ceil)).sum  +hr).asInt;
}
