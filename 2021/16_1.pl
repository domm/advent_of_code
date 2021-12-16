use 5.030;
use strict;
use warnings;

my @hex = split(//, $ARGV[0] || <>);
my $bits = join('',map { sprintf("%.4b", hex('0x'.$_)) } @hex);

my $version_sum=0;

 parse($bits);
 #while ($bits) {
 #    $bits = parse($bits);
 #}
say "vers suym $version_sum";

sub parse {
    my ($bits, $number) = @_;
    my $hit = 0;
    while ($bits) {
        last if $bits=~/^0+$/;
        last if $number && $number == $hit;
        exit unless $bits;
        say $bits;
        my $version = oct('0b'.substr($bits,0,3,''));
        my $type_id = oct('0b'.substr($bits,0,3,''));
        $hit++;
        say "version $version type_id $type_id";
        $version_sum+=$version;
        if ($type_id  == 4) {
            my $val;
            while (1) {
                my $ind = substr($bits,0,1,'');
                my $this =substr($bits,0,4,'');
                $val.=$this;
                if ($ind == 0) {
                    last;
                }
            }
            say oct('0b'.$val);
        }
        else {
            my $length_id = substr($bits,0,1,'');
            if ($length_id == 0) {
                my $total_bits = oct('0b'.substr($bits,0,15,''));
                say "PARSE BY BITS ".$total_bits;
                parse(substr($bits,0,$total_bits,''));
            }
            else {
                my $number_subpackets = oct('0b'.substr($bits,0,11,''));
                say "PARSE NUM $number_subpackets";
                $bits = parse($bits, $number_subpackets );
            }
        }
    }
   return $bits;
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
