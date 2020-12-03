use 5.030;
use strict;
use warnings;

my @exp = ( <STDIN> );
while (my $a = shift (@exp)) {
    for my $b (@exp) {
        if ($a + $b == 2020) {
            die $a*$b."\n";
        }
    }
}
