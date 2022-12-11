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
        say join('-',@items);
        $monkeys{$current}{items} = \@items;
    }
    elsif ($line =~ /Op.*: (.*)/) {
        my $op = $1;
        $op =~s /(\w+)/'$'.$1/eg;
        $monkeys{$current}{op} = $op;
    }
    elsif ($line =~ /divis.*(\d+)/) {
        $monkeys{$current}{test} = $1;
    }
    elsif ($line =~ /true.*(\d+)/) {
        $monkeys{$current}{true} = $1;
    }
    elsif ($line =~ /false.*(\d+)/) {
        $monkeys{$current}{false} = $1;
    }
}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%monkeys;




