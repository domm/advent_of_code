use 5.030;
use strict;
use warnings;

my %replace = (
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven=>7,
    eight=>8,
    nine=>9,
);
my $matcher = join('|',keys %replace);

my $sum;
while ( my $line = <> ) {
    while ($line =~m /^(.*?)($matcher)/) {
        my $pre = $1;
        my $text = $2;
        my $digit = $replace{$text};
        my $first = substr($text,0,1);
        my $replace = $pre.$first;
        my $with = $pre.$digit;
        $line =~s/$replace/$with/;
    }
    my @digits = grep { /\d/ } split(// ,$line);
    $sum += $digits[0].$digits[-1];
}
say $sum;
