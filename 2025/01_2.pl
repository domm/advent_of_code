#!/usr/env perl

use v5.40;

my $pos = 50;
my $code = 0;

for my $move (<>) {
    my ($op, $for) = $move=~/^(.)(\d+)/;
    for (0 .. ($for - 1)) {
        $pos = $op eq 'R' ? $pos + 1 : $pos -1;
        if ($pos % 100 == 0) {
            $code++;
            $pos = $op eq 'R' ? 0 : 100;
        }
    }
}
say $code;

