#!/usr/bin/perl
use v5.40;

my $in = join('',<>);
$in =~s/\n//g;
$in =~s/don't\(\)(.*?)do\(\)//g;
$in =~s/don't\(\).*$//;
my $result;
while ( $in =~s/mul\((\d+),(\d+)\)/done/) {
    $result += $1 * $2;
}

say $result;

