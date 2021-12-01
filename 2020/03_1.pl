use strict;
use warnings;
use 5.030;

my @map = map { chomp; [split(//,$_)] } <STDIN>;
my $w = $map[0]->@*;

my $trees;
my $c=0;
my $r=0;
while (my $pos = $map[$r]->[$c]) {
    $trees++ if $pos eq '#';
    $c = ($c + 3) % $w;
    $r++;
}
say $trees;
