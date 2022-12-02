use 5.030;
use strict;
use warnings;

my $points = 0;
my %rps=(
    'A X' => 3+0, # Rock lose scis
    'A Y' => 1+3, # Rock draw r
    'A Z' => 2+6, # Rock win pap
    'B X' => 1+0, # Paper lose r
    'B Y' => 2+3, # Paper draw p
    'B Z' => 3+6, # Paper win s
    'C X' => 2+0, # Scissor lose p
    'C Y' => 3+3, # Scissor draw s
    'C Z' => 1+6, # Scissor Swin r
);
while ( my $play = <> ) {
    chomp($play);
    $points += $rps{$play};
}
say $points
