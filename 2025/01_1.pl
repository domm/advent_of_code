#!/usr/env perl

use v5.40;

my $in = join('',<>);
$in=~tr/LR/-+/;

my $pos = 50;
my $code = 0;
for (split/\n/, $in) {
    $pos+=$_;
    $pos=$pos % 100;
    $code ++ if $pos == 0;
}

say $code;
