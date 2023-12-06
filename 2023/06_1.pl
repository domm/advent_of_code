use 5.034;
use strict;
use warnings;

my @race = map { [$_] } split(/\s+/, <>);
my @distances = split(/\s+/, <>);
for (my $i=1;$i<@race;$i++) {
    $race[$i][1] = $distances[$i] + 1;
}
shift(@race);

my $prod = 1;
for my $r (@race) {
    my ($s1, $s2) = pq(@$r);
    my $from = int($s1);
    $from++ if ($from != $s1); # correct for intersection at int
    my $to = int($s2);

    $prod *= (int($to) - int($from) + 1 );
}
say $prod;

sub pq {
    my ($p, $q) = @_;

    my $s1 = $p/2 + sqrt( (($p/2) * ($p/2)) - $q);
    my $s2 = $p/2 - sqrt( (($p/2) * ($p/2)) - $q);

    return (sort { $a <=> $b} $s1, $s2);
}

