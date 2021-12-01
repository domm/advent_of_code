use 5.030;
use strict;
use warnings;

my @readings = map { chomp; $_ } <>;
my @windows;
for ( my $i = 0; $i < @readings - 2; $i++ ) {
    my $sum = $readings[$i] + $readings[ $i + 1 ] + $readings[ $i + 2 ];
    push( @windows, $sum );
}

my $depth = 0;
my $inc   = -1;
for my $reading (@windows) {
    if ( $reading > $depth ) {
        $inc++;
    }
    $depth = $reading;
}
say $inc;
