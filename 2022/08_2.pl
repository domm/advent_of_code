use v5.36;
use strict;
use warnings;

my @grid = map {chomp; [ split//  ]} <>;
my $max=0;
for my $r ( 0 .. $#grid) { 
    for my $c ( 0 .. $#grid) {
        my $tree = $grid[$r][$c];
        my $scenic = 1;
        for my $dir ([-1,0],[0,1],[1,0],[0,-1]) {
            my $dist  =0;
            my $lr = $r;
            my $lc = $c;
            while (1) {
                $lr += $dir->[0];
                $lc += $dir->[1];
                last if ($lr < 0 || $lc < 0 || $lr > $#grid || $lc > $#grid);
                my $look = $grid[$lr][$lc];
                $dist++;
                last if $look >= $tree;
            }
            $scenic *= $dist;
        }
        $max = $scenic if $scenic > $max;
    }
}
say $max;
