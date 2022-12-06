use 5.030;
use strict;
use warnings;

my $signal = $ARGV[0] || <>;
for my $pos (0 .. length($signal)-14) {
    my %seq = map { $_ => 1 } split(//,substr($signal,$pos, 14));
    if (scalar keys %seq == 14) {
        say $pos+14;
        exit;
    }
}

