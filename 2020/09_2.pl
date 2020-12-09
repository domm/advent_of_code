use strict;
use warnings;
use 5.030;

use List::Util qw (min max);

my $preamble=shift;
my @in=map {chomp;$_} <>;

my $target = find_target(@in);
say $target;

for (my $i=0;$i<@in;$i++) {
    my @try = @in;
    my @cand;
    #    while ($check <= $target) {
    while (@cand < @try) {
        push(@cand,shift(@try));
        my $sum = 0;
        map { $sum+=$_} @cand;

        if ($sum == $target) {
            my $min = min(@cand);
            my $max = max(@cand);
            say "$min + $max = ".($min+$max);
            exit;
        }
        last if $sum > $target;
    }
    shift(@in);
}


sub find_target {
    my (@find) = @_;
    while (1) {
        if (check(@find)) {
            shift @find;
        }
        else {
            say "found ".$find[$preamble ];
            return $find[$preamble];
        }
    }
}

sub check {
    my @data = @_;
    my %pre = map {$_,1} splice(@data, 0, $preamble);

    my $target = $data[0];
    for my $a (keys %pre) {
        if ($pre{$target - $a}) {
            return 1;
        }
    }
    return 0
}

