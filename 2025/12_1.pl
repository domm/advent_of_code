#!/usr/bin/env perl

use v5.40;

my @presents;
my $current;
my $in_presents = 1;
my @trees;
my $fits=0;
while (my $l = <>) {
    chomp $l;
    if ($l=~/^(\d)+:/) {
        $current = $1;
    }
    elsif ($l=~/(\d+)x(\d+): (.*)$/) {
        $in_presents = 0;
        my $x=$1;
        my $y=$2;
        my $needed=0;
        for my $n (split(/\s+/,$3)) {
            $needed+=$n;
        }
        my $space_needed = $needed * 9;
        if ($x * $y >= $space_needed) {
            $fits++;
        }

    }
    elsif ($in_presents) {
        $presents[$current]+=length($l);
    }
}

say $fits;

