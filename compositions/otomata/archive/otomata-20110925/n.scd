{
	var p =([1,3/2,9/4,27/16,81/32,243/64]) *.x (((0..31)*2) +1)  *.x[1,3/2] *.x [1,4,16,64];
	(p *.x 63).flat.sort
}
