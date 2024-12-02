#!/usr/bin/perl
use v5.40;

my (@l, @r);
while ( my $line = <> ) {
    my ($l,$r) = grep { /\d/ } split(/\s+/ ,$line);
    push(@l, $l);
    push(@r, $r);
}

@l = sort @l;
@r = sort @r;

my $i = 0;
my $total = 0;
for (my $i=0;$i<@l;$i++) {
    my $diff = abs($r[$i] - $l[$i]);
    $total += $diff;
    #say join(' => ',$l[$i],$r[$i], $diff);
}

say $total;
