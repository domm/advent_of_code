use strict;
use warnings;
use 5.030;

my $size = shift;
my @in   = map { chomp; $_ } <>;

while (1) {
    check() ? shift @in : last;
}
say $in[$size];

sub check {
    my %lu     = map { $_, 1 } @in[ 0 .. $size - 1 ];
    my $target = $in[$size];
    for my $a ( keys %lu ) {
        if ( $lu{ $in[$size]  - $a } ) {
            return 1;
        }
    }
    return;
}
