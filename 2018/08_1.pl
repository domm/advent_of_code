use 5.020;
use strict;
use warnings;

my @s = split(' ',<>);
my $sum;
while (@s) {
    parse()
}

sub parse {
    my $children = shift(@s);
    my $meta =shift(@s);
    for (1 .. $children) {
        parse();
    }
    for (1 .. $meta) {
        $sum+= shift(@s);
    }
}

say $sum;
