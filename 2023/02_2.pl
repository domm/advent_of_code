use 5.030;
use strict;
use warnings;

my $sum;
while ( my $line = <> ) {
    chomp($line);
    my ($game, $plays) = split(/: /, $line);
    my %min = ( red=>0, green=>0, blue=>0 );
    for my $play (split(/; /, $plays)) {
        for my $cubes (split(/, /,$play)) {
            my ($num,$col) = split(/ /,$cubes);
            $min{$col} = $num if $num > $min{$col};
        }
    }
    my $power = 1;
    map { $power *= $_ } values %min;
    $sum+=$power;
}
say $sum;
