use strict;
use warnings;
use 5.030;

my $count;
my %gq;
my $members=0;
while (<>) {
    chomp;
    if (!$_) {
        count_group();
    }
    else {
        $members++;
        map { $gq{$_}++ } split //;
    }
}

say count_group();

sub count_group {
    my @all_yes = grep { $gq{$_} == $members } keys %gq;
    %gq=();
    $members=0;
    $count += @all_yes;
}

