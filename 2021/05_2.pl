use 5.030;
use strict;
use warnings;

my @map;
for (<>) {
    my ($c1,$r1,$c2,$r2) = $_ =~ /(\d+),(\d+) -> (\d+),(\d+)/;
    my $dir_r = $r2 <=> $r1;
    my $dir_c = $c2 <=> $c1;

    if ($r1 == $r2) {
        for my $d (0 .. abs($c1 - $c2)) {
            $map[$r1][$c1 + ($d * $dir_c)]++;
        }
    }
    elsif ($c1 == $c2) {
        for my $d (0 .. abs ($r1 - $r2)) {
            $map[ $r1 + ($d * $dir_r) ][$c1]++;
        }
    }
    else {
        for my $d (0 .. abs ($r1 - $r2)) {
            $map[ $r1 + ( $d * $dir_r) ][ $c1 + ( $d * $dir_c) ]++;
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

