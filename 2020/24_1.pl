use 5.020;
use strict;
use warnings;

my %map;

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
    my $loc= $r.'-'.$c;
    if (!$map{$loc}) {
        $map{$loc} = 'b';
    }
    else {
        $map{$loc} = $map{$loc} eq 'b' ? 'w' : 'b';
    }
}

my $cnt;
for (values %map) {
    $cnt++ if $_ eq 'b';
}

say $cnt;

