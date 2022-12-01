use 5.030;
use strict;
use warnings;

my $max = 0;
my $cur = 0;
my @elves;
while ( my $cal = <> ) {
    chomp($cal);
    if ($cal=~/\d/) {
        $cur+=$cal;
    }
    else {
        push(@elves,$cur);
        $cur=0;
    }

}
my @sort = sort {$b <=> $a} @elves;
say $sort[0] + $sort[1] + $sort[2];
