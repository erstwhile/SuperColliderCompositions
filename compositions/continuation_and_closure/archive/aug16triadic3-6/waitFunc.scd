{|i,il,ill|{|pp,i|
  var d = Date.getDate;
  d =( d.format("%H").asInt).factors.wrapAt(i.factors.size);
  (d < 1 ).if ({d=1},{});
  1/d
}};
