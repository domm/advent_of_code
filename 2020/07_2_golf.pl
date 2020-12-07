use strict;
use warnings;
use 5.030;

my%a;for(<>){($a,$b)=$_=~/^(.*?).ba.*ain.(.*)\.$/;$a{$a}=[grep{$_->[1]=~/\d+/}map{/(\d+).(.*?).bags?/;[$2,$1]}split/,./,$b]}$a=sub{my($a,$b)=($_[0],1);map{$b+=$_->[1]*__SUB__->($_->[0])}$a{$a}->@*;$b};say&$a("shiny$\"gold")-1
