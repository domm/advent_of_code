use 5.030;
use strict;
use warnings;

# https://github.com/dphilipson/advent-of-code-2021/blob/master/src/days/day24.rs

# read the "code" and store it in 14 chunks (each starting with
# getting one input)

my @progs;
my $i = 0;
for (<>) {
    chomp;
    my @line = split / /;
    $i++ if $line[0] eq 'inp';
    push($progs[$i]->@*,\@line);
}

# go through each code-chunk, and look at line 6 and 16, which contain
# the "check" and the "offset" value, which we can use to build the
# rules for weach position of the code
# see here: https://github.com/dphilipson/advent-of-code-2021/blob/master/src/days/day24.rs

my @stack;
my %rules;
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
        $rules{$i} = [$old->[0],$calc];
    }
}

# now we have rules like
#  '13' => [ 0, -2 ],
# which means that the val at pos 13 has to be the value from pos 0 minus 2
# if we're looking for the highest values, this means that pos 0 has to be 9, and pos 13 has to be 7

# so we can now autosolve this:
my @high=' ';
my @low= ' ';
while (my ($pos, $rule) = each %rules) {
    if ($rule->[1] <= 0) {
        $high[$rule->[0]] = 9;
        $high[$pos] = 9 + $rule->[1];
        $low[$pos]=1;
        $low[$rule->[0]]= 1 - $rule->[1] ;
    }
    else {
        $high[$pos] = 9;
        $high[$rule->[0]] = 9 - $rule->[1];
        $low[$rule->[0]] = 1;
        $low[$pos] = 1 + $rule->[1];
    }
}

say "high: ".join('',@high);
say "low:  ".join('',@low);

