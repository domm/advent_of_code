use 5.020;
use strict;
use warnings;

my @exp = ( <STDIN> );
while (my $a = shift (@exp)) {
    for my $b (@exp) {
        for my $c (@exp) {
            if ($a + $b +$c == 2020) {
                say $a*$b*$c;
                exit;
            }
        }
    }
}
