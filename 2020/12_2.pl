use strict;
use warnings;
use 5.030;

my $wr = -1;
my $wc = 10;
my $sr = 0;
my $sc = 0;
my %ops;
%ops = (
    N => sub { $wr -= shift },
    S => sub { $wr += shift },
    E => sub { $wc += shift },
    W => sub { $wc -= shift },
    F => sub { my $val = shift; $sr += $val * $wr; $sc += $val * $wc },
    R => sub { for ( 1 .. $_[0] / 90 ) { ( $wr, $wc ) = ( $wc, $wr ); $wc *= -1 } },
    L => sub { for ( 1 .. $_[0] / 90 ) { ( $wr, $wc ) = ( $wc, $wr ); $wr *= -1 } },
);

for ( map { [/^(\w)(\d+)$/] } <> ) {
    my ( $op, $val ) = @$_;
    $ops{$op}($val);
}
say abs( 0 - $sr ) + abs( 0 - $sc );
