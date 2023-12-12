use 5.034;
use strict;
use warnings;

use String::Glob::Permute qw( string_glob_permute );

my $total=0;
for my $line (<>) {
    chomp($line);
    my ($fsprings, $frule) = split(/ /,$line);
    my $springs = join('?',map { $fsprings } 1 ..5);
    my $rule = join(',',map { $frule } 1 ..5);

    $springs=~s/\./_/g;
    $springs=~s/\?/{_,#}/g;

    my @matcher;
    for my $i (split(/,/,$rule)) {
        push(@matcher,"#{$i}");
    }
    my $re = '^_*' . join('_+', @matcher) . '_*$';

    my $c=0;
    for my $p (string_glob_permute( $springs )) {
        $c++ if ($p=~/$re/);
    }
    say "$c matches in $line";
    $total+=$c;
}

say "total: $total";
