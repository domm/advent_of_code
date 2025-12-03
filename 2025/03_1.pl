#!/usr/env perl

use v5.40;

my $joltage=0;

for my $bank (<>) {
    chomp($bank);
    my @bat = split(//,$bank);
    my ($zehner, $einer, $zmax, $emax)=(0,0,0,0);

    while (my ($i, $b) = each @bat) {
        last if $i == $#bat;
        if ($b > $zmax) {
            $zehner = $i;
            $zmax = $b;
        }
    }

    for my $i ($zehner+1 .. $#bat) {
        my $b = $bat[$i];
        if ($b > $emax) {
            $einer = $i;
            $emax = $b;
        }
    }

    $joltage += $bat[$zehner].$bat[$einer];
}
say $joltage;
