use v5.36;
use strict;
use warnings;

my @grid = map {chomp; [ split//  ]} <>;
my %visible;

my $sum = 0;
for my $r (0 .. $#grid) {
    visible_c($r);
    visible_cr($r);
    visible_r($r);
    visible_rr($r);
}
say scalar keys %visible;

sub visible_c($r){
    my $max=-1;
    for my $c (0 .. $#grid) {
        my $tree = $grid[$r][$c];
        if ($tree > $max) {
            $visible{$r.':'.$c}++;
            $max = $tree;
        }
    }
}
sub visible_cr($r){
    my $max=-1;
    for my $rc (0 .. $#grid ) {
        my $c = $#grid - $rc;
        my $tree = $grid[$r][$c];
        if ($tree > $max) {
            $visible{$r.':'.$c}++;
            $max = $tree;
        }
    }
}
sub visible_r($c){
    my $max=-1;
    for my $r (0 ..  $#grid) {
        my $tree = $grid[$r][$c];
        if ($tree > $max) {
            $visible{$r.':'.$c}++;
            $max = $tree;
        }
    }
}
sub visible_rr($c){
    my $max=-1;;
    for my $rr (0 .. $#grid ) {
        my $r = $#grid - $rr;
        my $tree = $grid[$r][$c];
        if ($tree > $max) {
            $visible{$r.':'.$c}++;
            $max = $tree;
        }
    }
}

