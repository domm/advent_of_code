use 5.030;
use strict;
use warnings;

my $depth = 0;
my $inc   = -1;
while ( my $reading = <> ) {
    if ( $reading > $depth ) {
        $inc++;
    }
    $depth = $reading;
}
say $inc;
