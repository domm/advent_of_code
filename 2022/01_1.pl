use 5.030;
use strict;
use warnings;

my $max = 0;
my $cur = 0;
while ( my $cal = <> ) {
    chomp($cal);
    if ($cal=~/\d/) {
        $cur+=$cal;
    }
    else {
        $max = $cur if $cur > $max;
        $cur=0;
    }

}
say $max;
