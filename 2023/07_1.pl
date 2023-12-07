use 5.034;
use strict;
use warnings;
use List::Util qw(max);

my @cards;
while (my $l = <>) {
    my ($set, $bet) = split(/ /, $l);

    my $sort= $set;
    $sort =~ tr/AKQJT/edcba/;

    my %count;
    for (split(//,$set)) {
        $count{$_}++;
    }
    my $max = max(values %count);
    my @sval = reverse sort values %count;
    my $type;
    if ($max == 5) {
        $type='7_five';
    }
    elsif ($max == 4) {
        $type='6_four';
    }
    elsif ($max == 1) {
        $type='1_high_card';
    }
    elsif ($sval[0] == 3 && $sval[1] == 2) {
        $type='5_full_house';
    }
    elsif ($sval[0] == 3 && $sval[1] == 1) {
        $type='4_three';
    }
    elsif ($sval[0] == 2 && $sval[1] == 2) {
        $type='3_two_pair';
    }
    elsif ($sval[0] == 2 && $sval[1] == 1) {
        $type='2_one_pair';
    }

    push(@cards, { set=>$set, bet=>$bet, sort=>$sort, type=>$type });
}



my @sort = sort { $a->{type} cmp $b->{type} || $a->{sort} cmp $b->{sort}  } @cards;

my $total = 0;;
for (my $i=0;$i<@sort;$i++) {
    my $r = $i+1;
    my $c = $sort[$i];
    $total += $r * $c->{bet};
}
say $total;
