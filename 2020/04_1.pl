use strict;
use warnings;
use 5.030;

my $in = join('',<STDIN>);
$in =~ s/\n\n/SEP/gm;
$in =~ s/\n/ /g;
$in =~ s/\s/;/g;

my @d = split(/SEP/,$in);
my $valid;
for my $l (@d) {
    my %p = map {  split/:/ } split(/;/, $l);

    $valid++ if (keys %p == 8 || (keys %p == 7 && !$p{cid}));

}

say $valid;

