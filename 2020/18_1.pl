use 5.020;
use strict;
use warnings;

my $sum;
for(<>) {
    chomp;
    while (/\(([^()]*?)\)/) {
        my $r = solve($1);
        s/\(([^()]*?)\)/$r/;
    }
    $sum += solve($_);
}

say $sum;

sub solve {
    my @t = split(/\s/,shift);
    my $a = shift(@t);
    my ($op,$b);
    for my $p (@t) {
        if ($p=~/\d/) {
            $a =  eval "$a $op $p" ;
        }
        else {
            $op = $p;
        }
    }
    return $a;
}

