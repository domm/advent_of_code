#!/usr/bin/env perl

use v5.40;

my %graph;
while (my $l = <>) {
    chomp($l);
    my ($this, $children) = split(/: /, $l);
    my @children=split(/ /,$children);

    $graph{$this}= \@children;
}

my $paths = 0;
walk('you');

say $paths;

sub walk($node) {
    if ($node eq 'out') {
        $paths++;
    }
    else {
        for my $child ($graph{$node}->@*) {
            walk($child);
        }
    }
}

