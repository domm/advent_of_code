use 5.020;
use strict;
use warnings;

my @in = split(/,/,$ARGV[0]);
my $nth = $ARGV[1] || 2020;
my $t = 0;
my %said = map { $_=>1+$t++ } @in;

my $next = pop(@in);
my $cur;
while ($t <= $nth) {
    $cur = $next;
    $next = $said{$cur} ? $t - $said{$cur} : 0;
    $said{$cur} = $t++;
}
say $cur;

