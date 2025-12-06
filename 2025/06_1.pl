#!/usr/env perl

use v5.40;

my @in = <>;

my @ops = split(/\s+/, pop(@in));

my $first = shift(@in);
chomp($first);
$first=~s/^\s*//;
my @results = split(/\s+/, $first);

for my $line (@in) {
    chomp($line);
    $line=~s/^\s*//;
    my @num = split(/\s+/, $line);
    for (my $i=0;$i<@num;$i++) {
        if ($ops[$i] eq '+') {
            $results[$i] += $num[$i];
        }
        else {
            $results[$i] *= $num[$i];
        }
    }
}

my $sum;
for (@results) {
    $sum+=$_;
}
say $sum;

