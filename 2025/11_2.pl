#!/usr/bin/env perl

use v5.40;

my %graph;
while (my $l = <>) {
    chomp($l);
    my ($this, $children) = split(/: /, $l);
    my @children=split(/ /,$children);

    $graph{$this}= \@children;
}

my $paths=0;
my $path;
walk('svr', $path);

say $paths;

sub walk($node, $path) {
    $path.="$node,";
    if ($node eq 'out') {
        $paths++ if $path =~ /fft/ && $path =~ /dac/;
    }
    else {
        for my $child ($graph{$node}->@*) {
            walk($child, $path);
        }
    }
}

