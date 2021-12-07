use 5.030;
use strict;
use warnings;

use Statistics::Basic qw(:all);

my @crabs  = sort { $a <=> $b } map { int } split( ',', <> );

my $lowest = 99999999999999999;
for my $cand ($crabs[0] .. $crabs[-1]) {
    my $fuel;
    for my $c (@crabs) {
        for my $s (0 .. abs( $c - $cand )) {
            $fuel+=$s;
        }
    }
    $lowest = $fuel if $fuel < $lowest;
    say $cand if $cand % 100 == 0;
}

say $lowest;

