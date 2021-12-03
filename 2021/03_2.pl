use 5.030;
use strict;
use warnings;

my @diagnostics = map { [ split(//) ] } <>;

say rating( 'oxygen', @diagnostics ) * rating( 'scrubber', @diagnostics );

sub rating {
    my ( $type, @list ) = @_;
    my $pos = 0;
    while ( @list > 1 ) {
        my @hit;
        foreach my $row (@list) {
            my $bit = $row->[$pos];
            push( $hit[$bit]->@*, $row );
        }
        my $next;
        if ( $type eq 'oxygen' ) {
            $next = $hit[0]->@* > $hit[1]->@* ? 0 : 1;
        }
        else {
            $next = $hit[0]->@* <= $hit[1]->@* ? 0 : 1;
        }
        @list = $hit[$next]->@*;
        $pos++;
    }
    my $val = '0b' . ( join( '', $list[0]->@* ) );
    return eval $val;
}
