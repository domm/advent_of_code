use 5.030;
use strict;
use warnings;

my $signal = $ARGV[0] || <>;
for my $pos (0 .. length($signal)-4) {
    my %seq = map { $_ => 1 } split(//,substr($signal,$pos, 4));
    if (scalar keys %seq == 4) {
        say $pos+4;
        exit;
    }
}

