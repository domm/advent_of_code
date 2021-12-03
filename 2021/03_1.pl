use 5.030;
use strict;
use warnings;
use utf8;

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
my ($γ, $ε)=('0b','0b');
for (@bits) {
    $γ.= $_ > $size ? 1 : 0;
    $ε.= $_ > $size ? 0 : 1;
}
say eval "$γ * $ε";

