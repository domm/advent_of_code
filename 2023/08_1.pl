use 5.034;
use strict;
use warnings;

my @instructions = split(//,<>);
pop(@instructions);
<>;
my %nodes;
while (<>) {
    s/[^A-Z]+/ /g;
    my ($node, $left, $right) = split(/ /,$_);
    $nodes{$node}={L=>$left, R=>$right};
}

my $loc = 'AAA';
my $cnt = 0;
while (1) {
    my $i = $cnt % @instructions;
    $loc = $nodes{$loc}->{$instructions[$i]};
    $cnt++;
    last if $loc eq 'ZZZ';
}

say $cnt;
