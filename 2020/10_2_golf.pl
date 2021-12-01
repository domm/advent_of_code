use strict;
use warnings;
use 5.030;

my@t=(0,1,1,2,4,7);my@a=sort{$a<=>$b}0,map{chomp;$_}<>;push(@a,$a[-1]+3);my@s=0;my$r=1;my$i=1;for(@a){push(@s,$_);if(($a[$i++]-$s[-1])==3){$r*=$t[@s-1];@s=$s[-1]}}say$r
