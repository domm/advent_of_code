use 5.030;
use strict;
use warnings;

my %board;
for (<>) {
    /(\d) st.*: (\d)/;
    $board{ $1 - 1 } = {
        pos   => $2,
        score => 0,
    };
}

my $die    = 1;
my $player = 0;
my $rolled = 0;
while (1) {
    my $roll;
    for ( 1 .. 3 ) {
        $roll += $die++;
        $rolled++;
        $die = 1 if $die > 100;
    }
    my $pos = ( $board{$player}->{pos} + $roll ) % 10;
    $pos = 10 if $pos == 0;
    my $score = $pos;
    $board{$player}->{score} += $score;
    $board{$player}->{pos} = $pos;
    last if $board{$player}->{score} >= 1000;

    $player = ( ++$player % 2 );
}
say $rolled * $board{ ( 1 + $player ) % 2 }->{score};

