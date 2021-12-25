use 5.030;
use strict;
use warnings;

# https://github.com/dphilipson/advent-of-code-2021/blob/master/src/days/day24.rs

my @progs;
my $i = 0;
for (<>) {
    chomp;
    my @line = split / /;
    $i++ if $line[0] eq 'inp';
    push($progs[$i]->@*,\@line);
}

my @stack;
my @rules;
for my $i (1..14) {
    my $prog = $progs[$i];
    my $check = $prog->[5]->[2];
    my $offset = $prog->[15]->[2];
    if ($check > 0) {
        push(@stack,[$i,$offset]);
    }
    else {
        my $old = pop(@stack);
        my $calc = $old->[1] + $check;
        push(@rules, ("[$i] = [".$old->[0]. "] ".($calc>0?'+':'-')." ".abs($calc)));
    }
}

say "and now manually solve the val of each pos:";

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@rules;

