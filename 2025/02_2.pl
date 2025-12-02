#!/usr/env perl

use v5.40;

my $sum=0;

my @RE;
my ( $re1, $re2);
for my $l (1..5) {
    $re1.= '(\d)';
    $re2.= '\\'.$l;
    my $re = '^'.$re1.$re2.'$';
    push(@RE, qr/$re/);

}

my $re3 = '^(\d)';
for (1..10) {
    $re3.= '\\1';
    my $re3u = $re3.'$';
    push(@RE, qr/$re3u/);
}

push(@RE, qr/^(\d)(\d)\1\2\1\2$/);
push(@RE, qr/^(\d)(\d)\1\2\1\2\1\2$/);
push(@RE, qr/^(\d)(\d)\1\2\1\2\1\2\1\2$/);
push(@RE, qr/^(\d)(\d)(\d)\1\2\3\1\2\3$/);

for my $range (split(/,/,<>)) {
    my ($from, $to) = split(/-/,$range);
    ID: for my $id ($from .. $to) {
        my $l = length($id);
        for my $re (@RE) {
            if ($id =~ /$re/) {
                $sum+=$id;
                next ID;
            }
        }
    }
}

say $sum;
