use 5.030;
use strict;
use warnings;

my ($in_stacks, $moves) = split(/\n\n/,join('',<>));

my @stacks;
for my $line (split(/\n/,$in_stacks)) {
    next if $line =~/1/;
    my @line = split(//,$line);
    my $stack = 1;
    for my $crate (@line[1,5,9,13,17,21,25,29,33]) {
        push($stacks[$stack]->@*, $crate) if $crate =~/\w/;
        $stack++;
    }
}

for my $move (split(/\n/,$moves)) {
    my ($cnt, $from, $to) = $move =~/move (\d+) from (\d+) to (\d+)/;
    for (1..$cnt) {
        unshift($stacks[$to]->@*,shift($stacks[$from]->@*));
    }
}

say join('',map { $_->[0]  } @stacks[1 .. $#stacks])

