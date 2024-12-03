#!/usr/bin/perl
use v5.40;

my $in = join('',<>);

my $result;
while ( $in =~s/mul\((\d+),(\d+)\)/done/) {
    $result += $1 * $2;
}

say $result;

