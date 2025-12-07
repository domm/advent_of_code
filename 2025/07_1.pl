#!/usr/env perl

use v5.40;

my @map = map {chomp; [split(//)] } <>;

my $split;
for my ($r, $row) (indexed @map) {
    for my ($c, $f) (indexed @$row) {
        if ($f eq 'S') {
            $map[$r+1][$c] = '|';
        }
        elsif ($f eq '^' && $map[$r-1][$c] eq '|') {
            if ($row->[$c-1] eq '.') {
                $row->[$c-1] = '|';
                $map[$r+1][$c-1] = '|' if $map[$r+1][$c-1] eq '.';
            }
            if ($row->[$c+1] eq '.') {
                $row->[$c+1] = '|';
                $map[$r+1][$c+1] = '|' if $map[$r+1][$c+1] eq '.';

            }
            $split++;
        }
        elsif ($f eq '|') {
            $map[$r+1][$c] = '|' if $map[$r+1][$c] eq '.';
        }
    }
    last if $r == @map -1;
}

say "splits $split";

# show the map for debugging
sub show {
    my @m = @_;
    for my $r (@m) {
        for my $c (@$r) {
            print $c;
        }
        print "\n";
    }
}

