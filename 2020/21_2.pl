use 5.020;
use strict;
use warnings;

my %food;
my %allergenes;
my %map;
for(<>){
    my ($ii, $ia) = $_=~/^(.*) \(contains (.*?)\)/;
    my @i = split(/ /,$ii);
    my @a = split(/, /,$ia);

    for my $a (@a) {
        $allergenes{$a}++;
        for my $i (@i) {
            $map{$i}{$a}++;
        }
    }
    for (@i) {
        $food{$_}++;
    }
}

my %hits;
while (%allergenes) {
    while (my ($i, $d) = each %map) {
        my @hits = grep { $allergenes{$_} && $d->{$_} == $allergenes{$_} } keys $d->%*;
        if (@hits == 1) {
            $hits{$i} = $hits[0];
            delete $allergenes{$hits[0]};
        }
    }
}
say join(',', sort { $hits{$a} cmp $hits{$b} } keys %hits);

