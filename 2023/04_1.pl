use 5.030;
use strict;
use warnings;

my $total;
while (<>) {
    m/: ([\d ]+) \| ([\d ]+)/;
    my %win = map { $_=>1 } split(/\s+/,$1);
    my $points = 0;
    for (split(/\s+/,$2)) {
        if ($win{$_}) {
            if ($points == 0) {
                $points = 1;
            }
            else {
                $points *= 2;
            }
        }
    }
    $total+=$points;
}

say $total;
