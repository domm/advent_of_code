use 5.020;
use strict;
use warnings;

my @blocks = split(/\n\n/,join('',<>));

my %valid;
for my $rule (split(/\n/,$blocks[0])) {
    my @vals = $rule=~/(\d+-\d+)/g;
    for my $v (@vals) {
        my ($f, $t) = split(/-/,$v);
        for ($f .. $t) {
            $valid{$_}++;
        }
    }
}

my @nearby = split(/\n/,$blocks[2]);
shift(@nearby);

my $invalid=0;
for my $line (@nearby) {
    my @vals = split(/,/,$line);

    for my $c (@vals) {
        $invalid+=$c unless $valid{$c};
    }
}

say $invalid;

