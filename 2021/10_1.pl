use 5.030;
use strict;
use warnings;

my %map = (
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
);
my %score = (
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
);

my %hits;
LINE: for my $line (<>) {
    chomp($line);
    my @stack;
    for my $c ( split( //, $line ) ) {
        if ( $map{$c} ) {
            push( @stack, $c );
        }
        else {
            my $last = pop(@stack);
            if ( $c ne $map{$last} ) {
                $hits{$c}++;
                next LINE;
            }
        }
    }
}

my $points = 0;
while ( my ( $char, $count ) = each %hits ) {
    $points += $score{$char} * $count;
}
say $points;

