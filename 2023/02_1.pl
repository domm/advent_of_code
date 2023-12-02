use 5.030;
use strict;
use warnings;

my $sum;
while ( my $line = <> ) {
    next if $line =~ /1[3456789] red/;
    next if $line =~ /1[456789] green/;
    next if $line =~ /1[56789] blue/;

    $line =~/Game (\d+):/;
    $sum+=$1;
}
say $sum;
