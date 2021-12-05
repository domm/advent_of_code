use 5.030;
use strict;
use warnings;

my @map;
for (<>) {
    my ($x1,$y1,$x2,$y2) = $_ =~ /(\d+),(\d+) -> (\d+),(\d+)/;
    ($x1,$x2) = sort { $a <=> $b } ($x1,$x2);
    ($y1,$y2) = sort { $a <=> $b } ($y1,$y2);

    if ($x1 == $x2) {
        for my $ty ($y1 .. $y2) {
            $map[$ty][$x1]++;
        }
    }
    if ($y1 == $y2) {
        for my $tx ($x1 .. $x2) {
            $map[$y1][$tx]++;
        }
    }
}

my $hits=0;
for my $r (@map) {
    for my $c (@$r) {
        $hits++ if $c && $c > 1;
    }
}

say $hits

