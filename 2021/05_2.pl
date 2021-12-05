use 5.030;
use strict;
use warnings;

my @map;
for (<>) {
    my ($c1,$r1,$c2,$r2) = $_ =~ /(\d+),(\d+) -> (\d+),(\d+)/;
    my ($cs1,$cs2) = sort { $a <=> $b } ($c1,$c2);
    my ($rs1,$rs2)  = sort { $a <=> $b } ($r1,$r2);

    if ($r1 == $r2) {
        for my $lr (0 .. abs($c1 - $c2)) {
            $map[$r1][$cs1 + $lr]++;
        }
    }
    elsif ($c1 == $c2) {
        for my $ud (0 .. abs ($r1 - $r2)) {
            $map[ $rs1 + $ud ][$c1]++;
        }
    }
    else {
        my $dirr = $r2 <=> $r1;
        my $dirc = $c2 <=> $c1;
        for my $d (0 .. abs ($r1 - $r2)) {
            $map[ $r1 + ( $d * $dirr) ][ $c1 + ( $d * $dirc) ]++;
        }
    }
}

my $hits=0;
for my $r (@map) {
    for my $c (@$r) {
        $hits++ if $c && $c > 1;
    }
}

say $hits;

