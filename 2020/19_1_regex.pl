use 5.020;
use strict;
use warnings;

my @in=split(/\n\n/,join('',<>));
my %rules;
for (split(/\n/,$in[0])) {
    my ($token, $rules) = split(/:/);
    $rules =~s/[^ab]//g if ($rules =~/[ab]/);
    $rules{$token}=$rules;
}

my $raw = $rules{0};
while ($raw =~ /\d/) {
    $raw=~s/(\d+)/(?:$rules{$1})/g;
}
$raw=~s/ //g;
my $regex=qr/^$raw$/;

my $hit=0;
for my $l (split(/\n/,$in[1])) {
    $hit++ if $l=~/$regex/;
}
say $hit;

