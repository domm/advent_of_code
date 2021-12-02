use 5.026;
use strict;
use warnings;

my $id = shift @ARGV;
my ($a, $b, $c) = @ARGV;
my @grid;

foreach my $x (1 .. 300) {
    foreach my $y (1 .. 300) {
        my $rackid = $x + 10;
        my $level = $rackid * $y;
        $level += $id;
        $level = $level * $rackid;
        my ($h) = $level =~ /(\d)\d\d$/;
        $h //= 0;
        $h-=5;
        $grid[$x][$y] = $h;
    }
}
say "done with grid";

my $max=0;
my $maxpos='';
foreach my $x (1 .. 300) {
    foreach my $y (1 .. 300) {
        my $square = 300 - ($x > $y ? $x : $y);
        say "check $x $y -> $square";
        foreach my $s ( 1 .. $square) {
            my $total=0;
            foreach my $x1 ( $x  .. $x+$s ) {
                foreach my $y1 ( $y  .. $y+$s) {
                    $total += $grid[$x1][$y1];
                }
            }
            if ($total > $max) {
                $max = $total;
                $maxpos=join(',',$x,$y,$s+1);
            }
        }
    }
}

say "$maxpos: $max";

