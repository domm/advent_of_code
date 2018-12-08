use 5.020;
use strict;
use warnings;

my @s = split(' ',<>);

my $sum;
while (@s) {
    $sum += parse()
}

sub parse {
    my $children = shift(@s);
    my $meta =shift(@s);
    my $val;
    if ($children > 0) {
        my @c;
        foreach my $i (1 .. $children) {
            $c[$i] = parse();
        }
        foreach my $i (1 .. $meta) {
            my $child = shift(@s);
            $val+= $c[$child] if $c[$child];
        }
    } else {
        for (1 .. $meta) {
            $val+= shift(@s);
        }
    }
    return $val;
}

say $sum;
