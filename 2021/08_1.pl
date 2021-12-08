use 5.030;
use strict;
use warnings;

my $hit;
for (<>) {
    chomp;
    my ($first,$second)=split/ \| /;
    for my $read (split/ /,$second) {
        my $l = length($read);
        $hit++ if ($l ==2 || $l == 3 || $l ==4 || $l ==7);
    }

}
say $hit;
