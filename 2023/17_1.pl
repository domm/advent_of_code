use 5.030;
use strict;
use warnings;
use Heap::Simple; # for Dijkstra

my %map;
my $r=1;
for my $row (<>) {
    chomp($row);
    my $c=1;
    for my $val (split(//,$row)) {
        $map{"$r:$c"} = $val;
        $c++;
    }
    $r++;
}
$r--;
my $start = "1:1";
my $end = "$r:$r";

my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
$todo->insert( [ 0, split(/:/,$start), {} ] );
my %visited = ( $start => 0 );
while ( $todo->count ) {
    my ( undef, $r, $c ) = $todo->extract_top->@*;
    for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
        my $lr  = $r + $look->[0];
        my $lc  = $c + $look->[1];
        my $target = "$lr:$lc";
        next unless $map{$target};

        # TODO: max three straigt steps
        my $cost = $visited{"$r:$c"} + $map{$target};
        if ( !defined $visited{$target} || $visited{$target} > $cost ) {
            $visited{$target} = $cost;
            $todo->insert( [ $visited{$target}, $lr, $lc ] );
        }
    }
}
say $visited{$end};
