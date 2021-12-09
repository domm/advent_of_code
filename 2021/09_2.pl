use 5.030;
use strict;
use warnings;

my @map;
my ($r) = 0;
for (<>) {
    chomp;
    my $c = 0;
    for ( split(//) ) {
        $map[$r]->[ $c++ ] = $_;
    }
    $r++;
}

my %sinks;
for ( my $r = 0; $r < @map; $r++ ) {
    for ( my $c = 0; $c < $map[$r]->@*; $c++ ) {
        my $heat  = $map[$r]->[$c];
        my $lower = 0;
        for my $move ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
            my $r2  = $r + $move->[0];
            my $c2  = $c + $move->[1];
            my $val = $map[$r2]->[$c2];
            if ( $r2 < 0 || $c2 < 0 || (not defined $val) || ($heat < $val) ) {
                $lower++;
            }
        }
        if ( $lower == 4 ) {
            $sinks{ $r . ':' . $c } = $heat;
        }
    }
}

my @sizes;
foreach my $sink ( keys %sinks ) {
    my $hit = {};
    walk( split( /:/, $sink ), $hit );
    my $size = scalar keys %$hit;
    push( @sizes, $size );
}

my @sort = sort { $b <=> $a } @sizes;
say $sort[0] * $sort[1] * $sort[2];

sub walk {
    my ( $r, $c, $hit ) = @_;

    my $val = $map[$r]->[$c];
    return if !defined $val || $val == 9;

    $hit->{"$r:$c"}++;
    $map[$r]->[$c] = undef;

    for my $move ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
        my $r2 = $r + $move->[0];
        my $c2 = $c + $move->[1];
        if ( $r2 < 0 || $c2 < 0 ) {
            next;
        }
        walk( $r2, $c2, $hit );
    }
}

