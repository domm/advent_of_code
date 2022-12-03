use 5.030;
use strict;
use warnings;

my $sum;
my %seen;
my $cnt=0;
while ( my @rucksack = split(//,<>) ) {
    pop(@rucksack);
    $cnt++;
    for my $item (@rucksack) {
        $seen{$item}->{$cnt} = 1;
    }

    if ($cnt == 3) {
        while (my ($item, $counts) = each %seen) {
            if (keys %$counts == 3) {
                $sum += ord($item) - ( $item =~ /[a-z]/ ? 96 : 38);
            }
        }
        $cnt = 0;
        %seen = ();
    }
}
say $sum;
