use 5.026;
use strict;
use warnings;

my $id = shift @ARGV;
my @grid;

my $max=0;
my $maxpos='';
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
        #say $h;
        my $total = 0;
        foreach my $x1 (0 .. 2) {
            next if $x - $x1 < 1;
            foreach my $y1 (0 .. 2) {
                next if $y - $y1 < 1;
                $total += $grid[$x - $x1][$y - $y1];
            }
        };
        if ($total > $max) {
            $max = $total;
            $maxpos=($x -2) ." x ". ($y - 2);
        }
    }
    #exit;
}
say "$maxpos: $max";
