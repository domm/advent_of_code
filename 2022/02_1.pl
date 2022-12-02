use 5.030;
use strict;
use warnings;

my $points = 0;
my %rps=(
    'A X' => 1+3, # Rock Rock
    'A Y' => 2+6, # Rock Paper
    'A Z' => 3+0, # Rock Scissor
    'B X' => 1+0, # Paper Rock
    'B Y' => 2+3, # Paper Paper
    'B Z' => 3+6, # Paper Scissor
    'C X' => 1+6, # Scissor Rock
    'C Y' => 2+0, # Scissor Paper
    'C Z' => 3+3, # Scissor Scissor
);
while ( my $play = <> ) {
    chomp($play);
    $points += $rps{$play};
}
say $points
