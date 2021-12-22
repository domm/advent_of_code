use 5.030;
use strict;
use warnings;


my %core;
for (<>) {
    /^(o\w+) x=(.*?),y=(.*?),z=(.*)$/;
    my $op = $1;
    my @x = sort { $a <=> $b } split(/\.\./,$2);
    my @y = sort { $a <=> $b } split(/\.\./,$3);
    my @z = sort { $a <=> $b } split(/\.\./,$4);

    if (grep { $_ > 50 || $_ < -50  } @x, @y, @z) {
        say "ignore $op ".join(' ', @x, @y, @z);
        next;
    }
    say "do ".join(' ', @x, @y, @z);
    for my $x ($x[0] .. $x[1]) {
        for my $y ($y[0] .. $y[1]) {
            for my $z ($z[0] .. $z[1]) {
                $core{"$x:$y:$z"} = $op eq 'on' ? 1 : 0;
            }
        }
    }
}

my $on = 0;
for (values %core) {
    $on++ if $_;
}
say "ON: $on";
