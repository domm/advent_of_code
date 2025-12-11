#!/usr/bin/env perl

use v5.40;

my %graph;
while (my $l = <>) {
    chomp($l);
    my ($this, $children) = split(/: /, $l);
    my @children=split(/ /,$children);

    $graph{$this}= \@children;
}

my $path='';

# there is no route from dac to fft!
say walk('svr','fft', $path)
  * walk('fft','dac', $path)
  * walk('dac','out', $path);

sub walk($node, $target, $path, $mem = {}) {
    if ($node eq $target) {
        return 1;
    }
    elsif (defined $mem->{$node}) {
        return $mem->{$node};
    }
    $path.=$node.',';
    for my $child ($graph{$node}->@*) {
        $mem->{$node} += walk($child, $target, $path, $mem);
    }
    return $mem->{$node} // 0;
}

