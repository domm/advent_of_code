use 5.030;
use strict;
use warnings;
use Heap::Simple; # for Dijkstra
use List::Util qw(min);

my %map;
my $r=1;
for my $row (<>) {
    chomp($row);
    my $c=1;
    for my $val (split(//,$row)) {
        $map{"$r:$c"} = $val unless $val eq '#';
        $c++;
    }
    $r++;
}
$r--;

my ($start) = grep { $_ =~/^1:/ } keys %map;
my ($stop) = grep { $_ =~/^$r:/ } keys %map;


my @move = ([ -1, 0 ], [ 1, 0 ], [ 0, -1], [ 0, 1 ]);

my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
$todo->insert( [ 0, split(/:/,$start), [], 1] );
my %visited = ( $start => 0 );
while ( $todo->count ) {
    my ( $curcost, $r, $c ) = $todo->extract_top->@*;
    my $id = "$r:$c";

    if ($id eq $stop) {
        say $curcost;
        exit;
    }

    for my $look ( @move ) {
        my $lr  = $r + $look->[0];
        my $lc  = $c + $look->[1];
        my $target = "$lr:$lc";
        next unless $map{$target}; # don't move off the map

        my $cost = ($visited{$id} || 0) + 1;
        if ( !defined $visited{$target} || $visited{$target} > $cost ) {
            $visited{$target} = $cost;
            $todo->insert( [ $cost, $lr, $lc] );
        }
    }
}

#draw();

sub draw {
    for my $x (1 .. $r) {
        for my $y (1 .. $r) {
            print $map{"$x:$y"} || '#';
        }
        print "\n";
    }
}

