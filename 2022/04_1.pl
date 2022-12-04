use 5.030;
use strict;
use warnings;

my $sum=0;
while (<>) {
    my ($first_start, $first_stop, $second_start, $second_stop) = /(\d+)-(\d+),(\d+)-(\d+)/;
    if (
        ($first_start <= $second_start && $first_stop >= $second_stop) ||
        ($second_start <= $first_start && $second_stop >= $first_stop)) {
        $sum++
    }
}
say $sum;
