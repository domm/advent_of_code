use v5.36;
use strict;
use warnings;

my $x = 1;
my $c = 0;
my %after;
my $sum;
while (my $in = <>) {
    between();
    if ($in=~/(-?\d+)/) {
        $after{$c+1}=$1;
        between();
    }
}

say $sum;

sub between {
    if (my $val = $after{$c}) {
        $x+=$val;
    }
    $c++;
    check();
}

sub check {
    if ($c % 40==20) {
        my $signal = $c * $x;
        say "in $c  \t SIG $signal";
        $sum+=$signal
    }
}

