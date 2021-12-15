use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my @map;
for (<>) {
    chomp;
    push(@map,[split(//,$_)]);
}
my $size = @map - 1;
my %nodes;
my $r=1;
for (my $r=0;$r<=$size;$r++) {
    for (my $c=0;$c<=$size;$c++) {
        my $from = "$r:$c";
        for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
            my $tr = $r+$look->[0];
            my $tc = $c+$look->[1];
            next if $tr < 0 || $tc < 0 || $tr > $size || $tc > $size;
            #say "from $from to $tr:$tc: ". $map[$tr][$tc];
            push($nodes{$from}->@*, ["$tr:$tc", $map[$tr][$tc]]);
        }
    }
}

my $start = "0:0";
my $target = "$size:$size";

my %visited = ('0:0' => 0);
my @todo = [$start, {}];

while (@todo) {
    my $n = shift(@todo);
    my ($node, $seen) = @$n;
    next if $seen->{$node}++;
    say "$node cost: ".$visited{$node} if $node eq '2:2';
    if ($node eq $target) {
        say "AT TARGTE";
        last;
    }

    my $this_cost = $visited{$node};
    for my $next ($nodes{$node}->@*) {
        my ($loc, $node_cost) = @$next;
        next if $seen->{$loc};
        my $check_cost =  $this_cost + $node_cost;
        say "   $loc: $this_cost + $node_cost = $check_cost " if $loc eq '2:2';#.  $costs{$loc};
        if (defined $visited{$loc} && $visited{$loc} >  $check_cost ) {
            $visited{$loc} = $check_cost;
        }
        elsif (!defined $visited{$loc}) {
            $visited{$loc} = $check_cost;
        }

        push(@todo,[$loc, $seen]);
    }
}

say $visited{$target};

