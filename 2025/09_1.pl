#!/usr/bin/env perl

use v5.40;
use Algorithm::Combinatorics qw(combinations);

my @coords = map { chomp; my @c = split(/,/,$_); { id=>$_, r=>$c[0], c=>$c[1] } } <>;

my $iter = combinations(\@coords, 2);
my $biggest=0;
while (my $p = $iter->next) {
    my $area = area(@$p);
    if ($area>$biggest) {
        $biggest = $area;
    }
}
say $biggest;

sub area($p, $q) {
    return abs($p->{r} - $q->{r} + 1) * abs($p->{c} - $q->{c} + 1);
}

