use strict;
use warnings;
use 5.030;
no strict 'refs';

my $ts = <>;
my @bus = split(',',<>);

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper {
ts =>$ts,
bus =>\@bus
};

my $choose='x';
my $wait=10000000;
foreach my $b (@bus) {
    next if $b eq 'x';
    my $f = int($ts / $b);
    my $next = $b * ($f + 1);
    if ($next < $wait) {
        say "$b : $next";
        $wait = $next;
        $choose = $b;
    }
}

say "$choose at $wait";
say (($wait-$ts) * $choose);

