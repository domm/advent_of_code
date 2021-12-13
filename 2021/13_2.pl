use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my ( $map, $folds ) = split( /\n\n/, join( '', <> ) );
my @map;
my ( $max_r, $max_c ) = ( 0, 0 );
for ( split( /\n/, $map ) ) {
    last unless /\d/;
    my ( $c, $r ) = split(/,/);
    $map[$r][$c] = '█';
    $max_r       = $r if $r > $max_r;
    $max_c       = $c if $c > $max_c;
}

# pad the map
for my $r ( 0 .. $max_r ) {
    for my $c ( 0 .. $max_c ) {
        $map[$r][$c] ||= ' ';
    }
}

for my $line ( split( /\n/, $folds ) ) {
    if ( $line =~ /y=(\d+)/ ) {
        my $at = $1;
        splice( @map, $at, 1 );
        my @low = splice( @map, $at, @map - $at );
        push( @low, [ map {' '} ( 0 .. $max_c ) ] ) if @low != @map;    # danger!
        my $r = 0;
        for my $folded ( reverse @low ) {
            my $c = 0;
            for my $mark (@$folded) {
                $map[$r][$c] = $mark if $mark eq '█';
                $c++;
            }
            $r++;
        }
    }
    elsif ( $line =~ /x=(\d+)/ ) {
        my $at = $1;
        my $r  = 0;
        for my $row (@map) {
            splice( @$row, $at, 1 );
            my @right = splice( @$row, $at, @$row - $at );
            my $c     = 0;
            for my $mark ( reverse @right ) {
                $map[$r][$c] = $mark if $mark eq '█';
                $c++;
            }
            $r++;
        }

    }
}
draw( \@map );

sub draw {
    my $m = shift;
    for my $r (@$m) {
        say join( '', @$r );
    }
}

