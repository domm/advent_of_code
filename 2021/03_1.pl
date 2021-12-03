use 5.030;
use strict;
use warnings;

my @in = <>;
my @bits;
for (@in) {
    chomp;
    my @line = split(//);
    for(my $i=0;$i<@line;$i++) {
        $bits[$i]++ if $line[$i];
    }
}

my $size = int(@in/2);
my ($gamma, $epsilon)=('0b','0b');
for (@bits) {
    $gamma.= $_ > $size ? 1 : 0;
    $epsilon.= $_ > $size ? 0 : 1;
}
say eval "$gamma * $epsilon";

