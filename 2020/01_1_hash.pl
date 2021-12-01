use 5.030;
use strict;
use warnings;

my %data = map { chomp; $_=>1 } ( <STDIN> );
for my $a (keys %data) {
    my $b = 2020 - $a;
    if ($data{2020 - $a}) {
        die $a*$b."\n";
    }
}
