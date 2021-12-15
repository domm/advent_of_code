use 5.030;
use strict;
use warnings;
use Heap::Simple;

my @in  = map { chomp; $_ } <>;
my $dim = @in;
my @map;
for ( my $r = 0; $r < @in; $r++ ) {
    my $line = $in[$r];
    $map[$r]->@* = split( //, $line );
    for ( my $c = 0; $c < @in; $c++ ) {
        for my $er ( 0 .. 4 ) {               # expand map 5 times
            for my $ec ( 0 .. 4 ) {           # in both dimensions
                my $val = $map[$r][$c] + $er + $ec;    # inc value
                $val = $val - 9 if $val > 9;           # downgrade
                $map[ $r + ( $dim * $er ) ][ $c + ( $dim * $ec ) ] = $val;
            }
        }
    }
}

my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
$todo->insert( [ 0, 0, 0, {} ] );
my $border  = $#map;
my %visited = ( '0:0' => 0 );
my %seen;
while ( $todo->count ) {
    my ( undef, $r, $c ) = $todo->extract_top->@*;
    next if $seen{"$r:$c"}++;
    for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
        my $lr  = $r + $look->[0];
        my $lc  = $c + $look->[1];
        my $loc = "$lr:$lc";
        next if $seen{$loc} || $lr < 0 || $lc < 0 || $lr > $border || $lc > $border;
        my $cost = $visited{"$r:$c"} + $map[$lr][$lc];
        if ( !defined $visited{$loc} || $visited{$loc} > $cost ) {
            $visited{$loc} = $cost;
        }
        $todo->insert( [ $visited{$loc}, $lr, $lc ] );
    }
}
say $visited{"$border:$border"};
