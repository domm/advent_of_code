use strict;
use warnings;
use 5.030;

$_=join('',<STDIN>);s/\n\n/|/gm;s/\s/:/g;for(split/\|/){my%p=split/:/;$a++if(keys%p==8||(keys%p==7&&!$p{cid}))}say$a
