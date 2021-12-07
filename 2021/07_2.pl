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
        my $diff = abs( $c - $cand );
        $fuel += $diff * ( $diff + 1 ) / 2;
    }
    $lowest = $fuel if $fuel < $lowest;
}

say $lowest;

