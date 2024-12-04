#!/usr/bin/perl
use v5.40;

my @w = map { chomp; [ split// ]  } <>;

my @dir = (
    [[0, -1],[0, 1]],
    [[-1,-1],[1,1]],
    [[-1,0],[1,0]],
    [[-1,1],[1,-1]],
);

my $mc = $w[0]->@* -1;
my $mr = @w -1;
my $hit=0;

my @OK;
for my $r (0 .. $mr) {
    LETTER: for my $c (0 .. $mc) {
        my $l = $w[$r]->[$c];
        next unless $l eq 'A';
        my $cnt = 0;
        my $diaghit = 0;
        for my $d (@dir) {
            my $c0r = $r + $d->[0][0];
            my $c0c = $c + $d->[0][1];
            my $c1r = $r + $d->[1][0];
            my $c1c = $c + $d->[1][1];
            next if ($c0r <0 || $c0c < 0 || $c1r <0 || $c1c < 0);
            next if ($c0r > $mr || $c0c > $mc || $c1r > $mr || $c1c > $mr);

            my $c0 = $w[$c0r]->[$c0c];
            my $c1 = $w[$c1r]->[$c1c];

            if (($c0 eq 'M' && $c1 eq 'S') || ($c0 eq 'S' && $c1 eq 'M')) {
                if ($cnt == 1) {
                    if ($diaghit) {
                        $hit++;
                        next LETTER;
                    }
                    $diaghit = 0;
                    $cnt=0;
                }
                else {
                    $diaghit = 1;
                    $cnt = 1;
                }
            }
        }
    }
}
say $hit;

# 2538 -> too high
# 2533 -> too high


# maybe better with regex!
