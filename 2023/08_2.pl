use 5.034;
use strict;
use warnings;

my @instructions = split(//,<>);
pop(@instructions);
<>;
my %nodes;
my @locs;
while (<>) {
    s/[^A-Z0-9]+/ /g;
    my ($node, $left, $right) = split(/ /,$_);
    $nodes{$node}={L=>$left, R=>$right};
    push(@locs, $node) if $node=~/A$/;
}

my $cnt = 0;
my @factors;
while (1) {
    my @next;
    my $dir = $instructions[ $cnt % @instructions ];
    for my $l (@locs) {
        my $n = $nodes{$l}->{$dir};
        if ($n=~/Z$/) {
            push(@factors, $cnt +1);
        }
        else {
            push(@next,$n );
        }

    }
    $cnt++;
    last unless @next;
    @locs = @next;
}

use Math::AnyNum qw(lcm);

say lcm(@factors);

