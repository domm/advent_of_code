use strict;
use warnings;
use 5.030;

my $max=0;
while (<STDIN>) {
    tr/FBLR/0101/;
    my $id = eval '0b'.substr($_, 0, 7).' * 8 + 0b'.substr($_, 7, 3);
    $max = $id if $id > $max;
}
say $max;

