{|i,il,ill,x|
			(il.sort.reject(_==0).reverse[0..	(ill.reverse[2].asInt.factors[0])].sum + il.sort.reject(_==0).[0..	(i.log/2).ceil.asInt].sum).asInt;		
	//([2,3,5,2,3,5,2,3,5].product).asInt	
}
