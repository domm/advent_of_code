use strict;
use warnings;
use 5.030;

my @in  = map { [/^(\w)(\d+)$/] } <>;
my @dir = qw(N E S W);
my $cur = 1;
my $r   = 0;
my $c   = 0;
my %ops;
%ops = (
    N => sub { $r -= shift },
    S => sub { $r += shift },
    E => sub { $c += shift },
    W => sub { $c -= shift },
    F => sub { $ops{ $dir[$cur] }(shift) },
    L => sub { $cur = ( $cur - $_[0] / 90 ) % 4 },
    R => sub { $cur = ( $cur + $_[0] / 90 ) % 4 },
);

for (@in) {
    my ( $op, $val ) = @$_;
    $ops{$op}($val);
}
say abs( 0 - $r ) + abs( 0 - $c );
