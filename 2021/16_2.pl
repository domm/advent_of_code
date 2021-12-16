use 5.030;
use strict;
use warnings;
use List::Util qw(sum product min max );

my $bits = join( '', map { sprintf( "%.4b", hex( '0x' . $_ ) ) } split( //, $ARGV[0] || <> ) );

my $version_sum = 0;
my @total;
parse( $bits, 0, \@total );
say "part 1: $version_sum";
say "part 2: " . $total[0];

sub parse {
    my ( $bits, $number, $vals ) = @_;
    my $hit = 0;
    while ($bits) {
        last if $bits =~ /^0+$/;
        last if $number && $number == $hit;
        my $version = oct( '0b' . substr( $bits, 0, 3, '' ) );
        my $type_id = oct( '0b' . substr( $bits, 0, 3, '' ) );
        $hit++;
        $version_sum += $version;
        if ( $type_id == 4 ) {
            my $acc;
            while (1) {
                my $ind = substr( $bits, 0, 1, '' );
                $acc .= substr( $bits, 0, 4, '' );
                last if $ind == 0;
            }
            push( @$vals, oct( '0b' . $acc ) );
        }
        else {
            my @childvals;
            my $length_id = substr( $bits, 0, 1, '' );
            if ( $length_id == 0 ) {
                my $total_bits = oct( '0b' . substr( $bits, 0, 15, '' ) );
                parse( substr( $bits, 0, $total_bits, '' ), 0, \@childvals );
            }
            else {
                my $number_subpackets = oct( '0b' . substr( $bits, 0, 11, '' ) );
                $bits = parse( $bits, $number_subpackets, \@childvals );
            }
            my $res;
            if ( $type_id == 0 ) {
                $res = sum(@childvals);
            }
            elsif ( $type_id == 1 ) {
                $res = product(@childvals);
            }
            elsif ( $type_id == 2 ) {
                $res = min(@childvals);
            }
            elsif ( $type_id == 3 ) {
                $res = max(@childvals);
            }
            elsif ( $type_id == 5 ) {
                $res = $childvals[0] > $childvals[1] ? 1 : 0;
            }
            elsif ( $type_id == 6 ) {
                $res = $childvals[0] < $childvals[1] ? 1 : 0;
            }
            elsif ( $type_id == 7 ) {
                $res = $childvals[0] == $childvals[1] ? 1 : 0;
            }
            push( @$vals, $res );
        }
    }
    return $bits;
}
