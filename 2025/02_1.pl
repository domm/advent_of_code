#!/usr/env perl

use v5.40;

my $sum=0;

for my $range (split(/,/,<>)) {
    my ($from, $to) = split(/-/,$range);
    for my $id ($from .. $to) {
        my $l = length($id);
        next if $l % 2 == 1;
        my $hl = $l/2;
        if (substr($id,0,$hl) eq substr($id,$hl,$hl)) {
            $sum+=$id;
        }
    }
}
say $sum;
