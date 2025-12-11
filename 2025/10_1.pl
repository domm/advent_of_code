#!/usr/bin/env perl

use v5.40;

use Algorithm::Combinatorics qw(combinations);

my $total;
for (<>) {

    # very convoluted way to convert the input into ints
    my ($target, $buttons, $joltage) = $_ =~ /^\[(.*?)\] (.*) \{(.*)\}/;
    $target=~tr/.#/01/;
    my $tb = oct("0b".$target);
    my $max = oct("0b". ('1' x length($target)));
    my $start=('0' x length($target));

    my @bb;
    for my $bdef (split(/ /, $buttons)) {
        $bdef=~s/[()]//g;
        my $b=$start;
        for my $pos ( split(/,/, $bdef)) {
            substr($b, $pos, 1, 1);
        }
        push(@bb, oct("0b".$b));
    }

    # try larger combinations until we find one that matches
    my $tries;
    TRY: for my $k (1 .. @bb) {
        my $iter = combinations(\@bb, $k);
        while (my $btns = $iter->next) {
            my $l = $start;
            for my $btn (@$btns) {
                $l = $l ^ $btn; # xor the ints = add the bitmasks
                if ($l == $tb) {
                    $tries = $k;
                    last TRY;
                }
            }
        }
    }
    $total+=$tries;
}
say "total $total";

