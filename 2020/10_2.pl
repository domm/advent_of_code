use strict;
use warnings;
use 5.030;

my @adapters = sort { $a <=> $b } map { chomp; $_ } <>;
unshift(@adapters,0);
push(@adapters,$adapters[-1]+3);
my @lazy_caterer=(undef,1,1,2,4,7);
my @set=(0);
my $cnt = 1;
for (my $i=0;$i < scalar @adapters;$i++) {
    my $a = $adapters[$i];
    if ($adapters[$i + 1] && ($adapters[$i + 1] - $a) == 3) {
        $cnt *= $lazy_caterer[@set];
        @set=($a);
    }
    else {
        push (@set, $a);
    }
}
say $cnt;
