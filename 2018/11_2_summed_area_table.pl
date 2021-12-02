use 5.026;
use strict;
#use warnings;
use List::Util qw(sum);

# https://en.wikipedia.org/wiki/Summed-area_table

my $id = shift @ARGV;
my ($a, $b, $c) = @ARGV;
my @sumgrid;
foreach my $x (1 .. 300) {
    foreach my $y (1 .. 300) {
        $sumgrid[$x][$y] = sum(power($x-1, $y), map { power($x, $_) } 1 .. $y);
    }
}
my $max;
my $maxpos;
my $total;
foreach my $x (1 .. 300) {
    foreach my $y (1 .. 300) {
        #my $square = 300 - ($x > $y ? $x : $y);
        #say "check $x $y -> $square";
        my $s = 2;
        next if $x-$s < 1 || $y-$s < 1;
        my $total = $sumgrid[$x][$y] + $sumgrid[$x-$s][$y-$s] - $sumgrid[$x][$y-$s] - $sumgrid[$x-$s][$y];
        if ($total > $max) {
            $max = $total;
            $maxpos=join(',',$x,$y,$s);
        }
    }
}


say "$maxpos: $max";

sub power {
    my ($x, $y) = @_;
    return 0 if $x<1 || $y<1;
    my $rackid = $x + 10;
    my $level = $rackid * $y;
    $level += $id;
    $level = $level * $rackid;
    my ($power) = $level =~ /(\d)\d\d$/;
    $power-=5;
    return $power;
}

