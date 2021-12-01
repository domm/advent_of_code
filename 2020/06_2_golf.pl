use strict;
use warnings;
use 5.030;

my($c,$m,%q);for(<>,$/){chomp;if(!$_){$c+=grep{$q{$_}==$m}keys%q;%q=();$m=0}else{$m++;map{$q{$_}++}split//}}say$c;

