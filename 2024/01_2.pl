#!/usr/bin/perl
use v5.40;

my (@l, %r);
while ( my $line = <> ) {
    my ($l,$r) = grep { /\d/ } split(/\s+/ ,$line);
    push(@l, $l);
    $r{$r}++;
}

@l = sort @l;
my $score=0;
for my $l (@l) {
    $score += ($l * $r{$l});
}
say $score;
