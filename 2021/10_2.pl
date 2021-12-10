use 5.030;
use strict;
use warnings;

my %open = (
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
);
my %score = (
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
);

my @points;
LINE: for my $line (<>) {
    chomp($line);
    my @stack;
    for my $c ( split( //, $line ) ) {
        if ( $open{$c} ) {
            push( @stack, $c );
        }
        else {
            my $last = pop(@stack);
            next LINE if ( $c ne $open{$last} );
        }
    }
    my $points = 0;
    for my $c ( reverse @stack ) {
        $points *= 5;
        $points += $score{ $open{$c} };
    }
    push( @points, $points );
}
my @sorted = sort { $a <=> $b } @points;
say $sorted[ @sorted / 2 ];

