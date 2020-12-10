use strict;
use warnings;
use 5.030;

# https://old.reddit.com/r/adventofcode/comments/kacv5i/2020_day_10_p2_need_some_logic_help_not_specific/gf9nsaf/?context=3

my @lazy_caterer = ( undef, 1, 1, 2, 4, 7 );
my @adapters     = sort { $a <=> $b } 0, map { chomp; $_ } <>;
push( @adapters, $adapters[-1] + 3 );
my @set = 0;
my $res = 1;
my $i   = 1;
for (@adapters) {
    push( @set, $_ );
    if ( ( $adapters[ $i++ ] - $set[-1] ) == 3 ) {
        $res *= $lazy_caterer[ @set - 1 ];
        @set = $set[-1];
    }
}
say $res;
