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
    my $p = ($c % 40 )-1;
    if ($p >= $x-1 && $p <= $x+1) {
        print '█';
    }
    else {
        print " ";
    }
    if ($c % 40==0) {
       print "\n";
   }
}
