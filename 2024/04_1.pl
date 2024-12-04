#!/usr/bin/perl
use v5.40;

my @w = map { chomp; [ split// ]  } <>;

my @dir = (
    [-1,-1],[-1,0],[-1,1],
    [0,-1],        [0,1],
    [1,-1], [1,0], [1,1]);

my $mc = $w[0]->@* -1;
my $mr = @w -1;
my $hit;
for my $r (0 .. $mr) {
    for my $c (0 .. $mc) {
        my $l = $w[$r]->[$c];
        next unless $l eq 'X';
        DIR: for my $d (@dir) {
            my $cr = $r;
            my $cc = $c;
            for my $ok (qw(M A S)) {
                $cr += $d->[0];
                $cc += $d->[1];
                next DIR if $cr < 0 || $cc < 0 || $cr > $mr || $cc > $mc;
                my $cl = $w[$cr]->[$cc];
                next DIR unless $cl eq $ok;
            }
            $hit++
        }
    }
}
say $hit;

