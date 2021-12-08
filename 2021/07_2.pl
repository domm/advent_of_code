use 5.030;
use strict;
use warnings;

use Statistics::Basic qw(:all);

my @crabs = split( ',', <> );
my $mean  = mean(@crabs);

my $res=0;
for my $cand ( int($mean), sprintf( '%.0f', $mean ) ) {
    my $fuel;
    for my $c (@crabs) {
        my $diff = abs( $c - $cand );
        $fuel += $diff * ( $diff + 1 ) / 2;
    }
    $res = !$res ? $fuel : $fuel < $res ? $fuel : $res;
}

say $res;

