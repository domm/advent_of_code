#!/usr/bin/env perl

use v5.40;

my $total;
for (<>) {
    my ($target, $buttons, $joltage) = $_ =~ /^\[(.*?)\] (.*) \{(.*)\}/;
    $target=~tr/.#/01/;
    my $tb = oct("0b".$target);
    my $max = oct("0b". ('1' x length($target)));

    my @bb;
    for my $bdef (split(/ /, $buttons)) {
        $bdef=~s/[()]//g;
        my $b=('0' x length($target));
        for my $pos ( split(/,/, $bdef)) {
            substr($b, $pos, 1, 1);
        }
        push(@bb, oct("0b".$b));
    }

    say "try to get from 0 to $tb via a bitcombination of ".join(',',@bb);
}
