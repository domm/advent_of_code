use 5.030;
use strict;
use warnings;

my $sum;
while ( my $line = <> ) {
    my @digits = grep { /\d/ } split(// ,$line);
    $sum += $digits[0].$digits[-1];
}
say $sum;
