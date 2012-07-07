{|p,ill,i,j|
  var il;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  p=i.factors.wrapAt(ill.sort.reverse.wrapAt(ill.sum.log2)).log2.ceil;
  [(1/[3,6,6].stutter(~x.log2.ceil.asInt.factors.reverse[0])).wrapAt(~x),[1,2].stutter(~x.log2.ceil.asInt.factors.reverse[0]).wrapAt(~x)/3].flat.wrapAt(~x);
}
