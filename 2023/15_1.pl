use 5.034;
use strict;
use warnings;

my $sum=0;
my $in = <>;
chomp($in);
for (split(/,/,$in)) {
    $sum+=hash($_);
}
say $sum;

sub hash {
    my $string = shift;
    my $v = 0;
    for my $c (split(//,$string)) {
        $v += ord($c);
        $v *= 17;
        $v = $v % 256;
    }
    return $v;
}

