use 5.030;
use strict;
use warnings;

my $sum;
while ( my @rucksack = split(//,<>) ) {
    pop(@rucksack);
    my %seen = map { $_ => 1} splice(@rucksack, 0, @rucksack/2);
    for my $item (@rucksack) {
        if ($seen{$item}) {
            $sum += ord($item) - ( $item =~ /[a-z]/ ? 96 : 38);
            last;
        }
    }
}
say $sum;
