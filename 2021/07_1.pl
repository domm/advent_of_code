use 5.030;
use strict;
use warnings;

use Statistics::Basic qw(:all);

my @crabs  = split( ',', <> );
my $target = median(@crabs);
my $fuel;
for (@crabs) {
    $fuel += abs( $_ - $target );
}

say $fuel;

