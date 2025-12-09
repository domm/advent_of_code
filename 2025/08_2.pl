#!/usr/bin/env perl

use v5.40;
use Algorithm::Combinatorics qw(combinations);

my @coords = map { chomp; my @c = split(/,/,$_); { id=>$_, x=>$c[0], y=>$c[1], z=>$c[2] } } <>;

my $iter = combinations(\@coords, 2);
my %dists;
while (my $p = $iter->next) {
    $dists{$p->[0]{id}.':'.$p->[1]{id}} = distance(@$p);
}

my @by_dist = sort { $dists{$a} <=> $dists{$b} } keys %dists;

my %circuits;
my $cid=1;
my $loop = @coords > 30 ? 1000 : 10;
my %cids;
my $i=0;
my $last;
while (1) {
    my $shortest = shift(@by_dist);
    my @boxes = split(/:/,$shortest);
    my $ca = $circuits{$boxes[0]};
    my $cb = $circuits{$boxes[1]};

    printf("connect $shortest a %s b %s", $ca || 'no', $cb || 'no') if $loop == 10;

    if ($ca && !$cb) {
        print "\t".$boxes[0]." is in cir c$ca, other is not" if $loop == 10;
        $circuits{$boxes[1]} = $ca;
        $cids{$ca}++;
    }
    elsif (!$ca && $cb) {
        print "\t".$boxes[1]." is in cir c$cb, other is not" if $loop == 10;
        $circuits{$boxes[0]} = $cb;
        $cids{$cb}++;
    }
    elsif ($ca && $cb && $ca != $cb) {
        print "\tconnect two existing circuits c$ca and c$cb" if $loop == 10;
        # rewire
        for my $b (boxes_of_circuit($cb)) {
            $circuits{$b} = $ca;
        }
        $cids{$ca} += $cids{$cb};
        delete $cids{$cb};
    }
    elsif (!$ca && !$cb) {
        print "\tnew circuit c$cid" if $loop == 10;
        $cids{$cid}++;
        $circuits{$boxes[0]} = $circuits{$boxes[1]} = $cid;
        $cid++;
    }
    print "\n" if $loop == 10;

    # we're done when every coord is part of a circuit
    if (scalar keys %circuits == scalar @coords) {
        $last = \@boxes;
        last;
    }

}
my @p1=split(/,/,$last->[0]);
my @p2=split(/,/,$last->[1]);
say $p1[0] * $p2[0];

sub distance ($f, $t) {
    ($f->{x} - $t->{x})**2 + 
    ($f->{y} - $t->{y})**2 + 
    ($f->{z} - $t->{z})**2
}

sub boxes_of_circuit ($cid) {
    my @boxes;
    while (my ($i, $c) = each %circuits) {
        push(@boxes, $i) if $c == $cid;
    }
    return @boxes
}
