Environment[ ('notesFunc' -> { |i,il,ill|
  var n = [8,128/7,32/3,24,27,28,4,20,6,30,36,45,54].permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
  n
}), ('iB' -> SCTextField.new), ('clock' -> TempoClock.new), ('iFils' -> SCTextField.new), ('iFac' -> SCTextField.new), 
  ('atkFunc' -> {|i, ill, k, j, pp|
  (1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
}), ('mylib' -> SynthDescLib.new), ('iT' -> SCTextField.new), ('iI' -> SCTextField.new), ('incrementFunc' -> {|i,d,n|
  (i+(2**n)).asInt;
}), 
  ('susFunc' -> {|i,j,k,l|
  -1 * i.factors.wrapAt(j+k+l).log10;
}), ('iCPU' -> SCTextField.new), ('relFunc' -> {|i, ill, p, pp| 
    [
      {((4/(4+(i.log/16).floor))*((26)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.7)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), ('iF' -> SCTextField.new), ('kFunc' -> {|i,il,ill,j,p|
  3;
}), 
  ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
  var qq, js;
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
  qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
  js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* qq) * 
  [((2*l)+1),(l+1),(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.sort.reverse[4].asInt.factors.reverse[0])  * 
  (1+(2*(k%ill.sort.reverse[1].asInt.factors.reverse[0]))))
}), ('archive' -> {|f|
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
}), ('waitFunc' -> {|i,il,ill|{|pp,i|[pp.log2.ceil/3,pp.log2.ceil/2].wrapAt(i.factors.sum)/(2**i.factors.size)}}), ('running' -> Dictionary[ (889437 -> 1), (889352 -> 1), (888829 -> 1), (888834 -> 1), (888669 -> 1), 
  (888688 -> 1), (888679 -> 1), (888277 -> 1), (889273 -> 1), (889327 -> 1), 
  (888576 -> 1), (818273 -> 1), (889382 -> 1), (889540 -> 1), (888268 -> 1), 
  (888573 -> 1), (889379 -> 1), (752958 -> 1), (889354 -> 1), (888280 -> 1), 
  (888429 -> 1), (889141 -> 1), (889458 -> 1), (889168 -> 1), (889464 -> 1), 
  (888195 -> 1), (888278 -> 1), (888561 -> 1), (889081 -> 1), (889186 -> 1), 
  (889485 -> 1), (889146 -> 1), (888856 -> 1), (888749 -> 1), (889164 -> 1), 
  (888566 -> 1), (888980 -> 1), (889371 -> 1), (888192 -> 1), (889120 -> 1), 
  (888763 -> 1), (889358 -> 1), (888924 -> 1), (888250 -> 1), (889465 -> 1), 
  (889336 -> 1), (889102 -> 1), (888824 -> 1), (889582 -> 1), (888643 -> 1), 
  (888569 -> 1), (889459 -> 1), (889473 -> 1), (889391 -> 1), (753006 -> 1), 
  (889589 -> 1), (888709 -> 1), (888234 -> 1), (889584 -> 1), (889532 -> 1), 
  (889571 -> 1), (889116 -> 1), (888436 -> 1), (889040 -> 1), (753005 -> 1), 
  (889345 -> 1), (888692 -> 1), (889547 -> 1), (888457 -> 1), (888252 -> 1), 
  (888782 -> 1), (888816 -> 1), (889576 -> 1), (889581 -> 1), (888720 -> 1), 
  (888812 -> 1), (752996 -> 1), (888245 -> 1), (889572 -> 1), (888707 -> 1), 
  (818276 -> 1), (888456 -> 1), (888705 -> 1), (888454 -> 1), (888951 -> 1), 
  (888472 -> 1), (888560 -> 1), (888728 -> 1), (888704 -> 1), (889333 -> 1), 
  (888453 -> 1), (888724 -> 1), (889140 -> 1), (889274 -> 1), (889362 -> 1), 
  (888706 -> 1), (888489 -> 1), (889461 -> 1), (888752 -> 1), (888927 -> 1), 
  (889365 -> 1), (889342 -> 1), (889032 -> 1), (889566 -> 1), (889573 -> 1), 
  (889268 -> 1), (888838 -> 1), (888554 -> 1), (889165 -> 1), (888843 -> 1), 
  (888758 -> 1), (889227 -> 1), (888502 -> 1), (889346 -> 1), (889042 -> 1), 
  (888825 -> 1), (889204 -> 1), (888555 -> 1), (889534 -> 1), (888745 -> 1), 
  (888191 -> 1), (889181 -> 1), (889455 -> 1), (752968 -> 1), (889091 -> 1), 
  (752985 -> 1), (889497 -> 1), (889339 -> 1), (888747 -> 1), (888518 -> 1), 
  (889531 -> 1), (889099 -> 1), (888658 -> 1), (888760 -> 1), (888675 -> 1), 
  (888817 -> 1), (888652 -> 1), (889212 -> 1), (889106 -> 1), (889344 -> 1), 
  (888700 -> 1), (889370 -> 1), (889161 -> 1), (888460 -> 1), (889541 -> 1), 
  (888685 -> 1), (888440 -> 1), (889536 -> 1), (889380 -> 1), (752994 -> 1), 
  (889213 -> 1), (889084 -> 1), (888698 -> 1), (889463 -> 1), (752970 -> 1), 
  (888187 -> 1), (888950 -> 1), (888682 -> 1), (889446 -> 1), (889080 -> 1), 
  (888725 -> 1), (889325 -> 1), (752978 -> 1), (888750 -> 1), (752966 -> 1), 
  (888666 -> 1), (889335 -> 1), (888819 -> 1), (889324 -> 1), (888182 -> 1), 
  (889453 -> 1), (889355 -> 1), (888530 -> 1), (889472 -> 1), (888697 -> 1), 
  (888674 -> 1), (888940 -> 1), (889226 -> 1), (888854 -> 1), (889479 -> 1), 
  (752949 -> 1), (888635 -> 1), (889328 -> 1), (889139 -> 1), (888175 -> 1), 
  (888467 -> 1), (888237 -> 1), (888533 -> 1), (888798 -> 1), (752952 -> 1), 
  (889318 -> 1), (889111 -> 1), (888971 -> 1), (888606 -> 1), (889293 -> 1), 
  (888670 -> 1), (752973 -> 1), (888241 -> 1), (888558 -> 1), (888532 -> 1), 
  (889433 -> 1), (888906 -> 1), (752959 -> 1), (888432 -> 1), (888564 -> 1), 
  (888714 -> 1), (889431 -> 1), (888462 -> 1), (888510 -> 1), (889445 -> 1), 
  (888811 -> 1), (889476 -> 1), (888671 -> 1), (889276 -> 1), (888477 -> 1), 
  (889447 -> 1), (889496 -> 1), (889480 -> 1), (888795 -> 1), (888463 -> 1), 
  (888981 -> 1), (888789 -> 1), (888687 -> 1), (888694 -> 1), (889405 -> 1), 
  (888437 -> 1), (889134 -> 1), (889404 -> 1), (889036 -> 1), (888659 -> 1), 
  (888424 -> 1), (888507 -> 1), (889113 -> 1), (888667 -> 1), (889601 -> 1), 
  (889481 -> 1), (888761 -> 1), (888857 -> 1), (888255 -> 1), (889137 -> 1), 
  (888180 -> 1), (889191 -> 1), (888828 -> 1), (889554 -> 1), (889279 -> 1), 
  (888200 -> 1), (888581 -> 1), (888911 -> 1), (753007 -> 1), (889439 -> 1), 
  (888841 -> 1), (888186 -> 1), (888810 -> 1), (889372 -> 1), (889599 -> 1), 
  (889575 -> 1), (888248 -> 1), (889548 -> 1), (753001 -> 1), (888815 -> 1), 
  (889369 -> 1), (888827 -> 1), (889384 -> 1), (888681 -> 1), (889107 -> 1), 
  (888853 -> 1), (888842 -> 1), (888974 -> 1), (889592 -> 1), (888948 -> 1), 
  (888794 -> 1), (889561 -> 1), (752960 -> 1), (889471 -> 1), (888726 -> 1), 
  (889231 -> 1), (889432 -> 1), (889549 -> 1), (889413 -> 1), (888642 -> 1), 
  (888570 -> 1), (889562 -> 1), (888587 -> 1), (888727 -> 1), (888480 -> 1), 
  (888823 -> 1), (888804 -> 1), (889192 -> 1), (888949 -> 1), (888207 -> 1), 
  (889195 -> 1), (888578 -> 1), (888546 -> 1), (889086 -> 1), (889594 -> 1), 
  (888807 -> 1), (889188 -> 1), (888855 -> 1), (888509 -> 1), (888729 -> 1), 
  (888957 -> 1), (889159 -> 1), (888639 -> 1), (889122 -> 1), (888636 -> 1), 
  (889182 -> 1), (889033 -> 1), (889088 -> 1), (889435 -> 1), (888678 -> 1), 
  (888485 -> 1), (888746 -> 1), (889177 -> 1), (888503 -> 1), (888201 -> 1), 
  (888251 -> 1), (888246 -> 1), (889454 -> 1), (889219 -> 1), (889101 -> 1), 
  (888979 -> 1), (888524 -> 1), (752998 -> 1), (889320 -> 1), (889288 -> 1), 
  (889044 -> 1), (888620 -> 1), (888626 -> 1), (889115 -> 1), (889542 -> 1), 
  (889283 -> 1), (889559 -> 1), (889383 -> 1), (888461 -> 1), (888516 -> 1), 
  (889218 -> 1), (889148 -> 1), (888253 -> 1), (889130 -> 1), (889176 -> 1), 
  (888699 -> 1), (889544 -> 1), (888283 -> 1), (888806 -> 1), (888788 -> 1), 
  (888206 -> 1), (889329 -> 1), (888624 -> 1), (889590 -> 1), (889477 -> 1), 
  (889457 -> 1), (889390 -> 1), (889278 -> 1), (888455 -> 1), (888506 -> 1), 
  (888264 -> 1), (889440 -> 1), (889351 -> 1), (888199 -> 1), (889412 -> 1), 
  (889538 -> 1), (889350 -> 1), (888910 -> 1), (889484 -> 1), (888490 -> 1), 
  (888281 -> 1), (889214 -> 1), (889591 -> 1), (889090 -> 1), (888632 -> 1), 
  (888481 -> 1), (888599 -> 1), (889178 -> 1), (889434 -> 1), (889281 -> 1), 
  (888840 -> 1), (889526 -> 1), (888708 -> 1), (889596 -> 1), (888189 -> 1), 
  (889427 -> 1), (888607 -> 1), (888970 -> 1), (889272 -> 1), (752988 -> 1), 
  (888435 -> 1), (888653 -> 1), (752977 -> 1), (888741 -> 1), (889428 -> 1), 
  (889600 -> 1), (888476 -> 1), (888279 -> 1), (752967 -> 1), (888982 -> 1), 
  (889322 -> 1), (889082 -> 1), (888902 -> 1), (888956 -> 1), (889449 -> 1), 
  (889118 -> 1), (889533 -> 1), (889286 -> 1), (889597 -> 1), (888511 -> 1), 
  (888438 -> 1), (889430 -> 1), (888535 -> 1), (888664 -> 1), (888637 -> 1), 
  (889347 -> 1), (889537 -> 1), (889377 -> 1), (888748 -> 1), (889047 -> 1), 
  (889394 -> 1), (888983 -> 1), (889155 -> 1), (889331 -> 1), (889425 -> 1), 
  (889360 -> 1), (888718 -> 1), (888447 -> 1), (888534 -> 1), (889135 -> 1), 
  (889163 -> 1), (888487 -> 1), (888627 -> 1), (889539 -> 1), (889407 -> 1), 
  (888610 -> 1), (888247 -> 1), (889556 -> 1), (888612 -> 1), (889577 -> 1), 
  (888580 -> 1), (889374 -> 1), (889100 -> 1), (752943 -> 1), (752945 -> 1), 
  (889583 -> 1), (889397 -> 1), (889426 -> 1), (889462 -> 1), (889149 -> 1), 
  (889543 -> 1), (889154 -> 1), (889402 -> 1), (888686 -> 1), (888740 -> 1), 
  (889523 -> 1), (752950 -> 1), (888744 -> 1), (888547 -> 1), (752956 -> 1), 
  (888197 -> 1), (889359 -> 1), (889105 -> 1), (888793 -> 1), (889138 -> 1), 
  (889267 -> 1), (888813 -> 1), (888717 -> 1), (888835 -> 1), (889348 -> 1), 
  (888799 -> 1), (888240 -> 1), (888809 -> 1), (889366 -> 1), (752980 -> 1), 
  (889089 -> 1), (888665 -> 1), (888170 -> 1), (888914 -> 1), (818274 -> 1), 
  (889424 -> 1), (889441 -> 1), (888568 -> 1), (889174 -> 1), (889332 -> 1), 
  (888976 -> 1), (889225 -> 1), (888781 -> 1), (888523 -> 1), (888668 -> 1), 
  (888791 -> 1), (888486 -> 1), (889266 -> 1), (888458 -> 1), (889039 -> 1), 
  (888520 -> 1), (889179 -> 1), (889041 -> 1), (889565 -> 1), (753009 -> 1), 
  (888522 -> 1), (889386 -> 1), (888785 -> 1), (889209 -> 1), (888723 -> 1), 
  (889197 -> 1), (752976 -> 1), (888693 -> 1), (888444 -> 1), (889398 -> 1), 
  (889475 -> 1), (889467 -> 1), (752961 -> 1), (888600 -> 1), (888917 -> 1), 
  (752954 -> 1), (888194 -> 1), (889422 -> 1), (889373 -> 1), (888517 -> 1), 
  (888928 -> 1), (889098 -> 1), (889474 -> 1), (888443 -> 1), (889353 -> 1), 
  (889401 -> 1), (889142 -> 1), (889038 -> 1), (889568 -> 1), (752983 -> 1), 
  (752971 -> 1), (888269 -> 1), (889451 -> 1), (888466 -> 1), (888641 -> 1), 
  (888188 -> 1), (888550 -> 1), (888185 -> 1), (889450 -> 1), (818272 -> 1), 
  (888613 -> 1), (888171 -> 1), (888689 -> 1), (889185 -> 1), (889277 -> 1), 
  (888571 -> 1), (889189 -> 1), (889282 -> 1), (888449 -> 1), (889114 -> 1), 
  (888759 -> 1), (889172 -> 1), (888787 -> 1), (889587 -> 1), (888552 -> 1), 
  (888584 -> 1), (888713 -> 1), (888633 -> 1), (889110 -> 1), (888918 -> 1), 
  (889469 -> 1), (888198 -> 1), (752995 -> 1), (888737 -> 1), (888611 -> 1), 
  (888625 -> 1), (889211 -> 1), (889334 -> 1), (889323 -> 1), (889399 -> 1), 
  (889180 -> 1), (888684 -> 1), (889224 -> 1), (889545 -> 1), (889381 -> 1), 
  (889392 -> 1), (888680 -> 1), (889043 -> 1), (888913 -> 1), (889551 -> 1), 
  (889406 -> 1), (888196 -> 1), (888719 -> 1), (889574 -> 1), (889524 -> 1), 
  (889289 -> 1), (752982 -> 1), (888786 -> 1), (888696 -> 1), (888944 -> 1), 
  (889403 -> 1), (888677 -> 1), (753000 -> 1), (888715 -> 1), (888276 -> 1), 
  (889160 -> 1), (889156 -> 1), (888575 -> 1), (889222 -> 1), (888702 -> 1), 
  (889287 -> 1), (889444 -> 1), (889028 -> 1), (889569 -> 1), (888609 -> 1), 
  (888442 -> 1), (888536 -> 1), (888450 -> 1), (889423 -> 1), (888790 -> 1), 
  (888929 -> 1), (888459 -> 1), (888783 -> 1), (889343 -> 1), (888657 -> 1), 
  (889147 -> 1), (888445 -> 1), (889292 -> 1), (888822 -> 1), (888792 -> 1), 
  (889330 -> 1), (753003 -> 1), (889340 -> 1), (888716 -> 1), (889097 -> 1), 
  (888736 -> 1), (888515 -> 1), (888448 -> 1), (889585 -> 1), (888978 -> 1), 
  (889553 -> 1), (888660 -> 1), (888923 -> 1), (752951 -> 1), (888473 -> 1), 
  (889169 -> 1), (888784 -> 1), (889376 -> 1), (888464 -> 1), (888851 -> 1), 
  (888676 -> 1), (888433 -> 1), (888452 -> 1), (889530 -> 1), (888814 -> 1), 
  (818238 -> 1), (888562 -> 1), (889321 -> 1), (889131 -> 1), (888482 -> 1), 
  (889337 -> 1), (888488 -> 1), (888508 -> 1), (888977 -> 1), (888710 -> 1), 
  (888634 -> 1), (888638 -> 1), (889396 -> 1), (889361 -> 1), (889375 -> 1), 
  (889194 -> 1), (889470 -> 1), (888493 -> 1), (752999 -> 1), (889210 -> 1), 
  (888551 -> 1), (889378 -> 1), (889170 -> 1), (888190 -> 1), (752993 -> 1), 
  (888945 -> 1), (889157 -> 1), (889367 -> 1), (889184 -> 1), (888921 -> 1), 
  (888193 -> 1), (888585 -> 1), (889215 -> 1), (888282 -> 1), (889230 -> 1), 
  (752953 -> 1), (889429 -> 1), (888941 -> 1), (888265 -> 1), (888952 -> 1), 
  (888446 -> 1), (889158 -> 1), (888430 -> 1), (889586 -> 1), (889123 -> 1), 
  (818275 -> 1), (889349 -> 1), (888925 -> 1), (888926 -> 1), (752948 -> 1), 
  (888964 -> 1), (889112 -> 1), (888577 -> 1), (889085 -> 1), (889363 -> 1), 
  (753008 -> 1), (889193 -> 1), (888431 -> 1), (889598 -> 1), (889175 -> 1), 
  (889208 -> 1), (889119 -> 1), (889275 -> 1), (889083 -> 1), (888780 -> 1), 
  (889436 -> 1), (752965 -> 1), (889567 -> 1), (888661 -> 1), (888721 -> 1), 
  (888621 -> 1), (889095 -> 1), (889026 -> 1), (889187 -> 1), (889171 -> 1), 
  (889385 -> 1), (888751 -> 1), (889223 -> 1), (752962 -> 1), (889558 -> 1), 
  (888579 -> 1), (888184 -> 1), (888601 -> 1), (888703 -> 1), (888249 -> 1), 
  (888586 -> 1), (888963 -> 1), (888922 -> 1), (888537 -> 1), (889468 -> 1), 
  (889522 -> 1), (888973 -> 1), (889143 -> 1), (888484 -> 1), (888839 -> 1), 
  (889546 -> 1), (889388 -> 1), (888852 -> 1), (889096 -> 1), (888711 -> 1), 
  (752957 -> 1), (889094 -> 1), (888465 -> 1), (888181 -> 1), (889136 -> 1), 
  (889527 -> 1), (889221 -> 1), (889205 -> 1), (889578 -> 1), (888174 -> 1), 
  (889037 -> 1), (888808 -> 1), (888492 -> 1), (888846 -> 1), (888805 -> 1), 
  (889563 -> 1), (888567 -> 1), (889183 -> 1), (889121 -> 1), (889109 -> 1), 
  (888640 -> 1), (889535 -> 1), (889364 -> 1), (752981 -> 1), (888915 -> 1), 
  (888916 -> 1), (888235 -> 1), (888491 -> 1), (889456 -> 1), (888953 -> 1), 
  (888204 -> 1), (888513 -> 1), (889117 -> 1), (888975 -> 1), (888205 -> 1), 
  (888521 -> 1), (888972 -> 1), (889555 -> 1), (752987 -> 1), (889452 -> 1), 
  (889387 -> 1), (888683 -> 1), (889196 -> 1), (889326 -> 1), (888765 -> 1), 
  (888559 -> 1), (889284 -> 1), (888565 -> 1), (888850 -> 1), (888428 -> 1), 
  (888742 -> 1), (888514 -> 1), (888483 -> 1), (752974 -> 1), (888847 -> 1), 
  (889269 -> 1), (888802 -> 1), (888441 -> 1), (889443 -> 1), (889220 -> 1), 
  (888722 -> 1), (889393 -> 1), (752975 -> 1), (888920 -> 1), (889466 -> 1), 
  (889460 -> 1), (888912 -> 1), (888695 -> 1), (888965 -> 1), (888183 -> 1), 
  (888598 -> 1), (753002 -> 1), (888563 -> 1), (889229 -> 1), (889046 -> 1), 
  (752963 -> 1), (888962 -> 1), (889593 -> 1), (888803 -> 1), (888826 -> 1), 
  (889108 -> 1), (888425 -> 1), (889389 -> 1), (888531 -> 1), (888764 -> 1), 
  (889442 -> 1), (889570 -> 1), (889280 -> 1), (888512 -> 1), (888830 -> 1), 
  (888774 -> 1), (752997 -> 1), (889104 -> 1), (889395 -> 1), (889400 -> 1), 
  (888907 -> 1), (888656 -> 1), (889045 -> 1), (889087 -> 1), (889580 -> 1), 
  (752944 -> 1), (889588 -> 1), (888439 -> 1), (888762 -> 1), (889528 -> 1), 
  (888712 -> 1), (888254 -> 1), (888775 -> 1), (888572 -> 1), (888519 -> 1), 
  (888753 -> 1), (889145 -> 1), (888553 -> 1), (889595 -> 1), (888903 -> 1), 
  (889027 -> 1), (889319 -> 1), (888525 -> 1), (889173 -> 1), (889448 -> 1), 
  (888701 -> 1), (888244 -> 1), (888574 -> 1), (752990 -> 1), (888451 -> 1), 
  (889162 -> 1), (888608 -> 1), (889552 -> 1), (888743 -> 1), (889228 -> 1), 
  (888818 -> 1), (889438 -> 1), (752986 -> 1), (889525 -> 1), (889144 -> 1), 
  (752984 -> 1), (889029 -> 1), (888434 -> 1), (889338 -> 1), (889550 -> 1), 
  (888662 -> 1), (889579 -> 1), (889341 -> 1), (889564 -> 1), (888663 -> 1), 
  (888919 -> 1), (889368 -> 1), (889529 -> 1), (889103 -> 1), (888236 -> 1), 
  (889478 -> 1), (818271 -> 1), (889285 -> 1), (889560 -> 1), (889190 -> 1), 
  (889557 -> 1), (888831 -> 1) ]), ('lFunc' -> {|i,il,ill,j,k,p|
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

}), 
  ('r' -> Routine({
8.do({|n|  
  var a;
  a = (2**(n +12)).asInt;
  ~i =a;
  (2**13).asInt.do({|x|
      var i=~i;
      ~play.value(a+i.asInt,x.asInt);
      ~i = ~incrementFunc.value(i.asInt,a,n);
      {~iX.string = x;}.defer;
    });
  });
240.wait;
z.freeAll;
})), ('pFunc' -> {|ill, ils, p|
    p=p.nextPowerOfTwo;
  (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
}), ('allServers' -> Set[ Server.fromName('internal'), Server.fromName('localhost') ]), ('ampFunc' -> {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 2  * (1/(l+1)) * (1/(k+3).log)
    *(p.sqrt 
    * (c1/(pp+c2).log10)))
  }), ('panFunc' -> {|i, j, ii,k,l|
  ((1/(i.factors.size)) * (-1**(ii+j)) + (((2+k.log2)-1)**(-1**(k+l))) - (((2+l.log2)-1)**(-1**(k+l)))).clip(-0.5,0.25)
}), 
  ('i' -> 13628), ('n' -> OSCresponderNode.new), ('countingFunc' -> {|i, il, ill|
  var ils = 2-(i.log2-i.log2.floor),fils,iFunc, il2 = (i.log2-i.log2.floor), lt,f=0;
  lt = ill.sort.reverse[1].asInt.factors.reverse[0];
  {~iF.string = "il2"+il2; ~iFils.string = lt;  ~iB.string = ill.sum; ~iT.string = "test: "+((ill.sum**il2)*il2)}.defer;

  f=(((ill.sum**il2)*il2) > lt).if({0},{1});
  [
  {
    fils = {|ff,l|
      var r=ff;
      l.do({
      r=r**ff;
      });
      //clip r
      r.clip(0,i.log2.ceil.asInt).floor;
    };
  
    ill.sort.reverse[1].asInt.factors.reverse[0].do({|x|
      (fils.(ils,x));
      });
      {((ill.sort.reverse[1].asInt.factors.reverse[0].collect({|x|i%  
        il.sort.flat.reverse.wrapAt(fils.(ils,x))}).sum)).ceil.asInt}.value;
  }, 
  { 
    ( il.sort.reverse[0] + il.reverse[1] + il.sort.reverse.wrapAt(i.log10-1) 
    +(i%il.sort.reverse.wrapAt(i.log10+1))+ (i%il.sort.reverse.wrapAt(i.log10-2))).ceil.asInt;
  }].permute(ill.reverse[0].asInt).wrapAt(f).value.asInt;
}), ('iIll' -> SCTextField.new), ('iX' -> SCTextField.new), 
  ('play' -> {|i,x|
    var il,ill,r,ii,w,e,ils = 2-(i.log2-i.log2.floor);
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
    e = Environment.make({~i = i; ~il = il; ~ill = ill;~x=x;});
    e.know = true;
    {~iIll.string = ill;}.defer;
    e.ils = ils;
    e.ii = i;
    i= ~countingFunc.valueWithEnvir(e);
    e.i = i;
    {~iI.string = i;}.defer;
    {~iFac.string = i.factors}.defer;
    e.hf = (i.factors.reverse[0].nextPowerOfTwo**2);
    w = ~waitFunc.valueWithEnvir(e);
    e.n = ~notesFunc.valueWithEnvir(e);
    ~tempo = ((e.ill.sum/2).log2)/5;

    r = Routine {
      i.factors.do({|p,j|
        var rr;
        e.p =p; e.j =j;
        rr = Routine {
        (~kFunc.valueWithEnvir(e)).do({|k|
          e.k = k;
          e.pp = i.factors[j];
          (~lFunc.valueWithEnvir(e)).do({|l|
            var s,freq,pitchCorrect;
            s = Synth("just-sine"); 
            e.l =l; e.p = p;
            ~running.put(s.nodeID,1);
            p=~pFunc.valueWithEnvir(e);
            e.l =l; e.p = p;
            freq = ~pitchFunc.valueWithEnvir(e);
            e.freq = freq;
            freq = ~harmonicFunc.valueWithEnvir(e);
            pitchCorrect = {|f,i,safe|
              f=f.abs;
              (f < (2**14)).or(safe >20).if ({f=f;},{ f=pitchCorrect.(f / (2**( i.factors.size.clip(2,i.log.ceil.asInt))),i,safe+1);});
              f;
            };
            
            freq = pitchCorrect.(freq,i,0);
            pitchCorrect = {|f,i,safe|
              f=f.abs;
              (f > 48).or(safe>20).if ({ f=f; },{ f= pitchCorrect.(f  * (16),i,safe+1);});
              f;
            };
            freq = pitchCorrect.(freq,i,0);
            s.set(\freq, freq);
            s.set(\rel,~relFunc.valueWithEnvir(e));
            s.set(\pan,~panFunc.valueWithEnvir(e));
            s.set(\atk, ~atkFunc.valueWithEnvir(e));
            s.set(\sus, ~susFunc.valueWithEnvir(e));
            s.set(\bassCutoff, 256);
            s.set(\gate,1); 
            s.set(\amp,~ampFunc.valueWithEnvir(e));         
           });
          w.(i.factors[j],i).wait;
        });
      };
      ~clock.play(rr,0);
      });
    };
    ~clock.play(r,0);
    (1/3).wait;
}), ('tempo' -> 0.97159619902551), ('harmonicFunc' -> {|i, il, j, freq, hf,x,mod,k|
   freq * ((hf + (k * ([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(j+i.factors.size))))/(hf));
}), ('panel' -> SCWindow("Values", Rect(1291.0, 353.0, 420.0, 420.0)).front;) ]