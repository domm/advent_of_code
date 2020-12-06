use strict;
use warnings;
use 5.030;

my $count;
my %gq;
while (<>) {
    chomp;
    if (!$_) {
        $count += keys %gq;
        %gq=();
    }
    else {
        map { $gq{$_}++ } split //;
    }
}
$count += keys %gq;

say $count;
