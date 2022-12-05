use 5.030;
use strict;
use warnings;

my ($in_stacks, $moves) = split(/\n\n/,join('',<>));

my @stacks;
for my $line (split(/\n/,$in_stacks)) {
    next if $line =~/1/;
    my $stack = 1;
    my @line = split(//,$line);
    for my $crate (@line[1,5,9,13,17,21,25,29,33]) {
        push($stacks[$stack]->@*, $crate) if $crate =~/\w/;
        $stack++
    }
}

for my $move (split(/\n/,$moves)) {
    my ($cnt, $from, $to) = $move =~/move (\d+) from (\d+) to (\d+)/;
    my @to_move = splice($stacks[$from]->@*,0,$cnt);
    unshift($stacks[$to]->@*,@to_move);
}

say join('',map { $_->[0]  } @stacks[1 .. $#stacks])

