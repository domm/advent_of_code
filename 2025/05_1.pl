#!/usr/env perl

use v5.40;

my @food;
while (my $db = <>) {
    last unless $db=~/-/;
    my ($f, $t) = $db=~/^(\d+)-(\d+)/;
    push(@food, [$f, $t]);
}

my $fresh=0;
ING: while (my $ing = <>) {
    chomp($ing);
    for my $check (@food) {
        if ($ing >= $check->[0] && $ing <= $check->[1]) {
            $fresh++;
            next ING;
        }
    }
}
say $fresh;

