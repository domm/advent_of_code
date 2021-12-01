use strict;
use warnings;
use 5.030;

my @map = map { chomp; [ split // ] } <>;
my $h   = @map;
my $w   = $map[0]->@*;
my $occ = 0;
my $max = 4;
my @around =
    ( [ -1, -1 ], [ -1, 0 ], [ -1, 1 ], [ 0, -1 ], [ 0, 1 ], [ 1, -1 ], [ 1, 0 ], [ 1, 1 ] );

while (1) {
    my @next;
    my $thisocc = 0;
    for ( my $r = 0; $r < $h; $r++ ) {
        for ( my $c = 0; $c < $w; $c++ ) {
            my $new = $next[$r][$c] = gol( \@map, $r, $c );
            $thisocc++ if $new eq '#';
        }
    }
    last if $thisocc == $occ;
    @map = @next;
    $occ = $thisocc;
    say '.';
}
say $occ;

sub gol {
    my ( $map, $r, $c ) = @_;

    my $count = look( $map, $r, $c );
    my $old   = $map[$r][$c];
    return '#' if $old eq 'L' && $count == 0;
    return 'L' if $old eq '#' && $count >= $max;
    return $old;
}

sub look {
    my ( $map, $r, $c ) = @_;
    my $count = 0;
    foreach my $vec (@around) {
        my $m = $r + $vec->[0];
        my $n = $c + $vec->[1];
        next     if $m < 0 || $n < 0 || $m >= $h || $n >= $w;
        $count++ if $map[$m][$n] eq '#';
    }
    return $count;
}
