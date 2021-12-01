use 5.020;
use strict;
use warnings;
use Clone qw(clone);

my @map = map { chomp; [ split // ] } <>;
my $z   = 0;
my $w   = 0;
my %map;

for ( my $y = 0; $y < @map; $y++ ) {
    my $row = $map[$y];
    for ( my $x = 0; $x < @$row; $x++ ) {
        $map{ join( ':', $w, $z, $y, $x ) } = $row->[$x];
    }
}

my @moves;
for my $mw ( ( -1, 0, 1 ) ) {
    for my $mz ( ( -1, 0, 1 ) ) {
        for my $my ( ( -1, 0, 1 ) ) {
            for my $mx ( ( -1, 0, 1 ) ) {
                push( @moves, [ $mw, $mz, $my, $mx ] )
                unless $mw == 0 && $mz == 0 && $my == 0 && $mx == 0;
            }
        }
    }
}

my $active = 0;
for ( 1 .. 6 ) {
    my %new;
    $active = 0;
    # expand map
    for my $pos ( keys %map ) {
        my ( $w, $z, $y, $x ) = split( /:/, $pos );
        for my $m (@moves) {
            my $init = join( ':', $w + $m->[0], $z + $m->[1], $y + $m->[2], $x + $m->[3] );
            $map{$init} ||= '.';
        }
    }
    # GoL it!
    while ( my ( $pos, $val ) = each %map ) {
        my ( $w, $z, $y, $x ) = split( /:/, $pos );
        my $count = 0;
        for my $m (@moves) {
            my $look  = join( ':', $w + $m->[0], $z + $m->[1], $y + $m->[2], $x + $m->[3] );
            my $check = $map{$look} || '.';
            $count++ if $check eq '#';
        }
        if ( $val eq '#' ) {
            $new{$pos} = ( $count == 2 || $count == 3 ) ? '#' : '.';
        }
        else {
            $new{$pos} = $count == 3 ? '#' : '.';
        }
        $active++ if $new{$pos} eq '#';
    }
    %map = %{ clone( \%new ) };
    say $active;
}

say "final $active";

