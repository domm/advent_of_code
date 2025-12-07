#!/usr/env perl

use v5.40;

my @map = map {chomp; [split(//)] } <>;

my $split;
my @beams;
for my $row (@map) {
    for my ($c, $f) (indexed @$row) {
        if ($f eq 'S') {
            $beams[$c] = 1;
        }
        elsif ($f eq '^' && $beams[$c] > 0) {
            $split++;
            $beams[$c-1] += $beams[$c];
            $beams[$c+1] += $beams[$c];
            $beams[$c]=0;
        }
    }
}

use List::Util qw(sum);
say "splits (part 1) $split";
say "timelines (part 2) ".sum(@beams);

