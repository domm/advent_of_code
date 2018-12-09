use 5.020;
use strict;
use warnings;
use List::Util qw(max);

my ($players, $last ) = @ARGV;
my %score  = map { $_ => 0 } 0 .. $players - 1;
my @circle = (0, 2);
my $prev = 1;

for my $marble (2 .. $last) {
    if ($marble % 23 == 0) {
        my $player = $marble % $players;
        $score{$player}+=$marble;
        my $prize_pos = ($prev - 7) % @circle;
        my $prize = splice(@circle, $prize_pos, 1);
        $score{$player}+=$prize;
        $prev = $prize_pos;
    }
    else {
        my $next = ($prev + 2) % @circle;
        splice(@circle, $next, 0, $marble);
        $prev = $next;
    }
}

say "highscore: ". max values %score;

