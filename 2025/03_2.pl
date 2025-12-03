#!/usr/env perl

use v5.40;

my $joltage=0;

my $needed = 12;

for my $bank (<>) {
    chomp($bank);
    my @bat = split(//,$bank);
    my $size = length($bank);
    my $use;
    my $skip = -1;
    for my $slot (1 .. $needed) {
        my ($hit, $max) = (0,0);
        my $cut = $size - ($needed - $slot) -1;
        for (my $i = 0;$i<@bat;$i++) {
            my $b = $bat[$i];
            next if $i < $skip;
            last if $i > $cut;
            if ($b > $max) {
                $hit = $i;
                $max = $b;
            }
        }
        $use .= $bat[$hit];
        $skip = $hit+1;
    }
    $joltage += $use;
}
say $joltage;
