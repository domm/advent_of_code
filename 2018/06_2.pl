use 5.010;
use strict;
my @d = <STDIN>;
my $max = 400;
my @map;
my $id='1';
my $des = 10000;
my @points;
foreach (@d) {
    chomp;
    my ($b,$a) = split(/, /);
    push(@points,[$a,$b]);
    $id++;
}

my $save=0;
foreach my $x (0 .. $max) {
    foreach my $y (0..$max) {
        my $distsum=0;
        foreach my $p (@points) {
            $distsum += abs($p->[0] - $x) + abs($p->[1] - $y);
        }
        if ($distsum < $des) {
            $save++;
        }
    }
}
say $save;

