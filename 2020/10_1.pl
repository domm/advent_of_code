use strict;
use warnings;
use 5.030;

my @adapters = sort { $a <=> $b } map { chomp; $_ } <>;

my $jolt = 0;
my %jolts=(3=>1);
for my $a (@adapters) {
    my $diff = $a - $jolt;
    say "$jolt to $a: $diff";
    $jolts{$diff}++;
    $jolt = $a;
}

say $jolts{1} * $jolts{3};

