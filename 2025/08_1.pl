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
my %c2;
my $cid=1;
for (1 .. 1000) {
    my $shortest = shift(@by_dist);
    my @boxes = split(/:/,$shortest);
    my $ca = $circuits{$boxes[0]};
    my $cb = $circuits{$boxes[1]};

    print "connect $shortest" ;# if ($cid == 66 || $cid == 84);;

    if ($ca && !$cb) {
        print "\t".$boxes[0]." is in cir c$ca, other is not" ;#if ($cid == 66 || $cid == 84);
        $circuits{$boxes[1]} = $ca;
        push($c2{$ca}->@*, $boxes[1]);
    }
    elsif (!$ca && $cb) {
        print "\t".$boxes[1]." is in cir c$cb, other is not" ;# if ($cid == 66 || $cid == 84);
        $circuits{$boxes[0]} = $cb;
        push($c2{$cb}->@*, $boxes[0]);
    }
    elsif ($ca && $cb && $ca != $cb) {
        print "\tconnect two existing circuits c$ca and c$cb"; # if ($cid == 66 || $cid == 84);

    if ($ca == 13 && $cb == 11) {
        say "problem";
        say join(' ',@boxes);
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;say Dumper $c2{$boxes[0]};
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;say Dumper $c2{$boxes[1]};
    }

        $circuits{$boxes[0]} = $circuits{$boxes[1]} = $ca;
        push($c2{$ca}->@*, $c2{$cb}->@*);
        for my $a ($c2{$ca}->@*) {
            say "set $a to $ca";
            $circuits{$a} = $ca;
        }
        for my $b ($c2{$cb}->@*) {
            say "set $b to $ca";
            $circuits{$b} = $ca;
        }
        delete $c2{$cb};
    }
    else {
        print "\tnew circuit c$cid";# if ($cid == 66 || $cid == 84);
        $circuits{$boxes[0]} = $circuits{$boxes[1]} = $cid;
        push($c2{$cid}->@*, @boxes);
        $cid++;
    }
    print "\n";
}

my %count;
while (my ($i, $c) = each %circuits) {
    $count{$c}++;
}

my @size = sort { $b <=> $a} values %count;

say $size[0] * $size[1] * $size[2];


sub distance ($f, $t) {
    ($f->{x} - $t->{x})**2 + 
    ($f->{y} - $t->{y})**2 + 
    ($f->{z} - $t->{z})**2
}


