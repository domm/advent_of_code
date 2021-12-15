use 5.030;
use strict;
use warnings;

use Heap::Simple;

my @map;
for (<>) {
    chomp;
    push(@map,[split(//,$_)]);
}
my $size = @map ;
my @nmap;
for (my $r = 0;$r<@map;$r++) {
    for (my $c = 0;$c<@map;$c++) {
        for my $er (0 .. 4) {
            for my $ec (0 .. 4) {
                my $val = $map[$r][$c] + $er + $ec;
                $val = $val - 9 if $val > 9;
                $nmap[$r + ($size*$er)][ $c + ($size*$ec)] = $val;
            }
        }
    }
}

@map = @nmap;
$size = @map - 1;
my %nodes;
for (my $r=0;$r<=$size;$r++) {
    for (my $c=0;$c<=$size;$c++) {
        my $from = "$r:$c";
        for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
            my $tr = $r+$look->[0];
            my $tc = $c+$look->[1];
            next if $tr < 0 || $tc < 0 || $tr > $size || $tc > $size;
            push($nodes{$from}->@*, ["$tr:$tc", $map[$tr][$tc]]);
        }
    }
}

my $target = "$size:$size";
my %visited = ('0:0' => 0);

my $todo = Heap::Simple->new(order => "<", elements => [Array => 0]);
$todo->insert([$visited{'0:0'}, '0:0',{}]);

while ( $todo->count) {
    my $n = $todo->extract_top;
    my ($foo, $node, $seen) = @$n;
    next if $seen->{$node}++;

    my $this_cost = $visited{$node};
    for my $next ($nodes{$node}->@*) {
        my ($loc, $node_cost) = @$next;
        next if $seen->{$loc};
        my $check_cost = $this_cost + $node_cost;
        if (defined $visited{$loc} && $visited{$loc} >  $check_cost ) {
            $visited{$loc} = $check_cost;
        }
        elsif (!defined $visited{$loc}) {
            $visited{$loc} = $check_cost;
        }
        $todo->insert([$visited{$loc}, $loc, $seen]);
    }
}

say $visited{$target};
