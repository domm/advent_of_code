use strict;
use warnings;
use 5.030;
no strict 'refs';

my $ts = <>;
my @buses = grep { /[\d+]/ } split(',',<>);

my $choose='x';
my $depart=10000000;
foreach my $bus (@buses) {
    my $check = $bus * (int($ts/$bus) + 1);
    if ($check < $depart) {
        $depart = $check;
        $choose = $bus;
    }
}

say "$choose at $depart: ".(($depart-$ts) * $choose);

