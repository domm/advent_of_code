use 5.030;
use strict;
use warnings;

use List::Compare;
my %direct = (
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8,
);
my $sum;

for (<>) {
    chomp;
    my ( $first, $second ) = split / \| /;
    my @res;
    for my $read ( sort { length($a) <=> length($b) } split / /, $first ) {
        my $l    = length($read);
        my $cand = [ split( //, $read ) ];
        if ( my $num = $direct{$l} ) {
            $res[$num] = $cand;
        }
        elsif ( $l == 5 ) {
            if ( List::Compare->new( $cand, $res[1] )->get_intersection == 2 ) {
                $res[3] = $cand;
            }
            elsif ( List::Compare->new( $cand, $res[4] )->get_intersection == 3 ) {
                $res[5] = $cand;
            }
            else {
                $res[2] = $cand;
            }
        }
        elsif ( $l == 6 ) {
            if ( List::Compare->new( $cand, $res[1] )->get_intersection == 1 ) {
                $res[6] = $cand;
            }
            elsif ( List::Compare->new( $cand, $res[4] )->get_intersection == 4 ) {
                $res[9] = $cand;
            }
            else {
                $res[0] = $cand;
            }
        }
    }

    my %decode;
    for ( my $i = 0; $i < @res; $i++ ) {
        $decode{ join( '', sort $res[$i]->@* ) } = $i;
    }

    my $output;
    for my $read ( split / /, $second ) {
        my $lookup = join( '', sort split( //, $read ) );
        $output .= $decode{$lookup};
    }
    $sum += $output;
}
say $sum;
