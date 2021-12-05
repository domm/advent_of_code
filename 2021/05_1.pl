use 5.030;
use strict;
use warnings;

my @map;
my $max=0;
for (<>) {
    my ($x1,$y1,$x2,$y2) = $_ =~ /(\d+),(\d+) -> (\d+),(\d+)/;
    ($x1,$x2) = sort ($x1,$x2);
    ($y1,$y2) = sort ($y1,$y2);

    if ($x1 == $x2) {
        #say "X $x1,$y1,$x2,$y2";
        for my $ty ($y1 .. $y2) {
            $map[$ty][$x1]++;
            $max++ if $map[$ty][$x1]>1;
        }
    }
    if ($y1 == $y2) {
        #say "Y $x1,$y1,$x2,$y2";
        for my $tx ($x1 .. $x2) {
            #say "$tx .. $y1";
            $map[$y1][$tx]++;
            $max++ if $map[$y1][$tx]>1;
        }
    }
}

draw() if @map < 100;

my %hits;
for my $r (@map) {
    for my $c (@$r) {
        next unless $c;
        $hits{$c}++
    }
}

say $max;

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%hits;




sub draw {
    for my $r (@map) {
        for my $c (@$r) {
            print $c || '.';
        }
        print "\n";
    }
    print "\n";
}

