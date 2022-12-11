use v5.36;
use strict;
use warnings;

my %monkeys;

my @lines = <>;
my $current =-1;

for my $line (@lines) {
    chomp($line);
    if ($line =~ /Monkey (\d)/) {
        $current = $1;
        $monkeys{$current}={};
    }
    elsif ($line =~ /Starting items: (.*)/) {
        my @items = split(/, /,$1);
        $monkeys{$current}{items} = \@items;
    }
    elsif ($line =~ /Op.*: (.*)/) {
        my $op = $1;
        $op =~s /(new|old)/'$'.$1/eg;
        $monkeys{$current}{op} = $op;
    }
    elsif ($line =~ /divis.*?(\d+)$/) {
        $monkeys{$current}{test} = $1;
    }
    elsif ($line =~ /true.*(\d+)/) {
        $monkeys{$current}{true} = $1;
    }
    elsif ($line =~ /false.*(\d+)/) {
        $monkeys{$current}{false} = $1;
    }
}
my $max = (scalar keys %monkeys )-1;

for my $round (1 .. 20) {
    for my $m ( 0 .. $max) {
        my $op = $monkeys{$m}->{op};
        while (my $old = shift ($monkeys{$m}->{items}->@*)) {
            $monkeys{$m}->{inspect}++;
            my $new;
            eval $monkeys{$m}->{op};
            $new = int($new / 3);
            if ($new % $monkeys{$m}->{test} == 0) {
                push($monkeys{$monkeys{$m}->{true}}->{items}->@*,$new);
            }
            else {
                push($monkeys{$monkeys{$m}->{false}}->{items}->@*,$new);
            }
        }
    }
}

my @inspections = sort {$b <=> $a } map { $_->{inspect} } values %monkeys;

say $inspections[0] * $inspections[1];

