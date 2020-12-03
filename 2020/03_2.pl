use strict;
use warnings;
use 5.030;

my @map = map { chomp; [split(//,$_)] } <STDIN>;
my $w = $map[0]->@*;

my @slopes=([1,1],[3,1],[5,1],[7,1],[1,2]);

my $prod=1;
for my $slope (@slopes) {
    my $trees;
    my $c=0;
    my $r=0;
    while (my $pos = $map[$r]->[$c]) {
        $trees++ if $pos eq '#';
        $c = ($c + $slope->[0]) % $w;
        $r += $slope->[1];
    }
    $prod*=$trees;
}
say $prod;

