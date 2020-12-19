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

$rules{8} = ' 42 | 42 8 ';
$rules{11} = ' 42 31 | 42 11 31';

my $try=1;
my $hits=-1;
while (1) {
    say "TRY $try";
    my $cnt = 0;
    my $raw = $rules{0};
    while ($raw =~ /\d/) {
        $raw=~s/(\d+)/(?:$rules{$1})/g;
        last if $cnt++ > $try;
    }
    $raw=~s/ //g;
    my $regex=qr/^$raw$/;

    my $hit=0;
    for my $l (split(/\n/,$in[1])) {
        $hit++ if $l=~/$regex/;
    }
    say "got $hit";
    if ($hit) {
        if ($hits == $hit) {
            last;
        }
        $hits = $hit;
    }
    $try++;
}

say "final $hits";

