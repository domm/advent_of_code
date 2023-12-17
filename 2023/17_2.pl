use 5.030;
use strict;
use warnings;
use Heap::Simple; # for Dijkstra
use List::Util qw(min);

my %map;
my $r=1;
my $max_c=0;
for my $row (<>) {
    chomp($row);
    my $c=1;
    for my $val (split(//,$row)) {
        $map{"$r:$c"} = $val;
        $c++;
    }
    $max_c=$c;
    $r++;
}
my $start = "1:1";
my $max_r = $r - 1;
$max_c--;

my @move = ([ -1, 0, 'N','S' ], [ 1, 0, 'S','N' ], [ 0, -1, 'W','E'], [ 0, 1, 'E','W' ]);

my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
$todo->insert( [ 0, split(/:/,$start), [], 1] );
my %visited = ( $start => 0 );
my %paths;
while ( $todo->count ) {
    my ( $curcost, $r, $c, $path, $step ) = $todo->extract_top->@*;

    if ($step >=4 && $r == $max_r && $c == $max_c) {
        say "$r:$c = $curcost via ".join('',@$path);
        exit;
    }

    for my $look ( @move ) {
        my $lr  = $r + $look->[0];
        my $lc  = $c + $look->[1];
        my $target = "$lr:$lc";
        next unless $map{$target}; # don't move off the map
        my $dir = $path->[-1] || 'x';
        next if $look->[3] eq $dir; # don't turn straight back

        #say "at $r:$c = $curcost check $target ".join('',@$path);

        my $ldir = $look->[2];

        my $lstep = $ldir eq $dir ? $step+1 : 1;
        next if $lstep > 10;
        next if ($step < 4 && $ldir ne $dir && $dir ne 'x');

        my $cost = ($visited{"$r:$c:$dir:$step"} || 0) + $map{$target};
        if ( !defined $visited{"$target:$ldir:$lstep"} || $visited{"$target:$ldir:$lstep"} > $cost ) {
            $visited{"$target:$ldir:$lstep"} = $cost;
            my @path = @$path;
            push(@path, $ldir);
            $todo->insert( [ $cost, $lr, $lc, \@path, $lstep] );
            $paths{$target.':'.$ldir.':'.$lstep} = \@path;
        }
    }
}

