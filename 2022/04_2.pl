use 5.030;
use strict;
use warnings;

my $sum=0;
PAIR: while (<>) {
    my ($first_start, $first_stop, $second_start, $second_stop) = /(\d+)-(\d+),(\d+)-(\d+)/;
    my %seen;
    for my $i ($first_start .. $first_stop, $second_start .. $second_stop) {
        if ($seen{$i}++) {
            $sum++;
            next PAIR;
        }
    }
}
say $sum;
