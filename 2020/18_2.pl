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
    my $t = shift;
    while ($t =~/\+/) {
        $t =~s/(\d+) \+ (\d+)/$1 + $2/eg;
    }
    return eval $t;
}

