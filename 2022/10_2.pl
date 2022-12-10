use v5.36;
use strict;
use warnings;

my $x = 1;
my $c = 0;
my %after;
while (my $in = <>) {
    between();
    if ($in=~/(-?\d+)/) {
        $after{$c+1}=$1;
        between();
    }
}

sub between {
    if (my $val = $after{$c}) {
        $x+=$val;
    }
    $c++;
    draw();
}

sub draw {
    my $p = $c % 40;
    if ($p >= $x && $p <= $x+2) {
        print '█';
    }
    else {
        print " ";
    }
    print "\n" if $p == 0;
}
