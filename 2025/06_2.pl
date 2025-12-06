#!/usr/env perl

use v5.40;
#use builtin::indexed;

my @in = <>;
my $raw_ops = pop(@in);
chomp($raw_ops);
my @ops=split(//,$raw_ops);
my @sets;
my @calc;
my $cnt=0;
for my ($i, $op) (indexed @ops) {
    if ($op ne ' ') {
        push(@sets, $cnt);
        push(@calc, $op);
        $cnt=0;
    }
    else {
        $cnt++
    }
}
push(@sets, $cnt+1);
shift(@sets);

my @data;
for my $line (@in) {
    chomp($line);
    push(@data, [split(//,$line)]);
}
my $rows = @data;
$rows--;

# fold the numbers
my $pos=0;
my @numbers;
for my ($i, $set) (indexed @sets) {
    for my $c (0 .. $set-1) {
        my $number;
        for my $r (0 .. $rows) {
            $number.=$data[$r][$pos];
        }
        push($numbers[$i]->@*, $number);
        $pos++
    }
    $pos++;
}

# calc
my $sum;
for my ($i, $op) (indexed @calc) {
    my @num = $numbers[$i]->@*;
    my $res = shift(@num);
    for my $num (@num) {
        if ($op eq '+') {
            $res += $num;
        }
        else {
            $res *= $num;
        }
    }
    $sum +=$res;
}
say $sum;

