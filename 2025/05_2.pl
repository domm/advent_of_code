#!/usr/env perl

use v5.40;

my $debug = 0;

my @food;
while (my $db = <>) {
    last unless $db=~/-/;
    my ($f, $t) = $db=~/^(\d+)-(\d+)/;
    push(@food, [$f, $t]);
}

while (1) {
    my $pre = @food;
    @food = merge(@food);
    my $post = @food;
    last if $pre == $post;
}

my $sum = 0;
for my $final (@food) {
    $sum += $final->[1] - $final->[0] + 1;
}
say "SUM $sum";

sub merge {
    my @old = @_;
    my @food;

    for my $range (@old) {
        my ($f, $t ) = @$range;
        say "$f .. $t vs ".join('-',@$range) if $debug;
        my $handled;
        OLD: for my $old (@food) {
            if ($f >= $old->[0] && $f <= $old->[1] && $t >= $old->[0] && $t <= $old->[1]) {
                say "\tis inside, skip" if $debug;
                $handled=1;
            }
            elsif ($f >= $old->[0] && $f <= $old->[1] ) {
                say "\tstart is inside, extend end" if $debug;
                $old->[1] = $t;
                $handled=1;
            }
            elsif ($t >= $old->[0] && $t <= $old->[1] ) {
                say "\tend is inside, extend start" if $debug;
                $old->[0] = $f;
                $handled=1;
            }
            elsif ($f <= $old->[0] && $t >= $old->[1]) {
                say "\tcomplete around" if $debug;
                $old->[0] = $f;
                $old->[1] = $t;
                $handled=1;
            }
            last OLD if $handled
        }
        push(@food, [$f, $t]) unless $handled;
    }
    return @food;
}


