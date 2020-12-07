use strict;
use warnings;
use 5.030;

my%a;for(<>){my($a,$b)=$_=~/^(.*?).bags.contain.(.*)\.$/; $a{$a}=[grep{$_->[1]=~/^\d+$/}map{/^(\d+).(.*?).bags?/;[$2,$1]}split(/,./,$b)]}my$c=sub{my($a,$b)=($_[0],1);map{$b+=$_->[1]*__SUB__->($_->[0])}$a{$a}->@*;$b};say $c->(qq{shiny$"gold})-1;
