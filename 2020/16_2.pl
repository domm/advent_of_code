use 5.020;
use strict;
use warnings;

my @blocks = split(/\n\n/,join('',<>));

my %valid;
for my $rule (split(/\n/,$blocks[0])) {
    $rule=~/(.*?):/;
    my $name = $1;
    my @vals = $rule=~/(\d+-\d+)/g;
    for my $v (@vals) {
        my ($f, $t) = split(/-/,$v);
        for ($f .. $t) {
            push($valid{$_}->@*,$name);
        }
    }
}

my @myticket = split(/\n/,$blocks[1]);
my @myvals = (split(/,/,$myticket[1]));

my @nearby = split(/\n/,$blocks[2]);
shift(@nearby);

my @cols;
my $total=0;
DISCARD: for my $line (@nearby) {
    my @vals = split(/,/,$line);

    for my $c (@vals) {
        next DISCARD unless $valid{$c};
    }
    $total++;
    for (my $i=0;$i<@vals;$i++) {
        push($cols[$i]->@*,$vals[$i]);
    }
}


my %solve;
for (my $i=0;$i<@cols;$i++) {
    my $colvals = $cols[$i];

    my %cand;
    for my $cv (@$colvals) {
        my $valids = $valid{$cv};
        map { $cand{$_}++ } @$valids;
    }
    my %hits;
    while (my ($f,$count) = each %cand) {
        next unless $count eq $total;
        $solve{$f}{$i}=1;
        $solve{$f}{count}++;
    }
}

my %done;
my $result=1;
for my $fld (sort { $solve{$a}{count} <=> $solve{$b}{count} } keys %solve) {
    my $data = $solve{$fld};
    delete $data->{count};
    my ($left) = grep { !$done{$_} } keys %$data;
    $done{$left} = $fld;
    $result *= $myvals[$left] if $fld =~/departure/;
}

say $result;

