use 5.030;
use strict;
use warnings;

my @hex = split(//, $ARGV[0] || <>);
my $bits = join('',map { sprintf("%.4b", hex('0x'.$_)) } @hex);

my $version_sum=0;
parse($bits);
say "vers suym $version_sum";

sub parse {
    my ($bits, $number) = @_;
    my $hit = 0;
    while ($bits) {
        last if $bits=~/^0+$/;
        last if $number && $number == $hit;
        exit unless $bits;
        my $version = oct('0b'.substr($bits,0,3,''));
        my $type_id = oct('0b'.substr($bits,0,3,''));
        $hit++;
        say "version $version type_id $type_id";
        $version_sum+=$version;
        if ($type_id  == 4) {
            my $acc;
            while (1) {
                my $ind = substr($bits,0,1,'');
                $acc.=substr($bits,0,4,'');
                last if $ind == 0;
            }
            my $val = oct('0b'.$acc);
        }
        else {
            my $length_id = substr($bits,0,1,'');
            if ($length_id == 0) {
                my $total_bits = oct('0b'.substr($bits,0,15,''));
                parse(substr($bits,0,$total_bits,''));
            }
            else {
                my $number_subpackets = oct('0b'.substr($bits,0,11,''));
                $bits = parse($bits, $number_subpackets );
            }
        }
    }
   return $bits;
}
