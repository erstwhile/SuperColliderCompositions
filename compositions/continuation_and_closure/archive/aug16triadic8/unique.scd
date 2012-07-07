{|a|var t = Array.fill(a.size);
a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
t.reject({|i|i==nil});
}
