use 5.030;
use strict;
use warnings;

my @hex = split(//, $ARGV[0] || <>);
my $bits = join('',map { sprintf("%.4b", hex('0x'.$_)) } @hex);
say $bits;

while ($bits) {
    my $version = oct('0b'.substr($bits,0,3,''));
    my $type_id = oct('0b'.substr($bits,0,3,''));
    say "version $version type_id $type_id";
    if ($type_id  == 4) {
        my $val;
        my $ignore=0;
        while (1) {
            $ignore++;
            my $ind = substr($bits,0,1,'');
            my $this =substr($bits,0,4,'');
            $val.=$this;
            if ($ind == 0) {
                substr($bits,0,$ignore,'');
                last;
            }
        }
        say oct('0b'.$val);
    }

}
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@bits;


__END__
my @diagnostics = map { chomp; [ split(//) ] } <>;

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
    return oct('0b' . ( join( '', $list[0]->@* ) ))
}
