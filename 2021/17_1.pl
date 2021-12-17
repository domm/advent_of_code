use 5.030;
use strict;
use warnings;
use List::Util qw(sum);

my $in = join(' ',@ARGV);
my ($xfrom, $xto, $yto, $yfrom) = $in =~ /x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/;

my $min_v = find_x($xfrom) - 1;
my $max_v = find_x($xto);

my $highest=0;
for my $y ($yto .. $yfrom * -2) {
    for my $x ($min_v .. $max_v) {
        if (my $hit = shoot($x, $y)) {
            $highest = $hit if $hit > $highest;
        }
    }
}
say $highest;

sub shoot {
    my ($vx, $vy) = @_;
    my $stop = $yto;
    my ($y,$x)=(0,0);
    my $maxy=0;
    while ($y > $yto) {
        $x+=$vx;
        $y+=$vy;
        $maxy = $y if $y > $maxy;
        $vx-- unless $vx<=0;
        $vy--;
        if ($x >= $xfrom && $x <= $xto && $y <= $yfrom && $y >= $yto) {
            return $maxy;
        }
    }
}

sub find_x {
    my $target = shift;
    for my $v (1 .. $target) {
        my $max = $v * ($v-1) / 2;
        return $v if $max > $target;
    }
}
