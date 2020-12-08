use strict;
use warnings;
use 5.030;

my @code = map {[split(/ /)]} <>;
my %seen;
my $i   = 0;
my $acc = 0;
while (1) {
    my ( $op, $val ) = $code[$i]->@*;
    last if $seen{$i}++;

    if ( $op eq 'jmp' ) { $i   += $val; next }
    if ( $op eq 'acc' ) { $acc += $val }
    $i++;
}
say $acc;
