use v5.36;
use List::MoreUtils qw(lower_bound upper_bound);

my $y = 2000000;
my %map;
my @x;
my @sensors;

while (<>) {
    my ($sx, $sy, $bx, $by) = /=(-?\d+).*=(-?\d+).*=(-?\d+).*=(-?\d+)/;
    my $d = abs($sx - $bx) + abs($sy - $by);
    $map{$by}{$bx}='B';
    push(@x,$sx - $d, $sx + $d);
    push(@sensors,[$sx,$sy, $d]);
}

@x = sort { $a<=>$b } @x;
say $x[0].' ' .$x[-1];
my $inside;
for my $x ($x[0] -5  .. $x[-1] + 5) {
    say $x if $x % 250_000 == 0;
    for my $s (@sensors) {
        if (abs($x - $s->[0]) + abs($y - $s->[1]) <= $s->[2]) {
            $inside++;
            last;
        }
    }
}
my $b = scalar values $map{$y}->%*;
say $inside - $b;
