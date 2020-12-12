use strict;
use warnings;
use 5.030;
no strict 'refs';

my @in = map { [/^(\w)(\d+)$/] }  <>;
my @dir=qw(N E S W);
my $cur = 1;
my $r=0;
my $c=0;

for (@in) {
    my ($op, $val) = @$_;
    $op->($val);
}
say abs(0-$r) + abs(0-$c);

sub N { $r -= shift }
sub S { $r += shift }
sub E { $c += shift }
sub W { $c -= shift }
sub F { $dir[$cur]->( shift ) }
sub L { $cur = ($cur - $_[0] / 90) % 4 }
sub R { $cur = ($cur + $_[0] / 90) % 4 }
