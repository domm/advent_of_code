use 5.020;
use strict;
use warnings;

my ($players, $last ) = @ARGV;
my %score  = map { $_ => 0 } 0 .. $players - 1;
my @m = (0, 2);
my $current = 1;

for my $marble (2 .. $last) {
    if ($marble % 23 == 0) {
        my $player = $marble % $players;
        $score{$player}+=$marble;
        my $prize_pos = ($current - 7) % @m;
        my $prize = splice(@m, $prize_pos, 1);
        $score{$player}+=$prize;
        $current = $prize_pos;
    }
    else {
        my $pos = ($current + 2) % @m;
        splice(@m, $pos, 0, $marble);
        $current = $pos;
    }
}

my $highest=0;
my $winner;
while (my ($elf, $score) = each %score) {
    if ($score > $highest) {
        $winner = $elf;
        $highest = $score;
    }
}

say "Winner is $winner with $highest";


