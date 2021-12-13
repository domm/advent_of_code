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
        splice( @map, $at, 1 );                       # remove the fold
        my @low = splice( @map, $at, @map - $at );    # fold it
        my $r   = @map - @low;                        # make sure the fold aligns
        for my $folded ( reverse @low ) {
            my $c = 0;
            for my $mark (@$folded) {
                $map[$r][$c] = $mark if $mark eq '█';    # rub through
                $c++;
            }
            $r++;
        }
    }
    elsif ( $line =~ /x=(\d+)/ ) {
        my $at = $1;
        my $r  = 0;
        for my $row (@map) {
            splice( @$row, $at, 1 );                          # remove the fold
            my @right = splice( @$row, $at, @$row - $at );    # fold it
            my $c     = @$row - @right;                       # make sure the fold aligns
            for my $mark ( reverse @right ) {
                $map[$r][$c] = $mark if $mark eq '█';         # rub through
                $c++;
            }
            $r++;
        }
    }
}
draw();

sub draw {
    for my $r (@map) {
        say join( '', @$r );
    }
}

