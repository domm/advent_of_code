use strict;
use warnings;
use 5.030;

my @adapters = sort { $a <=> $b } map { chomp; $_ } <>;
unshift(@adapters,0);
push(@adapters,$adapters[-1]+3);
say $adapters[0];
say $adapters[-1];
my %factors = (
    1=>1,
    2=>1,
    3=>2,
    4=>4,
    5=>7
);
my @set=(0);
my $cnt = 1;
for (my $i=0;$i < scalar @adapters;$i++) {
    my $a = $adapters[$i];
    say $a;
    if (($adapters[$i + 1] - $a) == 3) {
        my $size = @set;
        die unless $factors{$size};
        my $factor = $factors{$size};
        $cnt *= $factors{$size};
        say "new set $size factor $factor -> $cnt";
        @set=($a);
    }
    else {
        push (@set, $a);
    }
}
#$cnt *= $factors{scalar @set};
say $cnt;
