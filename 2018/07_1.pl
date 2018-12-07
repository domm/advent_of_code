use 5.026;
use List::Util qw(uniqstr);
use strict;
my $steps={};
my $prereq={};
my %start = map {$_=>1} 'A' .. 'Z';
while (<>) {
    my ($before, $after) = $_ =~/ ([A-Z]) .* ([A-Z])/;
    push($steps->{$before}->@*, $after);
    push($prereq->{$after}->@*,$before);
    delete $start{$after};
}

my ($order) = sort keys %start;
delete $start{$order};
while (1) {
    doit( uniqstr sort keys %start, map { $steps->{$_}->@* } keys %start );
}

sub doit {
    my @cands = uniqstr sort @_;
    unless (@cands) {
        say $order;
        exit;
    }
    say "cands: ".join(', ' ,@cands);
    for (my $i=0;$i<@cands;$i++) {
        my $cand = $cands[$i];
        next if $order =~ /$cand/;
        my $prereq = $prereq->{$cand} || [];
        say "candidate: $cand requires " . join('+',@$prereq);
        my $prehit=0;
        foreach my $pr (@$prereq) {
            $prehit++ if $order =~ /$pr/;
        }
        if ($prehit == scalar @$prereq) {
            $order.=splice(@cands,$i,1);
            say "winner is $cand";
            push(@cands, $steps->{$cand}->@*) if $steps->{$cand};
            doit(@cands);
        }

    }
}

