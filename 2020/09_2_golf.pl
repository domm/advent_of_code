use strict;
use warnings;
use 5.030;

eval(qq{use$"List::Util"min","max","sum"});my$s=shift;my@x=map{chomp;$_}<>;my@y=@x;$b=sub{my%l=map{$_,1}@x[0..$s-1];for(keys%l){if($l{$x[$s]-$_}){return"1"}}};while(1){&$b?shift@x:last}my$t=$x[$s];while(1){my@t=@y;my@z;while(1){push(@z,shift@t);my$r=sum(@z);if($r==$t){say(min(@z)+max(@z));exit}if($r>$t){last}}shift(@y)}

