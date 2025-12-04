#!/usr/env perl

use v5.40;

my $r=1;
my %map;
for my $l (<>) {
    chomp $l;
    my $c=1;
    for my $p (split(//, $l)) {
        $map{$r}{$c++}=$p;
    }
    $r++;
}
my $max = $r - 1;
my $access;
for my $r (1 .. $max) {
    for my $c (1 .. $max) {
        next unless $map{$r}{$c} eq '@';
        my $blocked=0;
        #say "at $r/$c: ".$map{$r}{$c};
        for my $look ([-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]) {
            my $content = $map{$r + $look->[0]}{ $c+$look->[1] } || '.';
            $blocked++ if $content eq '@';
            #   say "\t look at ".($r + $look->[0]).'/'.($c+$look->[1]).": $content";
        }
        $access++ if $blocked < 4;
    }
}
say $access;

