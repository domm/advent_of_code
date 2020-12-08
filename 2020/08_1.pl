use strict;
use warnings;
use 5.030;

my @code=map { /^(...) (.*)$/;[$1,$2]}<>;
my %seen;
my $i=0;
my $acc=0;
while(1) {
    my ($op,$val) = $code[$i]->@*;
    say "$i: $op $val : $acc";
    if ($seen{$i}++) {
        say $acc;
        exit;
    }
    if ($op eq 'nop') {
        $i++
    }
    elsif ($op eq 'acc') {
        $acc+=$val;
        $i++
    }
    elsif ($op eq 'jmp') {
        $i+=$val;
    }
}

