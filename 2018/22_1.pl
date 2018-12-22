use strict;
use warnings;
use 5.028;

my ($depth, $tx, $ty) = @ARGV;
my @types=qw(rocky wet narrow);
my @tile=qw(. = |);
my @map;
my $risk=0;
for my $y (0 .. $ty) {
    for my $x (0 .. $tx) {
        my $gi;
        if (($x == $tx && $y == $ty) || ($x==0&&$y==0)) {
            $gi = 0;
        }
        elsif ($x == 0) {
            $gi = $y * 48271;
        }
        elsif ($y == 0) {
            $gi = $x * 16807;
        }
        else {
            $gi = $map[$x-1][$y]{erosion} * $map[$x][$y-1]{erosion};
        }
        my $d ={
            geo => $gi,
            erosion => ($gi + $depth) % 20183,
        };
        my $type = $d->{erosion} % 3;
        $d->{type} = $types[$type];
        $d->{tile} = $tile[$type];
        $map[$x][$y] = $d;
        #        print $d->{tile};
        $risk+=$type;
        #use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $d;

    }
    print "\n";
}

say $risk;

