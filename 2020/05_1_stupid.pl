use strict;
use warnings;
use 5.030;

my $max=0;
while (<STDIN>) {
    chomp();
    my @s = split //;
    my @r = splice(@s,0,7);

    my @row = (0 .. 127);
    for (my $i=0;$i<=6;$i++) {
        my $range = int(@row/2);
        if ($r[$i] eq 'F') {
            @row = splice(@row,0,$range);
        }
        else {
            @row = splice(@row,$range, $range);
        }
    }
    my $row = $row[0];

    my @seats = (0 .. 7);
    for (my $i=0;$i<=2;$i++) {
        my $range = int(@seats/2);
        if ($s[$i] eq 'L') {
            @seats = splice(@seats,0,$range);
        }
        else {
            @seats = splice(@seats,$range, $range);
        }
    }
    my $seat = $seats[0];
    my $id = $row * 8 + $seat;

    say "$row / $seat -> $id";

    $max=$id if $id > $max;
}

say "MAX $max";
