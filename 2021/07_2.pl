use 5.030;
use strict;
use warnings;

use Statistics::Basic qw(:all);

my @crabs = split( ',', <> );
my $mean  = mean(@crabs);
my $low   = int($mean);
my $high  = sprintf( '%.0f', $mean );

my $lowest = 99999999999999999;
for my $cand ( $low, $high ) {
    my $fuel;
    for my $c (@crabs) {
        for my $s ( 0 .. abs( $c - $cand ) ) {
            $fuel += $s;
        }
    }
    $lowest = $fuel if $fuel < $lowest;
}

say $lowest;

