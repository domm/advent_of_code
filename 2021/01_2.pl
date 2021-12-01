use 5.030;
use strict;
use warnings;

my $depth = 0;
my $inc=-1;
my @readings = map {chomp;$_ } <>;
my @windows;
for(my $i = 0;$i<@readings-2;$i++) {
    my $sum = $readings[$i] + $readings[$i+1] + $readings[$i+2];
    push(@windows,$sum);
}

for my $reading (@windows) {
    if ($reading > $depth) {
    $inc++;
    say "    INC $inc";
}
    $depth = $reading;
}
say $inc;
