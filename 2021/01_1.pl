use 5.030;
use strict;
use warnings;

my $depth = 0;
my $inc=-1;
while (my $reading = <>) {
    chomp($reading);
    say "$depth  - $reading ";
    if ($reading > $depth) {
    $inc++;
    say "    INC $inc";
}
    $depth = $reading;
}
say $inc;
