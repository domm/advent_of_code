use strict;
use warnings;
use 5.030;

my $count;
my %gq;
my $members=0;
while (<>) {
    chomp();
    my @q = split //;
    if (@q == 0) {
        count_group();
        %gq=();
        $members=0;
    }
    else {
        $members++;
        for (@q) {
            $gq{$_}++;
        }
    }
}

count_group();

say $count;

sub count_group {
    my @all_yes = grep { $gq{$_} == $members } keys %gq;
    $count += @all_yes;
}

