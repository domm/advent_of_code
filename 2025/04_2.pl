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
my $total_removed=0;

my $i=0;
while (1) {
    my %new;
    my $removed=0;
    for my $r (1 .. $max) {
        for my $c (1 .. $max) {
            $new{$r}{$c} = $map{$r}{$c};
            next unless $map{$r}{$c} eq '@';

            my $blocked=0;
            #say "at $r/$c: ".$map{$r}{$c};
            for my $look ([-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]) {
                my $content = $map{$r + $look->[0]}{ $c+$look->[1] } || '.';
                $blocked++ if $content eq '@';
                #   say "\t look at ".($r + $look->[0]).'/'.($c+$look->[1]).": $content";
            }
            if ($blocked < 4) {
                $removed++;
                $new{$r}{$c}='.';
            }
        }
    }
    $total_removed+=$removed;
    say $i++.": $removed - $total_removed";
    last if ($removed == 0);
    %map = %new;
}

