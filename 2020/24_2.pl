use 5.020;
use strict;
use warnings;

my %map;
my ($minr, $minc, $maxr, $maxc)=(0,0,0,0);
my %move = (
    e=>[0, 1],
    w=>[0, -1],
    nw=>[-1, 0],
    ne=>[-1, 1],
    sw=>[1, 0],
    se=>[1, 1],
);
for (<>) {
    chomp;
    last unless $_=~/\w/;
    s/([ns][ew])/$1;/g;
    s/([ew])([ns])/$1;$2/g;
    s/([ew])([ew])/$1;$2/g;
    s/([ew])([ew])/$1;$2/g;
    my $r = 0;my $c=0;
    for my $d (split(/;/)) {
        my $m = $move{$d} || die 'arg';
        $r+=$m->[0];
        $c+= $d=~/^.$/ ? $m->[1] : $r % 2 ? $m->[1] : $m->[1] - 1;
    }
    $minr = $r if $r < $minr;
    $minc = $c if $c < $minc;
    $maxr = $r if $r > $maxr;
    $maxc = $c if $c > $maxc;

    my $loc= $r.':'.$c;
    if (!$map{$loc}) {
        $map{$loc} = 'b';
    }
    else {
        $map{$loc} = $map{$loc} eq 'b' ? 'w' : 'b';
    }
}

say "$minr / $minc  - $maxr / $maxc";

for my $day (1 .. 100) {
    my %new;
    for my $loc (keys %map) {
        my ($r, $c) = split(/:/,$loc);
        my $cnt_black = 0;
        for my $d (keys %move) {
            my $m = $move{$d};
            my $lr = $r + $m->[0];
            my $lc = $c + ( $d=~/^.$/ ? $m->[1] : $r % 2 ? $m->[1] -1 : $m->[1] );
            my $look = $lr.':'.$lc;
            $cnt_black++ if $map{$look} && $map{$look} eq 'b';
        }
        my $tile = $map{$loc} || 'w';
        if ($tile eq 'b' && ($cnt_black == 0 || $cnt_black > 2)) {
            $new{$loc} = 'w';
        }
        elsif ($tile eq 'w' && $cnt_black == 2) {
            $new{$loc} = 'b';
        }
        else {
            $new{$loc} = $tile;
        }
    }
    say "day $day: ".count(\%new);
    %map = %new;
}


sub count {
    my $map = shift;
    my $cnt;
    for (values %$map) {
        $cnt++ if $_ eq 'b';
    }
    return $cnt;
}

