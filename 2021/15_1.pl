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

my %costs = ('0:0' => 0);
my @todo = [$start, {}];

while (@todo) {
    my $n = shift(@todo);
    my ($node, $seen) = @$n;
    next if $seen->{$node}++;
    say $node;
    if ($node eq $target) {
        say "AT TARGTE";
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%costs;

        exit;
    }

    my $this_cost = $costs{$node};
    for my $next ($nodes{$node}->@*) {
        my ($loc, $node_cost) = @$next;
        next if $seen->{$loc};
        my $check_cost =  $this_cost + $node_cost;
        if (defined $costs{$loc} && $costs{$loc} > $check_cost ) {
            $costs{$loc} = $check_cost;
        }
        else {
            $costs{$loc} = $check_cost;
        }

        push(@todo,[$loc, $seen]);
    }
}

