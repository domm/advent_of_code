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

my $count;
while (my ($i, $d) = each %map) {
    my @r = grep { $d->{$_} >= $allergenes{$_} } keys $d->%*;
    $count+=$food{$i} if @r ==0;
}

say $count;


