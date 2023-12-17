use 5.030;
use strict;
use warnings;
use Heap::Simple; # for Dijkstra
use List::Util qw(any);

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

my @move = ([ -1, 0, 'N','S' ], [ 1, 0, 'S','N' ], [ 0, -1, 'W','E'], [ 0, 1, 'E','W' ]);

my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
$todo->insert( [ 0, split(/:/,$start), []] );
my %visited = ( $start => 0 );
my %paths;
while ( $todo->count ) {
    my ( $curcost, $r, $c, $path ) = $todo->extract_top->@*;

    for my $look ( @move ) {
        my $combcost = $curcost;
        for my $off ( 1 .. 3 ) {
            my $lr  = $r + ( $look->[0] * $off);
            my $lc  = $c + ( $look->[1] * $off);
            my $target = "$lr:$lc";
            next unless $map{$target}; # don't move off the map
            my $dir = $path->[-1] || 'x';
            next if $look->[3] eq $dir; # don't turn straight back

            #        if (@$path >= 3) { # don't continue after three straight steps
            #            my $last_three = join('',@$path[-3],@$path[-2],@$path[-1]);
            #            if ($last_three =~ /(NNN|SSS|EEE|WWW)$/) {
            #                next if $path->[-1] eq $look->[2];
            #            };
            #        }
            say "at $r:$c = $curcost check $target ".join('',@$path);

            my $ldir = $look->[2];
            my $cost = ($visited{"$r:$c:$dir"} || 0) + $map{$target};
            $combcost+=$map{$target};
            say "cost is $cost $combcost";
            if ( !defined $visited{$target.':'.$ldir} || $visited{$target.':'.$ldir} > $combcost ) {

                $visited{$target.':'.$ldir} = $combcost;
                my @path = @$path;
                push(@path, $ldir);
                $todo->insert( [ $cost, $lr, $lc, \@path] );
                $paths{$target.':'.$ldir} = \@path;
            }
        }
    }
}

#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%visited;

say  $visited{$end.':S'};
say  $visited{$end.':E'};
say join('',@{$paths{$end.':S'}});
say join('',@{$paths{$end.':E'}});
