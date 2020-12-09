use strict;
use warnings;
use 5.030;

use List::Util qw (min max sum);

my $size = shift;
my @in   = map { chomp; $_ } <>;
my @in2  = @in;

while (1) {
    check() ? shift @in : last;
}
my $target = $in[$size];

while (1) {
    my @try = @in2;
    my @cand;

    while (1) {
        push( @cand, shift @try );
        my $sum = sum(@cand);

        if ( $sum == $target ) {
            say min(@cand) + max(@cand);
            exit;
        }
        last if $sum > $target;
    }
    shift(@in2);
}

sub check {
    my %lu     = map { $_, 1 } @in[ 0 .. $size - 1 ];
    my $target = $in[$size];
    for my $a ( keys %lu ) {
        if ( $lu{ $target - $a } ) {
            return 1;
        }
    }
    return;
}

